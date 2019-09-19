//
//  LoginDataSource.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

public protocol LoginDataSource {
    
    func login(withEmailId email : String?, password : String?) -> Observable<Any?>
    func register(withName name: String, emailId: String, password: String, phoneNumber: String, gender: String) -> Observable<Any?>
}
