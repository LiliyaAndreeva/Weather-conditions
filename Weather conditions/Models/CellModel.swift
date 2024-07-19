//
//  CellModel.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 17.07.2024.
//

import UIKit

struct CellModel {
	let image: UIImage
	let text: String
	
	static func fetchCell() -> [CellModel] {
		let cellItems = [
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.first)!,
				text: ConstantStrings.WeatherConditions.sunny
			),
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.second)!,
				text: ConstantStrings.WeatherConditions.snow
			),
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.third)!,
				text: ConstantStrings.WeatherConditions.rain
			),
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.fourth)!,
				text: ConstantStrings.WeatherConditions.cloudy
			),
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.fifth)!,
				text: ConstantStrings.WeatherConditions.rainy
			),
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.sixth)!,
				text: ConstantStrings.WeatherConditions.windy
			),
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.seventh)!,
				text: ConstantStrings.WeatherConditions.storm
			),
			CellModel(
				image: UIImage(named: ConstantStrings.ImageName.eighth)!,
				text: ConstantStrings.WeatherConditions.mainlyСloudy
			)
			]
		return cellItems
	}
}
