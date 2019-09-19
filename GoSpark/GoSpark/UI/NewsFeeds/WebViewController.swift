//
//  WebViewController.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: Variables
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let feedURL = URL(string: self.url ?? "")
        guard feedURL != nil else {
            return
        }
        self.webView.load(URLRequest(url: feedURL!))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
