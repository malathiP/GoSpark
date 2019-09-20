//
//  LoginViewModel.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewModel: NSObject {

    // MARK: - Variables
    var loginRepository: LoginRepository?

    // MARK: Private variables
    private var userModel : User?
    
    // MARK: Static variables
    static let sharedInstance = LoginViewModel(LoginRepository.sharedInstance)
    
    // MARK: - Intialization
    init(_ repository: LoginRepository)  {
        
        self.loginRepository = repository
        self.loginRepository?.setDataSource(remoteDataSource: LoginRemoteDataSource.sharedInstance)
    }
    
    // MARK: Login
    func login(withEmail emailId : String?, password : String?) -> Observable<User?> {
        
        return Observable.create({ [weak self](observer) -> Disposable  in
            
            self!.loginRepository!.login(withEmailId: emailId, password: password).asObservable().subscribe(onNext: { [weak self] (event) in
                
                guard event != nil else {
                    
                    print("LoginViewModel.login : User nil")
                    return
                }
                let event = event as? User
                self?.userModel = event
                observer.onNext(event)
                
                }, onError: {  (error) in
                    
                observer.onError(error)
            })
        })
    }
    
    // MARK: Register
    func  register(withName name: String, emailId: String, password: String, phoneNumber: String, gender: String) -> Observable<String?> {
        
        return Observable.create({ [weak self](observer) -> Disposable  in
            
            self!.loginRepository!.register(withName: name, emailId: emailId, password: password, phoneNumber: phoneNumber, gender: gender).asObservable().subscribe(onNext: {  (event) in
                
                guard event != nil else {
                    
                    print("LoginViewModel.register : register nil")
                    return
                }
                observer.onNext(event as? String)
                }, onError: { (error) in
                    
                observer.onError(error)
            })
        })
    }
    
    // MARK: DataSource
    func accessToken() -> String {
        
       return self.userModel?.apitoken ?? ""
    }
}
