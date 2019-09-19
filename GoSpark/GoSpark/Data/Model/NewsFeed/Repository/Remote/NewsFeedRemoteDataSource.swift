//
//  NewsFeedRemoteDataSource.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

open class NewsFeedRemoteDataSource: NewsFeedDataSource {
    
    // MARK: Singleton Object
    public static let sharedInstance = NewsFeedRemoteDataSource()
    
    // MARK: Login
    public func getNewsFeeds(basedOnAccessToken token: String?, page : Int) -> Observable<Any?> {
        
        return Observable.create({ (observer) -> Disposable in
            
            NewsFeedAPI.sharedInstance.getNewsFeeds(basedOnAccessToken: token, page: page).subscribe(onNext: { (event) in
                
                observer.onNext(event)
                
            }, onError: { (error) in
                
                observer.onError(error)
            })
        })
    }
    
}
