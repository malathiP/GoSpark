//
//  NewsFeedDataSource.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

public protocol NewsFeedDataSource {
    
    func getNewsFeeds(basedOnAccessToken token : String?, page : Int) -> Observable<Any?>
}

