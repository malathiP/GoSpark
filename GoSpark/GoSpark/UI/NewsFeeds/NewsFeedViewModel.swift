//
//  NewsFeedViewModel.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

class NewsFeedViewModel: NSObject {
    
    // MARK: - Variables
    var newsFeedRepository: NewsFeedRepository?
    var disposeBag : DisposeBag? = DisposeBag()
    var kSteam = PublishSubject<KSteam>()
    
    // MARK: Private variables
    private var kSteamModel : KSteam?
    
    // MARK: Static variables
    static let sharedInstance = NewsFeedViewModel(NewsFeedRepository.sharedInstance)
    
    // MARK: - Intialization
    init(_ repository: NewsFeedRepository)  {
        
        self.newsFeedRepository = repository
        self.newsFeedRepository?.setDataSource(remoteDataSource: NewsFeedRemoteDataSource.sharedInstance)
    }
    
    // MARK: Get newsFeeds based on accesstoken
    func getNewsFeeds(basedOnAccessToken token: String?, page : Int) {
        
        self.newsFeedRepository?.getNewsFeeds(basedOnAccessToken: token, page: page).asObservable().subscribe(onNext: { [weak self] (event) in
            
            guard event != nil else {
                
                print("NewsFeedViewModel.getNewsFeeds : ksteam nil")
                return
            }
            let event = event as? KSteam
            // add feeds to exist array only when page is greater than zero
            if page > 1 && self?.noOfNewsFeeds() ?? 0 > 0 {
                
                
                self?.addNewFeeds(event?.feedsArray)
            }else {
                
                self?.kSteamModel = event
            }
            
            self?.kSteam.onNext(event!)
            
            }, onError: { [weak self] (error) in
                
                self?.kSteam.onError(error)
                
        }).disposed(by: self.disposeBag!)
    }
    
    // MARK: DataSource
    func addNewFeeds(_ array : [NewsFeed]?) {
        
        guard array != nil else {
            
            return
        }
        self.kSteamModel?.feedsArray?.append(contentsOf: array!)
    }
    func noOfNewsFeeds() -> Int {
        
        return self.kSteamModel?.feedsArray?.count ?? 0
    }
    func feedAtIndexPath(_ index : Int) -> NewsFeed? {
        
        return self.kSteamModel?.feedsArray?[index] ?? nil
    }
    func totalCount() -> Int {
        
        return (self.kSteamModel?.totalCount ?? 0) * 10
    }
}
