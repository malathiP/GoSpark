//
//  BaseViewController.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Show/Hide loader
    func showLoader() {
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        activityIndicator.style = .gray
        activityIndicator.tag = TagConstants.Base.loaderTag
        self.view.addSubview(activityIndicator)
        
    }
    func hideLoader() {
        
        let activityIndicator = self.view.viewWithTag(TagConstants.Base.loaderTag) as? UIActivityIndicatorView
        guard activityIndicator != nil else {
            
            return
        }
        activityIndicator?.removeFromSuperview()
    }
    
    // MARK: - Show AlertView
    func showAlertWith(_ title: String, message: String, completionHandler : (()->())?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (action) in
            
            alertController.dismiss(animated: true, completion: nil)
            completionHandler?()
        }
        alertController.addAction(dismissButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: Show Newsfeeds
    func showNewsFeedsController(withUserName name : String) {
        
        let storyBoardName = AppConstants.storyBoard.newsFeeds
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let newsFeedsViewController = storyBoard.instantiateViewController(withIdentifier: "NewsFeedViewController") as? NewsFeedViewController
        guard newsFeedsViewController != nil else {
            
            return
        }
        newsFeedsViewController?.userName = name
        self.navigationController?.pushViewController(newsFeedsViewController!, animated: true)
        
    }

}
