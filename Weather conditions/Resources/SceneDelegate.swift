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

		let viewController = MainViewController()
		window.rootViewController = viewController

		window.makeKeyAndVisible()

		self.window = window
	}
}
