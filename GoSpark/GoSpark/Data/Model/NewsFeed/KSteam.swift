//
//  KSteam.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import ObjectMapper

class KSteam: Mappable {
    
    //MARK: - Variables
    public var feedsArray : [NewsFeed]?
    public var totalCount : Int?
    
    //MARK: - Mappable Protocol Methods
    required public init?(map: Map) {
        
        mapping(map: map)
    }
    public func mapping(map: Map) {
        
        self.feedsArray <- map["kstream.data"]
        self.totalCount <- map["kstream.to"]

    }
}
