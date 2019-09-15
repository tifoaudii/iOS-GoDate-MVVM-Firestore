//
//  RegisterVC.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 14/09/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController {
    
    //MARK:- UIKit Objects
    let avatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "avatar"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let avatarView: UIView = {
        let view = UIView()
        let heightScreen = UIScreen.main.bounds.size.height
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameTextField: TextField = {
        let textField = TextField(padding: 16.0)
        textField.placeholder = "Enter your fullname"
        return textField
    }()
    
    let emailTextField: TextField = {
        let textField = TextField(padding: 16.0)
        textField.placeholder = "Enter your email address"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: TextField = {
        let textField = TextField(padding: 16.0)
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.opacity = 0.8
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return button
    }()
    
    let loginNavigationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account? login here", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    lazy var layoutStackView: UIStackView = {
        let views = [avatarView,nameTextField, emailTextField, passwordTextField, continueButton]
        let layoutStackView = UIStackView(arrangedSubviews: views)
        return layoutStackView
    }()
    
    //MARK:- View Controller's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLayout()
        self.setupKeyboardNotification()
        self.setupTapGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Remove the Observer
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Fileprivate Function
    fileprivate func setupLayout() {
        view.addSubview(layoutStackView)
        view.backgroundColor = .white
        layoutStackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 0)
        layoutStackView.axis = .vertical
        layoutStackView.spacing = 16
        layoutStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        avatarView.heightAnchor.constraint(equalTo: layoutStackView.heightAnchor, multiplier: 0.4).isActive = true
        
        avatarView.addSubview(avatarButton)
        avatarButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 110, height: 110)
        avatarButton.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor).isActive = true
        avatarButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor).isActive = true
        
        view.addSubview(loginNavigationButton)
        loginNavigationButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 20, paddingRight: 40, width: 0, height: 40)
    }
}


extension RegisterVC {
    
    //MARK:- Add Notification Observer Functionality for keyboard show up
    func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onHandleKeyboardShowUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onHandleDismissKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func onHandleKeyboardShowUp(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = value.cgRectValue
        let bottomSpace = self.view.frame.height - self.layoutStackView.frame.origin.y - self.layoutStackView.frame.height
        let heightTransform = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -heightTransform - 8)
    }
    
    @objc func onHandleDismissKeyboard() {
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.view.transform = .identity
        }
    }
    
    //MARK:- Dismiss Keyboard Function
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onHandleTapGesture))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func onHandleTapGesture() {
        self.view.endEditing(true)
    }
}
