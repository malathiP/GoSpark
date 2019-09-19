//
//  User.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {

    //MARK: - Variables
    public var name : String?
    public var email : String?
    public var apitoken : String?

    //MARK: - Mappable Protocol Methods
    required public init?(map: Map) {
        
        mapping(map: map)
    }
    public func mapping(map: Map) {
        
        self.name <- map["user.name"]
        self.email <- map["user.email"]
        self.apitoken <- map["user.api_token"]

    }
}
