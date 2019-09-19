//
//  NewsFeed.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsFeed: Mappable {
    
    //MARK: - Variables
    public var title : String?
    public var description : String?
    public var imageURL : String?
    public var url : String?
    public var likes : Int?
    public var shares : Int?

    //MARK: - Mappable Protocol Methods
    required public init?(map: Map) {
        
        mapping(map: map)
    }
    public func mapping(map: Map) {
        
        self.title <- map["title"]
        self.description <- map["full_description"]
        self.imageURL <- map["description_image_url"]
        self.url <- map["article_url"]
        self.likes <- map["likes"]
        self.shares <- map["shares"]

    }
}
