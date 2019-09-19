//
//  LoginRemoteDataSource.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

open class LoginRemoteDataSource: LoginDataSource {
    
    // MARK: Singleton Object
    public static let sharedInstance = LoginRemoteDataSource()
    
    // MARK: Login
    public func login(withEmailId email: String?, password: String?) -> Observable<Any?> {
        
        return Observable.create({ (observer) -> Disposable in
            
            LoginAPI.sharedInstance.login(withEmailId: email, password: password).subscribe(onNext: { (event) in
                
                observer.onNext(event)
                
            }, onError: { (error) in
                
                observer.onError(error)
            })
        })
    }
    
    // MARK: Register
    public func register(withName name: String, emailId: String, password: String, phoneNumber: String, gender: String) -> Observable<Any?> {
        
        return Observable.create({ (observer) -> Disposable in
            
            LoginAPI.sharedInstance.register(withName: name, emailId: emailId, password: password, phoneNumber: phoneNumber, gender: gender).subscribe(onNext: { (event) in
                
                observer.onNext(event)
                
            }, onError: { (error) in
                
                observer.onError(error)
            })
        })
    }
}
