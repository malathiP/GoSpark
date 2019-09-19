//
//  AppConstants.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class AppConstants: NSObject {

    // MARK: - Singleton Object
    static let sharedInstance = AppConstants()
    
    // MARK: StoryBoard
    struct storyBoard {
        
        static let newsFeeds = "NewsFeed"
    }
    
    // MARK: NewsFeed
    struct NewsFeed {
        
        static let pageCount = 10
    }
    
}
