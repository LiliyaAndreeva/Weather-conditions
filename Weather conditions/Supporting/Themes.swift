//
//  Sizes.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 16.07.2024.
//

import UIKit

enum Sizes {

	static let cornerRadius: CGFloat = 15
	static let multiplier: CGFloat = 0.8

	enum Padding {
		static let half: CGFloat = 8
		static let normal: CGFloat = 16
		static let double: CGFloat = 32
		static let maximum: CGFloat = 300
	}

	enum textSizes {
		static let half: CGFloat = 8
		static let normal: CGFloat = 20
		static let double: CGFloat = 32
	}
}

enum CustomColors {
	static let primary = UIColor.init(
		red: 0.91,
		green: 0.79,
		blue: 0.89,
		alpha: 1
	)
}
