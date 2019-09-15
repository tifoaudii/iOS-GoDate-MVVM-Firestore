
//
//  CardView.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 15/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class CardView: UIView {
   
   let imageView = UIImageView()
   let userLabel = UILabel()
   let imageIndexStackView = UIStackView()
   var cardViewModel: CardVM?
   
   fileprivate let thresshold: CGFloat = 80
   fileprivate let gradientLayer = CAGradientLayer()
   fileprivate var currentIndexImage = 0
   
   var user: User? {
      didSet {
         guard let user = user else {
            return
         }
         self.cardViewModel = CardVM(user: user)
         self.userLabel.attributedText = cardViewModel?.userInformation
         self.imageView.image = cardViewModel?.userImage
         self.setImageIndexBar()
         self.observeImageChanged()
      }
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.setupLayout()
      self.setupPanRecognizer()
      self.setupTapRecognizer()
   }
   
   override func layoutSubviews() {
      //called after CardView's frame has been defined
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
      
      addSubview(imageIndexStackView)
      imageIndexStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 4)
      imageIndexStackView.distribution = .fillEqually
      imageIndexStackView.axis = .horizontal
      imageIndexStackView.spacing = 4
   }
   
   fileprivate func observeImageChanged() {
      guard let cardViewModel = cardViewModel else {
         return
      }
      
      cardViewModel.imageIndexDidChange = { [unowned self] (image, index) in
         self.imageView.image = image
         self.removeIndexStackView()
         self.imageIndexStackView.arrangedSubviews[index].backgroundColor = .white
      }
   }
   
   fileprivate func setImageIndexBar() {
      guard let user = user else {
         return
      }
      
      user.imageUrl.forEach({ [unowned imageIndexStackView] _ in
         let barView = UIView()
         barView.backgroundColor = UIColor(white: 0, alpha: 0.5)
         imageIndexStackView.addArrangedSubview(barView)
      })
      imageIndexStackView.arrangedSubviews[0].backgroundColor = .white
   }
   
   fileprivate func removeIndexStackView() {
      imageIndexStackView.arrangedSubviews.forEach({ $0.backgroundColor = UIColor(white: 0, alpha: 0.1) })
   }
   
   fileprivate func setupTapRecognizer() {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
      addGestureRecognizer(tapGesture)
   }
   
   @objc fileprivate func handleTapGesture(gesture: UITapGestureRecognizer) {
      let tapLocation = gesture.location(in: nil)
      let xValue = tapLocation.x
      
      guard let cardViewModel = cardViewModel else {
         return
      }
      
      if xValue > imageView.frame.width / 2 {
         cardViewModel.nextImageIndex()
      } else {
         cardViewModel.prevImageIndex()
      }
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



