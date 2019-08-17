//
//  CardView.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 15/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "jodyhongfilms-GBgp6Iy16lc-unsplash"))
    fileprivate let thresshold: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupPanRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    fileprivate func setupPanRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
           self.onTransformChanged(gesture)
        case .ended:
            self.onTransformEnded(gesture)
        default:
            break
        }
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
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: { [unowned self] in
            if shouldDismissCard {
                let transformX: CGFloat = (gesture.translation(in: nil).x > self.thresshold) ? 1000: -1000
                self.frame = CGRect(x: transformX, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        }, completion: { (_) in
            self.transform = .identity
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        })
    }
}
