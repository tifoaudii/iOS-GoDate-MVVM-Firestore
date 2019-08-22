//
//  HomeControlStackView.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 14/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class HomeControlStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        let buttonSubview = [#imageLiteral(resourceName: "refresh_circle"),#imageLiteral(resourceName: "dismiss_circle"),#imageLiteral(resourceName: "super_like_circle"),#imageLiteral(resourceName: "like_circle"),#imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            return button
        }
        
        buttonSubview.forEach({
            addArrangedSubview($0)
        })
        
        distribution = .fillEqually
    }
}
