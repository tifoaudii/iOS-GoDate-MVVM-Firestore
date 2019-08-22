//
//  CardViewModel.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 22/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

struct CardVM {
    
    //MARK:- ViewModel's properties here
    private var user: User
    
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
        return UIImage(named: user.imageUrl)!
    }
}
