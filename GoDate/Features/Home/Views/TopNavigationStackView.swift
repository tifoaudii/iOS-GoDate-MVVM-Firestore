//
//  TopNavigationStackView.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 14/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let topSubview = [#imageLiteral(resourceName: "top_left_profile"),#imageLiteral(resourceName: "app_icon"),#imageLiteral(resourceName: "top_right_messages")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        topSubview.forEach({
            addArrangedSubview($0)
        })
        
        distribution = .fillEqually
    }
}
