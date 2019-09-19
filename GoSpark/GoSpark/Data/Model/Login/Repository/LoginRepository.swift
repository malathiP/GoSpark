//
//  LoginRepository.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

open class LoginRepository : LoginDataSource {
    
    // MARK: Singleton Object
    public static let sharedInstance = LoginRepository()
    
    // MARK: Variables
    public var remoteDataSource: LoginRemoteDataSource?
    
    public init() {
        
    }
    
    // MARK: SetDataSource
    open func setDataSource(remoteDataSource: LoginRemoteDataSource?) {
        
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: Login
    open func login(withEmailId email: String?, password: String?) -> Observable<Any?> {
        
        if self.remoteDataSource == nil {
            
            self.remoteDataSource = LoginRemoteDataSource.sharedInstance
        }
        return Observable.create({ [weak self](observer) -> Disposable  in
            
            self!.remoteDataSource!.login(withEmailId: email, password: password).subscribe(onNext: { (event) in
                
                observer.onNext(event)
            }, onError: { (error) in
                observer.onError(error)
            })
        })
    }
    
    // MARK: Register
    open func register(withName name: String, emailId: String, password: String, phoneNumber: String, gender: String) -> Observable<Any?> {
        
        if self.remoteDataSource == nil {
            
            self.remoteDataSource = LoginRemoteDataSource.sharedInstance
        }
        return Observable.create({ [weak self](observer) -> Disposable  in
            
            self!.remoteDataSource!.register(withName: name, emailId: emailId, password: password, phoneNumber: phoneNumber, gender: gender).subscribe(onNext: { (event) in
                
                observer.onNext(event)
            }, onError: { (error) in
                observer.onError(error)
            })
        })
    }
}
