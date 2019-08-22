
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
	
	let cardContainerView: UIView = {
		let view = UIView()
		return view
	}()
	
	private let homeViewModel = HomeVM()
	
	//MARK:- View Controller lifecycles Here
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.setupLayout()
		self.homeViewModel.fetchData { [unowned self] (users) in
			self.populateUserCards(users)
		}
	}
	
	//MARK:- Fileprivate Methods Here
	fileprivate func setupLayout() {
		let stackView = UIStackView(arrangedSubviews: [topNavigationStackView, cardContainerView, homeControlStackView])
		stackView.axis = .vertical
		view.addSubview(stackView)
		
		stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		
		stackView.bringSubviewToFront(cardContainerView)
	}
	
	fileprivate func populateUserCards(_ users: [User]) {
		users.forEach({ [unowned cardContainerView] in
			let cardViewModel = CardVM(user: $0)
			let cardView = CardView(frame: .zero)
			
			cardView.imageView.image = cardViewModel.userImage
			cardView.userLabel.attributedText = cardViewModel.userInformation
			cardContainerView.addSubview(cardView)
			cardView.fillSuperview()
		})
	}
}

