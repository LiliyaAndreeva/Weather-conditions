//
//  CustomCollectionViewItem.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 16.07.2024.
//

import UIKit

/// Класс для кастомной ячейки коллекции, отображающей изображение и текст.
final class CustomCollectionViewCell: UICollectionViewCell {

	// MARK: - Private properties
	/// Идентификатор ячейки для переиспользования.
	static let identifier = ConstantStrings.cellIdentifier
	
	/// Изображение, отображаемое в ячейке.
	lazy var imageView: UIImageView = setupImageView()
	/// Лейбл для отображения текста.
	private lazy var textLabel: UILabel = setupLabel()

	// MARK: - Public methods
	/// Настройка ячейки с использованием модели данных.
	/// - Parameter cellModel: Модель данных для настройки ячейки.
	func configure(with cellModel: CellModel) {
		imageView.image = cellModel.image 
		textLabel.text = cellModel.text
		setupUI()
	}

	// MARK: - Override funcs
	/// Подготовка ячейки к повторному использованию.
	override func prepareForReuse() {
		super.prepareForReuse()
		self.imageView.image = nil
	}

	/// Настройка отображения ячейки.
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = Sizes.cornerRadius
		clipsToBounds = true
	}
}

// MARK: - Settings view
private extension CustomCollectionViewCell {
	/// Метод настройки UI кастомной ячейки.
	func setupUI() {
		self.backgroundColor = CustomColors.primary
		addSubviews()
		setupLayout()
	}
}

// MARK: - Settings
private extension CustomCollectionViewCell {
	/// Добавление сабвью в ячейку.
	func addSubviews(){
		[imageView, textLabel].forEach { subViews in
			self.addSubview(subViews)
		}
	}
	
	/// Настройка изображения.
	/// - Returns: Настроенное UIImageView.
	func setupImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		
		return imageView
	}
	
	/// Настройка лэйбла
	/// - Returns: Настроенный UILabel.
	func setupLabel() -> UILabel {
		let label = UILabel()
		label.textColor = .white
		label.font = .systemFont(ofSize: Sizes.textSizes.normal)
		label.textAlignment = .center
		return label
	}
}

// MARK: - Setup layout
private extension CustomCollectionViewCell {
	/// Настройка констрейнтов для сабвью в ячейке
	func setupLayout() {
		[imageView, textLabel].forEach { view in
			view.translatesAutoresizingMaskIntoConstraints = false
		}

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: self.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Sizes.multiplier),

			textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
			textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
