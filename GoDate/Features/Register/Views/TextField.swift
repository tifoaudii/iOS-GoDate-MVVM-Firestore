//
//  TextField.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 14/09/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class TextField: UITextField {

    var padding: CGFloat = 0
    
    init(padding: CGFloat) {
        super.init(frame: .zero)
        
        self.padding = padding
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 45)
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 20
        layer.borderWidth = 0.5
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
}
