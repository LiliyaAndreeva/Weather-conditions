//
//  CustomCollectionViewItem.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 16.07.2024.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {

	// MARK: - Private properties
	static let identifier = ConstantStrings.cellIdentifier

	lazy var imageView: UIImageView = setupImageView()
	private lazy var textLabel: UILabel = setupLabel()

	// MARK: - Public methods
	func configure(with cellModel: CellModel) {
		imageView.image = cellModel.image 
		textLabel.text = cellModel.text
		setupUI()
	}

	// MARK: - Override funcs
	override func prepareForReuse() {
		super.prepareForReuse()
		self.imageView.image = nil
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = Sizes.cornerRadius
		clipsToBounds = true
	}
}

// MARK: - Settings view
private extension CustomCollectionViewCell {
	func setupUI() {
		self.backgroundColor = CustomColors.primary
		addSubviews()
		setupLayout()
	}
}

// MARK: - Settings
private extension CustomCollectionViewCell {
	func addSubviews(){
		[imageView, textLabel].forEach { subViews in
			self.addSubview(subViews)
		}
	}

	func setupImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		
		return imageView
	}

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
