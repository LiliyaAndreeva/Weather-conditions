//
//  Pulse.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 18.07.2024.
//

import UIKit
final class Pulse: CALayer {

	// MARK: - Public properties
	var animationGroup = CAAnimationGroup()
	var initialPulseScale: Float = 0
	var nextPulseAfter: TimeInterval = 0
	var animationDuration: TimeInterval = 0
	var numberOfPulse: Float = Float.infinity

	override init(layer: Any) {
		super.init(layer: layer)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

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
	private func createScaleAnimation() -> CABasicAnimation {
		let scaleAnimation = CABasicAnimation(keyPath: ConstantStrings.AnimationKeyPath.transformScaleXY)
		scaleAnimation.fromValue = initialPulseScale
		scaleAnimation.toValue = 1
		scaleAnimation.duration = animationDuration

		return scaleAnimation
	}

	
	private func createOpacityAnimation() -> CAKeyframeAnimation {
		let opacityAnimation = CAKeyframeAnimation(keyPath: ConstantStrings.AnimationKeyPath.opacityAnimation)
		opacityAnimation.duration = animationDuration
		opacityAnimation.values = [0, 0.75, 1]
		opacityAnimation.keyTimes = [0, 1, 0]

		return opacityAnimation
	}

	private func setupAnimationGroup() {
		self.animationGroup.duration = animationDuration + nextPulseAfter
		self.animationGroup.repeatCount = numberOfPulse
		let defaultCurve = CAMediaTimingFunction(name: .easeInEaseOut)
		self.animationGroup.timingFunction = defaultCurve

		self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
	}

}
