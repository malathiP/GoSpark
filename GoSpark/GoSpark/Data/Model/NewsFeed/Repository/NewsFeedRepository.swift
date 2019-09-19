//
//  NewsFeedRepository.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

open class NewsFeedRepository : NewsFeedDataSource {
    
    // MARK: Singleton Object
    public static let sharedInstance = NewsFeedRepository()
    
    // MARK: Variables
    public var remoteDataSource: NewsFeedRemoteDataSource?
    
    public init() {
        
    }
    
    // MARK: SetDataSource
    open func setDataSource(remoteDataSource: NewsFeedRemoteDataSource?) {
        
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: Login
    open func getNewsFeeds(basedOnAccessToken token: String?, page : Int) -> Observable<Any?> {
        
        if self.remoteDataSource == nil {
            
            self.remoteDataSource = NewsFeedRemoteDataSource.sharedInstance
        }
        return Observable.create({ [weak self](observer) -> Disposable  in
            
            self!.remoteDataSource!.getNewsFeeds(basedOnAccessToken: token, page: page).subscribe(onNext: { (event) in
                
                observer.onNext(event)
            }, onError: { (error) in
                observer.onError(error)
            })
        })
    }
}
