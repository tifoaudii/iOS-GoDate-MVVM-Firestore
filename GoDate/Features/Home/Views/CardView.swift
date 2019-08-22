
//
//  CardView.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 15/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class CardView: UIView {
	
	let imageView = UIImageView(image: #imageLiteral(resourceName: "ayo-ogunseinde-RrD8ypt8cjY-unsplash"))
	let userLabel = UILabel()
	
	fileprivate let thresshold: CGFloat = 80
	fileprivate let gradientLayer = CAGradientLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setupLayout()
		self.setupPanRecognizer()
	}
	
	override func layoutSubviews() {
		//called after CardView had been instatiated
		self.gradientLayer.frame = self.frame
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupGradientLayer() {
		gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
		gradientLayer.locations = [0.5, 1.1]
		self.layer.addSublayer(gradientLayer)
	}
	
	fileprivate func setupLayout() {
		addSubview(imageView)
		imageView.fillSuperview()
		imageView.contentMode = .scaleAspectFill
		layer.cornerRadius = 10
		clipsToBounds = true
		
		self.setupGradientLayer()
		
		addSubview(userLabel)
		userLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 16, paddingRight: 0, width: 0, height: 0)
		userLabel.textAlignment = .left
		userLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		userLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
		userLabel.numberOfLines = 2
	}
	
	fileprivate func setupPanRecognizer() {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
		addGestureRecognizer(panGesture)
	}
	
	@objc fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .began:
			self.onTransformBegan()
		case .changed:
			self.onTransformChanged(gesture)
		case .ended:
			self.onTransformEnded(gesture)
		default:
			break
		}
	}
	
	fileprivate func onTransformBegan() {
		self.superview?.subviews.forEach({
			$0.layer.removeAllAnimations()
		})
	}
	
	fileprivate func onTransformChanged(_ gesture: UIPanGestureRecognizer) {
		let translation = gesture.translation(in: nil)
		let degree : CGFloat = translation.x / 20
		let angle = degree * .pi / 180
		let rotation = CGAffineTransform(rotationAngle: angle)
		self.transform = rotation.translatedBy(x: translation.x, y: translation.y)
	}
	
	fileprivate func onTransformEnded(_ gesture: UIPanGestureRecognizer) {
		let shouldDismissCard: Bool = gesture.translation(in: nil).x > thresshold || gesture.translation(in: nil).x < -thresshold
		
		UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: { [unowned self] in
			if shouldDismissCard {
				let transformX: CGFloat = (gesture.translation(in: nil).x > self.thresshold) ? 1000: -1000
				self.frame = CGRect(x: transformX, y: 0, width: self.frame.width, height: self.frame.height)
			} else {
				self.transform = .identity
			}
			}, completion: { [unowned self] (_) in
				self.transform = .identity
				if shouldDismissCard {
					self.removeFromSuperview()
				}
		})
	}
}
