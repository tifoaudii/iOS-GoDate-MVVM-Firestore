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
        view.backgroundColor = .red
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
        self.view.addSubview(homeControlStackView)
        self.view.addSubview(topNavigationStackView)
        self.view.addSubview(cardView)
        
        homeControlStackView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        topNavigationStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        cardView.anchor(top: topNavigationStackView.bottomAnchor, left: view.leftAnchor, bottom: homeControlStackView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
