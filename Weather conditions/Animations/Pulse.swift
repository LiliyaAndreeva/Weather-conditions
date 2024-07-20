//
//  Pulse.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 18.07.2024.
//

import UIKit

/// Пользовательский подкласс CALayer, создающий эффект пульсирующей анимации.
final class Pulse: CALayer {

	// MARK: - Public properties
	/// Группа анимации, содержащая анимацию масштаба и непрозрачности.
	var animationGroup = CAAnimationGroup()
	/// Начальный масштаб анимации пульса.
	var initialPulseScale: Float = 0
	/// Интервал времени ожидания перед запуском следующего импульса.
	var nextPulseAfter: TimeInterval = 0
	/// Длительность анимации каждого импульса.
	var animationDuration: TimeInterval = 0
	/// Количество импульсов для анимации. По умолчанию бесконечен.
	var numberOfPulse: Float = Float.infinity

	override init(layer: Any) {
		super.init(layer: layer)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/// Инициализирует новый слой Pulse с указанными параметрами.
	/// - Параметры:
	/// - NumberOfPulse: количество импульсов для анимации. По умолчанию бесконечен.
	/// - радиус: радиус анимации пульса.
	/// - позиция: позиция импульса в координатном пространстве слоя.
	/// - BackgroundImage: изображение, которое будет использоваться в качестве фона для пульса.
	init(
		numberOfPulse: Float = Float.infinity,
		radius: CGFloat,
		position: CGPoint,
		backgroundImage: UIImage
	) {
		super.init()
		self.contents = backgroundImage.cgImage
		self.contentsScale = UIScreen.main.scale
		self.opacity = 0
		self.numberOfPulse = numberOfPulse
		self.position = position
		self.bounds = CGRect(
			x: 0,
			y: 0,
			width: UIScreen.main.bounds.width,
			height: UIScreen.main.bounds.height
		)
		DispatchQueue.global(qos: .default).async {
			self.setupAnimationGroup()
			DispatchQueue.main.async {
				self.add(self.animationGroup, forKey: ConstantStrings.AnimationKeyPath.animationgroupKey)
			}
		}
	}

	// MARK: - Private methods
	/// Создает  анимацию для эффекта пульса.
	/// — Возвращает: CABasicAnimation, настроенный для масштабирования.
	private func createScaleAnimation() -> CABasicAnimation {
		let scaleAnimation = CABasicAnimation(keyPath: ConstantStrings.AnimationKeyPath.transformScaleXY)
		scaleAnimation.fromValue = initialPulseScale
		scaleAnimation.toValue = 1
		scaleAnimation.duration = animationDuration

		return scaleAnimation
	}

	// Создает анимацию непрозрачности для эффекта пульса.
	/// — Возвращает: CAKeyframeAnimation, настроенный для изменения непрозрачности.
	private func createOpacityAnimation() -> CAKeyframeAnimation {
		let opacityAnimation = CAKeyframeAnimation(keyPath: ConstantStrings.AnimationKeyPath.opacityAnimation)
		opacityAnimation.duration = animationDuration
		opacityAnimation.values = [0, 0.75, 1]
		opacityAnimation.keyTimes = [0, 1, 0]

		return opacityAnimation
	}

	/// Устанавливает группу анимации с анимацией масштаба и непрозрачности.
	private func setupAnimationGroup() {
		self.animationGroup.duration = animationDuration + nextPulseAfter
		self.animationGroup.repeatCount = numberOfPulse
		let defaultCurve = CAMediaTimingFunction(name: .easeInEaseOut)
		self.animationGroup.timingFunction = defaultCurve

		self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
	}

}
