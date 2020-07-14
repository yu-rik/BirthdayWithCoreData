//
//  Birthday.swift
//  BirthdayWithCoreData
//
//  Created by yurik on 7/13/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import Foundation
class Birthday {
    let firstName: String
    let lastName: String
    var birthDate: Date
    
    
    init(firstname: String, lastName: String, date: Date) {
        self.firstName = firstname
        self.lastName = lastName
        self.birthDate = date
    }
    
}
