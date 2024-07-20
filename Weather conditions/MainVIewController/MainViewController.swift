//
//  ViewController.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 16.07.2024.
//

import UIKit
protocol IMainViewController: AnyObject {
	/// Метод отрисовки информации на экране
	/// - Parameters: 
	///   - viewData: данные для отрисовки на экране
	func render(with cellModels: [CellModel])
	/// Добавление анимации пульсации.
	/// - Parameters:
	///   - image: Изображение для анимации.
	///   - layer: Слой, к которому будет добавлена анимация.
	func showPulseAnimation(image: UIImage, layer: CALayer)
	/// Метод для скрытия текущей анимации пульсации.
	func hideCurrentPulseAnimation()
}

final class MainViewController: UIViewController {
	
	// MARK: - Dependencies
	var presenter: IPresenter?

	// MARK: - Private properties
	/// Массив объектов CellModel, представляющих данные для ячеек.
	var viewData: [CellModel] = []
	/// Коллекция для отображения погодных условий.
	private lazy var collectionView: UICollectionView = setupCollectionView()
	/// Текущий слой анимации пульсации.
	private var currentPulseLayer: CALayer?

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		presenter?.viewIsReady()
		collectionView.dataSource = self
		collectionView.delegate = self
		chooseRandomCell()
	}
}

// MARK: - Settings View
private extension MainViewController {
	/// Метод для настройки предтавления супер вью
	func setupView(){
		view.backgroundColor = .white
		addSubView()
		setupLayout()
	}
}
// MARK: - Settings
private extension MainViewController {
	/// Метод для добавления сабвью на супер вью
	func addSubView(){
		view.addSubview(collectionView)
	}

	/// Настройка коллекции.
	func setupCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(
			CustomCollectionViewCell.self,
			forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
		)
		collectionView.showsHorizontalScrollIndicator = false

		return collectionView
	}

	/// Выбор случайной ячейки для анимации пульсации.
	func chooseRandomCell() {
		if !viewData.isEmpty {
			let randomIndex = Int.random(in: 0..<viewData.count)
			let selectedCellModel = viewData[randomIndex]
			showPulseAnimation(image: selectedCellModel.image, layer: view.layer)
		}
	}
}


// MARK: - Layout
extension MainViewController {
	/// Настройка констрейнтов для коллекции.
	func setupLayout() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: quarterOfTheScreenWidth),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: halfOfWidth)
		])
	}
	var quarterOfTheScreenWidth: Double {
		return view.frame.width / 4.0
	}

	var halfOfWidth: Double {
		return view.frame.width / 2.0
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewData.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CustomCollectionViewCell.identifier,
			for: indexPath
		) as? CustomCollectionViewCell else { return UICollectionViewCell() }

		let cellModel = viewData[indexPath.row]
		cell.configure(with: cellModel)

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		guard let selectedCell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
		presenter?.didCellSelected(at: indexPath, customCellLayer: selectedCell.layer)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {

		let cellSpacing = Int(Sizes.Padding.half)
		let cellsPerRow = ConstantStrings.numberConstant.cellPerRow
		let itemWidth = (Int(collectionView.frame.width) - cellSpacing * (cellsPerRow - 1)) / cellsPerRow
		let itemHeight = Int(collectionView.frame.height)

		return CGSize(width: itemWidth, height: itemHeight)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(
			top: ConstantStrings.numberConstant.zero,
			left: Sizes.Padding.half,
			bottom: ConstantStrings.numberConstant.zero,
			right: Sizes.Padding.half
		)
	}
}

extension MainViewController: IMainViewController {
	func render(with cellModels: [CellModel]) {
		self.viewData = cellModels
		collectionView.reloadData()
	}

	func showPulseAnimation(image: UIImage, layer: CALayer) {
		let pulse = Pulse(
			numberOfPulse: ConstantStrings.numberConstant.constantForAnimation.numberOfPulse,
			radius: UIScreen.main.bounds.width,
			position: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2),
			backgroundImage: image
		)
		pulse.animationDuration = ConstantStrings.numberConstant.constantForAnimation.animationDuration
		self.view.layer.insertSublayer(pulse, below: layer)
		currentPulseLayer = pulse
	}

	func hideCurrentPulseAnimation() {
		currentPulseLayer?.removeAllAnimations()
		currentPulseLayer?.removeFromSuperlayer()
	}
}
