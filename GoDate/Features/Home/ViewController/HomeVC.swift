//
//  HomeVC.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 14/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {
    
    //MARK:- View Objects Here
    let homeControlStackView = HomeControlStackView()
    let topNavigationStackView = TopNavigationStackView()
    
    let cardView: UIView = {
        let view = UIView()
        return view
    }()

    //MARK:- View Controller lifecycles Here
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLayout()
    }
    
    //MARK:- Fileprivate Methods Here
    fileprivate func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [topNavigationStackView, cardView, homeControlStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        view.addSubview(stackView)
        
        let cardImageView = CardView(frame: .zero)
        cardView.addSubview(cardImageView)
        cardImageView.anchor(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: cardView.bottomAnchor, right: cardView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        stackView.bringSubviewToFront(cardView)
    }
}
