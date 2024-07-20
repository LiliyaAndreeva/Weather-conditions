//
//  CellModel.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 17.07.2024.
//

import UIKit

/// Модель для представления данных ячейки с погодными условиями.
struct CellModel {

	/// Изображение, представляющее погодные условия.
	let image: UIImage
	/// Текстовое описание погодных условий.
	let text: String

	/// Статический метод для получения массива объектов CellModel.
	/// - Returns: Массив объектов CellModel, представляющих различные погодные условия.
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


/// Протокол для получения данных моделей ячеек.
protocol CellModelProvider {
	/// Метод для получения данных ячеек.
	/// - Returns: Массив объектов CellModel.
  func fetchCellData() -> [CellModel]
}

class CellModelProviderImpl: CellModelProvider {
  func fetchCellData() -> [CellModel] {
	return CellModel.fetchCell()
  }
}
