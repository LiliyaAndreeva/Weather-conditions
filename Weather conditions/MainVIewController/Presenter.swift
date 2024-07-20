//
//  Presenter.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 19.07.2024.
//

import UIKit

/// Протокол, определяющий методы для Презентера.
protocol IPresenter {
	/// Вызывается, когда представление готово к отображению. Получает данные ячеек и отображает представление.
	func viewIsReady()
	/// Вызывается при выборе ячейки в коллекции.
	/// - Параметры:
	///   - indexPath: Индекс выбранной ячейки.
	///   - customCellLayer: Слой выбранной ячейки для анимации.
	func didCellSelected(at indexPath: IndexPath, customCellLayer: CALayer)
}

/// Класс Презентер, который обрабатывает бизнес-логику и взаимодействует между представлением и моделью.
final class Presenter: IPresenter {
	// MARK: - Private property

	// MARK: - Dependencies
	/// Слабая ссылка на контроллер представления, соответствующий IMainViewController.
	private weak var view: IMainViewController!
	/// Провайдер для получения данных модели ячейки.
	private let cellModelProvider: CellModelProvider
	private var cellModels: [CellModel] = []

	// MARK: - Initialization
	/// Инициализирует Презентер с представлением и провайдером моделей ячеек.
		/// - Параметры:
		///   - view: Контроллер представления, который соответствует протоколу IMainViewController.
		///   - cellModelProvider: Провайдер, отвечающий за получение данных ячеек.
	init(view: IMainViewController!, cellModelProvider: CellModelProvider) {
		self.view = view
		self.cellModelProvider = cellModelProvider
	}

	// MARK: - Public methods

	func viewIsReady() {
		cellModels = cellModelProvider.fetchCellData()
		view.render(with: cellModels)
	}

	func didCellSelected(at indexPath: IndexPath, customCellLayer: CALayer) {
		guard indexPath.row < cellModels.count else { return }
		let selectedCellModel = cellModels[indexPath.row]
		view.hideCurrentPulseAnimation()
		view.showPulseAnimation(image: selectedCellModel.image, layer: customCellLayer)
	}
}
