//
//  NewsFeedViewController.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

class NewsFeedViewController: BaseViewController {

    // MARK: Variables
    var userName : String = ""
    weak var loginViewModel = LoginViewModel.sharedInstance
    weak var newsFeedViewModel = NewsFeedViewModel.sharedInstance
    let disposeBag = DisposeBag()

    // MARK: IBOutlets
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    // MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        self.title = userName
        
        self.newsFeedTableView.sectionHeaderHeight = 0
        self.newsFeedTableView.sectionFooterHeight = 0
        
        self.newsFeedTableView.register(NewsFeedsTableViewCell.className, forCellReuseIdentifier: NewsFeedsTableViewCell.identifer)
        self.newsFeedTableView.register(UINib(nibName: NewsFeedsTableViewCell.identifer, bundle: Bundle.main), forCellReuseIdentifier: NewsFeedsTableViewCell.identifer)
        
        self.showLoader()
        self.loadNewsFeeds()
    }
    
    // MARK: Get new feeds
    func loadNewsFeeds() {
        
        let count = self.newsFeedViewModel?.noOfNewsFeeds() ?? 0
        guard count == 0 || count < self.newsFeedViewModel?.totalCount() ?? 0 else {
            
            return
        }
        let pageIndex = count / AppConstants.NewsFeed.pageCount
        newsFeedViewModel?.getNewsFeeds(basedOnAccessToken: loginViewModel?.accessToken(), page: pageIndex + 1).asObservable().subscribe(onNext: {[weak self] (feeds) in
            
            self?.hideLoader()
            self?.newsFeedTableView.reloadData()
            
            }, onError: { [weak self](error) in
                
                self?.hideLoader()
                print("NewsFeedViewController.addObserverToNewsFeed : \(error.localizedDescription)")
                
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: LoadMore
    func isAllFeedsLoaded() -> Bool {
        
        let totalCount = self.newsFeedViewModel?.totalCount() ?? 0
        return totalCount == self.newsFeedViewModel?.noOfNewsFeeds()
    }
    func loadMore(withIndexPath indexPath : IndexPath) {
        
        let isReachesEnd = self.isScrollReachesToEnd(basedOnCurrentIndex: indexPath.row)
        
        // load products only when allproductnot loaded and reaches to end of tableview
        if  self.isAllFeedsLoaded() == false && isReachesEnd {
            
            DispatchQueue.global(qos: .background).async {
                self.loadNewsFeeds()
            }
        }
    }
    func isScrollReachesToEnd(basedOnCurrentIndex index : Int) -> Bool {
        
        let loadedProducts = self.newsFeedViewModel?.noOfNewsFeeds()
        let currentIndex = index + 1
        return currentIndex == loadedProducts
        
    }
    
    // MARK: Show Webpage
    func showWebPage(withUrl url : String?) {
        
        let storyBoardName = AppConstants.storyBoard.newsFeeds
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let webViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
        guard webViewController != nil else {
            
            return
        }
        webViewController?.url = url
        self.navigationController?.pushViewController(webViewController!, animated: true)
        
    }
}

// MARK: UITableViewDelegate & DataSource Methods
extension NewsFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.newsFeedViewModel?.noOfNewsFeeds() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier:NewsFeedsTableViewCell.identifer , for: indexPath) as? NewsFeedsTableViewCell else { return UITableViewCell() }
        
        let newsFeed = self.newsFeedViewModel?.feedAtIndexPath(indexPath.row)
        self.loadMore(withIndexPath: indexPath)
        guard cell.newsFeedViewModel == nil else {
            
            cell.newsFeedViewModel?.setNewsFeed(newsFeed)
            cell.configureUI(withViewModel: cell.newsFeedViewModel!)
            return cell
        }
        let viewModel = NewsFeedCellViewModel(withNewsFeed: newsFeed)
        
        cell.configureUI(withViewModel: viewModel)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsFeed = self.newsFeedViewModel?.feedAtIndexPath(indexPath.row)
        guard newsFeed != nil else {
            
            print( "NewsFeedViewController.didSelectRowAt : newsfeed nil")
            return
        }
        self.showWebPage(withUrl: newsFeed?.url)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nil
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreHeader") else {
            return nil
        }
        return headerCell.contentView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
       return self.isAllFeedsLoaded() ? 0 : 50
    }
}
