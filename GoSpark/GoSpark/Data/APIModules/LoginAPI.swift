//
//  LoginAPI.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import ObjectMapper
import Alamofire

class LoginAPI: LoginDataSource {

    //MARK: - Singleton Object
    public static let sharedInstance = LoginAPI()
    
    //MARK: - Login
    public func login(withEmailId email: String?, password: String?) -> Observable<Any?>  {
        
        let storeURL = BaseAPI.sharedInstance.storeBaseURL()

        let parameters = ["email" : email!,"password" : password!]
        let url = URL(string:"\(storeURL)login")
        print("LoginAPI.login : \(url!) \n parameters : \(parameters)")
        
        return Observable.create({ (observer) -> Disposable in
            let request =  Alamofire.request(url!, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers : nil).responseJSON { response in
                
                switch(response.result) {
                case.success(let value):
                    
                    let responseDictionary = value as! [String : Any]
                    let status = responseDictionary["status"] as! String
                    guard status == "true" else {
                        
                        observer.onError(NSError(domain: "Invalid Credentials", code: 400, userInfo: nil))
                        return
                    }
                    let user = User(JSON: value as! Dictionary)
                    observer.onNext(user)
                    
                case .failure(_):
                    
                    let error = response.error ?? NSError(domain: "Something went wrong", code: 400, userInfo: nil)
                    observer.onError(error)
                }
            }
            return Disposables.create {
                
                request.cancel()
            }
        })
    }
    
    //MARK: - Register
    public func register(withName name: String, emailId: String, password: String, phoneNumber: String, gender: String) -> Observable<Any?>  {
        
        let storeURL = BaseAPI.sharedInstance.storeBaseURL()
        
        let parameters = ["name" : name, "email" : emailId, "password" : password, "password_confirmation" : password, "mobile" : phoneNumber, "gender" : gender]
        let url = URL(string:"\(storeURL)register")
        let headers = BaseAPI.sharedInstance.headers(withMethod: "")
        print("LoginAPI.register : \(url!) \n parameters : \(parameters)")
        
        return Observable.create({ (observer) -> Disposable in
            let request =  Alamofire.request(url!, method: .post, parameters: parameters as Parameters,encoding: JSONEncoding.default, headers : headers).responseJSON { response in
                
                switch(response.result) {
                case.success(let value):
                    
                    let resultDictionary = value as! [String : Any]
                    let errors = resultDictionary["errors"]
                    guard errors == nil else {
                        
                        observer.onNext("Email already exist")
                        return
                    }
                    let message = resultDictionary["message"]
                    observer.onNext(message)
                    
                case .failure(_):
                    
                    let error = response.error ?? NSError(domain: "Something went wrong", code: 400, userInfo: nil)
                    observer.onError(error)
                }
            }
            return Disposables.create {
                
                request.cancel()
            }
        })
    }
}
