//
//  BaseAPI.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

enum Method : String {
    case GET
    case POST
    case PUT
}

public class BaseAPI: NSObject {
    
    //MARK: Singleton object
    public static let sharedInstance = BaseAPI()
    
    //MARK: - Variables
    public var storeBaseURL = {
        
        return "https://gospark.app/api/v1/"
    }
    
    //MARK: Headers
    public func headers(withMethod method: String) -> [String : String] {
        
        let headers = [
                       "Content-Type" : "application/json",
                       "X-Requested-With" : "XMLHttpRequest"]
        return headers
    }
}
