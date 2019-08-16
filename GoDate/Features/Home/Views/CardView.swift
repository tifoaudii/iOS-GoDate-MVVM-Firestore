//
//  CardView.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 15/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "jodyhongfilms-GBgp6Iy16lc-unsplash"))

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
            let translation = gesture.translation(in: nil)
            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            self.onTransformEnded()
        default:
            break
        }
    }
    
    fileprivate func onTransformEnded() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }, completion: nil)
    }
}
