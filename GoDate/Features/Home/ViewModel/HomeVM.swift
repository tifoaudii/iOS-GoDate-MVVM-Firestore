//
//  HomeVM.swift
//  GoDate
//
//  Created by Tifo Audi Alif Putra on 22/08/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class HomeVM {
    
    let _users: [User] = [
        User(name: "Lely", age: 21, job: "Product Manager", imageUrl: "lely"),
        User(name: "Asriina", age: 19, job: "Product Manager", imageUrl: "aci"),
        User(name: "Asriina", age: 19, job: "Product Manager", imageUrl: "aci"),
        User(name: "Asriina", age: 19, job: "Product Manager", imageUrl: "aci"),
        User(name: "Asriina", age: 19, job: "Product Manager", imageUrl: "aci"),
        User(name: "Asriina", age: 19, job: "Product Manager", imageUrl: "aci"),
        User(name: "Asriina", age: 19, job: "Product Manager", imageUrl: "aci")
    ]
    
    var user = [User]()
    
    var fetchingState: (()->())?
    var emptyDataState: (()->())?
    var errorState: (()->())?
    
    var isFetching = false {
        didSet {
            self.fetchingState?()
        }
    }
    
    var isEmptyData = false {
        didSet {
            self.emptyDataState?()
        }
    }
    
    var hasError = false {
        didSet {
            self.errorState?()
        }
    }
    
    func fetchData(completion: @escaping (_ user: [User])->()) {
        self.isFetching = true
        self.user = self._users
        self.isFetching = false
        completion(user)
    }
    
    func viewModelForCard(with user: User) -> CardVM {
        return CardVM(user: user)
    }
}
