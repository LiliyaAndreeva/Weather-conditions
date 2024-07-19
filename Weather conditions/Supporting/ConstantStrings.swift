//
//  ConstantStrings.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 17.07.2024.
//

import Foundation
enum ConstantStrings {
	
	static let cellIdentifier = "CustomCollectionViewCell"
	
	enum WeatherConditions {
		static let sunny = "Sunny".localized()
		static let snow = "Snow".localized()
		static let rain = "Rain".localized()
		static let cloudy = "Cloudy".localized()
		static let rainy = "Raine".localized()
		static let windy = "Windy".localized()
		static let storm = "Storm".localized()
		static let mainlyСloudy = "Gray".localized()
	}
	
	enum numberConstant {
		static let cellPerRow = 3
		static let zero: Double = 0
		
		enum constantForAnimation {
			static let numberOfPulse: Float = 3
			static let animationDuration: Double = 0.8
		}
	}
	
	enum ImageName {
		static let first = "1"
		static let second = "2"
		static let third = "3"
		static let fourth = "4"
		static let fifth = "5"
		static let sixth = "6"
		static let seventh = "7"
		static let eighth = "8"
	}
	
	enum AnimationKeyPath {
		static let transformScaleXY = "trasform.scale.xy"
		static let transformScale = "trasform.scale"
		static let opacityAnimation = "opacity"
		static let animationgroupKey = "pulse"
	}
}
