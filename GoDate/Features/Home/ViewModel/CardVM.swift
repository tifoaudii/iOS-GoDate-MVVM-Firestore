//
//  CardViewModel.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 22/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class CardVM {
	
	//MARK:- ViewModel's properties here
	fileprivate var user: User
	fileprivate var imageIndex = 0 {
		didSet {
			let userImage = user.imageUrl[self.imageIndex]
			let image = UIImage(named: userImage)
			imageIndexDidChange?(image, self.imageIndex)
		}
	}
	
	//MARK:- Closures for reactive programming
	typealias index = Int
	var imageIndexDidChange: ((UIImage?, index)-> ())?
	
	//MARK:- Initializer
	init(user: User) {
		self.user = user
	}
	
	fileprivate var userNameView: NSAttributedString {
		let attributedString = NSAttributedString(string: user.name, attributes: [ .font: UIFont.systemFont(ofSize: 28, weight: .heavy)])
		return attributedString
	}
	
	fileprivate var userAgeView: NSAttributedString {
		let attributedString = NSAttributedString(string: "  \(user.age)", attributes: [ .font : UIFont.systemFont(ofSize: 24, weight: .regular)])
		return attributedString
	}
	
	fileprivate var userJob: NSAttributedString {
		let attributedString = NSAttributedString(string: "\n\(user.job)", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .regular)])
		return attributedString
	}
	
	var userInformation: NSMutableAttributedString {
		let attributedMutableString = NSMutableAttributedString()
		attributedMutableString.append(userNameView)
		attributedMutableString.append(userAgeView)
		attributedMutableString.append(userJob)
		return attributedMutableString
	}
	
	var userImage: UIImage {
		guard let image = UIImage(named: user.imageUrl[imageIndex]) else {
			return UIImage()
		}
		return image
	}
	
	func nextImageIndex() {
		let userImages = user.imageUrl.count
		imageIndex = min(imageIndex + 1, userImages - 1)
	}
	
	func prevImageIndex() {
		imageIndex = max(imageIndex - 1, 0)
	}
}


