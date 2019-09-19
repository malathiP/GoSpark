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
    var disposeBag : DisposeBag? = DisposeBag()
    var user = PublishSubject<User>()
    var status = PublishSubject<String>()

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
    func login(withEmail emailId : String?, password : String?) {
        
        self.loginRepository?.login(withEmailId: emailId, password: password).asObservable().subscribe(onNext: { [weak self] (event) in
            
            guard event != nil else {
                
                print("LoginViewModel.login : User nil")
                return
            }
            let event = event as? User
            self?.userModel = event
            
            self?.user.onNext(event!)
            
            }, onError: { [weak self] (error) in
                
                self?.user.onError(error)
                
        }).disposed(by: self.disposeBag!)
    }
    
    // MARK: Register
    func  register(withName name: String, emailId: String, password: String, phoneNumber: String, gender: String) {
        
        self.loginRepository?.register(withName: name, emailId: emailId, password: password, phoneNumber: phoneNumber, gender: gender).asObservable().subscribe(onNext: { [weak self] (event) in
            
            guard event != nil else {
                
                print("LoginViewModel.register : register nil")
                return
            }
            self?.status.onNext(event as! String)
            }, onError: { [weak self] (error) in
                
                self?.status.onError(error)
                
        }).disposed(by: self.disposeBag!)
    }
    
    // MARK: DataSource
    func accessToken() -> String {
        
       return self.userModel?.apitoken ?? ""
    }
}
