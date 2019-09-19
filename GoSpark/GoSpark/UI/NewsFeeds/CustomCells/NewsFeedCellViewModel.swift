//
//  NewsFeedCellViewModel.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class NewsFeedCellViewModel: NSObject {

    private var newsFeed : NewsFeed?
    
    // MARK: Initialization
    init(withNewsFeed feed : NewsFeed?) {
        
        self.newsFeed = feed
    }
    func setNewsFeed(_ feed : NewsFeed?) {
        
        self.newsFeed = feed
    }
    
    // MARK: DataSource
    func title() -> String {
        
        return self.newsFeed?.title ?? ""
    }
    func description() -> String {
        
        return self.newsFeed?.description ?? ""
    }
    func likes() -> String {
        
        return "\(self.newsFeed?.likes ?? 0)"
    }
    func shares() -> String {
        
        return "\(self.newsFeed?.shares ?? 0)" 
    }
    func imageURL() -> String {
        
        return self.newsFeed?.imageURL ?? ""
    }
    func url() -> String {
        
        return self.newsFeed?.url ?? ""
    }
}
