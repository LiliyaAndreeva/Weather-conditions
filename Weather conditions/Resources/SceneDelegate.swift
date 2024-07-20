//
//  SceneDelegate.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 16.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		let viewController = assemblyMainScreen()
		window.rootViewController = viewController

		window.makeKeyAndVisible()

		self.window = window
	}
}

func assemblyMainScreen() -> UIViewController {
	let viewController = MainViewController()
	let cellModelProvader = CellModelProviderImpl()
	let presenter = Presenter(view: viewController, cellModelProvider: cellModelProvader)
	viewController.presenter = presenter
	return viewController
}
