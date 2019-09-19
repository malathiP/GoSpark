//
//  NewsFeedAPI.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import ObjectMapper
import Alamofire

class NewsFeedAPI: NewsFeedDataSource {
    
    //MARK: - Singleton Object
    public static let sharedInstance = NewsFeedAPI()
    
    //MARK: - NewsFeeds
    public func getNewsFeeds(basedOnAccessToken token: String?, page : Int) -> Observable<Any?>  {
        
        let storeURL = BaseAPI.sharedInstance.storeBaseURL()
        
        let headers = ["Authorization" : "Bearer \(token!)"]
        let url = URL(string:"\(storeURL)kstream?page=\(page)")
        print("NewsFeedAPI.getNewsFeeds : \(url!) \n headers : \(headers)")
        
        return Observable.create({ (observer) -> Disposable in
            let request =  Alamofire.request(url!, method: .get, parameters: nil,encoding: JSONEncoding.default, headers : headers).responseJSON { response in
                
                switch(response.result) {
                case.success(let value):
                    
                    let kStream = KSteam(JSON: value as! Dictionary)
                    observer.onNext(kStream)
                    
                case .failure(_):
                    
                    let error = response.error ?? NSError(domain: "Something went wrong", code: 400, userInfo: nil)
                    observer.onError(error)
                }
            }
            return Disposables.create {
                
                request.cancel()
            }
        })
    }
    
}
