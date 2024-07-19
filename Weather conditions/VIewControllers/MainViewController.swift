//
//  ViewController.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 16.07.2024.
//

import UIKit

final class MainViewController: UIViewController {

	// MARK: - Private properties
	private var cellItems: [CellModel] = []
	private lazy var collectionView: UICollectionView = setupCollectionView()
	private var currentPulseLayer: CALayer?

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		collectionView.dataSource = self
		collectionView.delegate = self
		changeRandomCell()

	}
}

// MARK: - Settings View
private extension MainViewController {

	func setupView(){
		view.backgroundColor = .white
		addSubView()
		setupLayout()
		fetchCellData()
	}

}
// MARK: - Settings
private extension MainViewController {

	func addSubView(){
		view.addSubview(collectionView)
	}

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

	func fetchCellData(){
		cellItems = CellModel.fetchCell()
	}

	func addPulseAnimation(image: UIImage, layer: CALayer) {
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

	func changeRandomCell() {
		if !cellItems.isEmpty {
			let randomIndex = Int.random(in: 0..<cellItems.count)
			let selectedCellModel = cellItems[randomIndex]
			addPulseAnimation(image: selectedCellModel.image, layer: view.layer)
		}
	}
}



// MARK: - Layout
extension MainViewController {
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
		cellItems.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CustomCollectionViewCell.identifier,
			for: indexPath
		) as? CustomCollectionViewCell else { return UICollectionViewCell() }

		let cellModel = cellItems[indexPath.row]
		cell.configure(with: cellModel)

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		guard let selectedCell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
		currentPulseLayer?.removeAllAnimations()
		currentPulseLayer?.removeFromSuperlayer()
		addPulseAnimation(image: selectedCell.imageView.image!, layer: selectedCell.layer)
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
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		Sizes.Padding.half
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
