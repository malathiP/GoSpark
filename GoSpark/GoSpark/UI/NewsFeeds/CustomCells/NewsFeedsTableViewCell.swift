//
//  NewsFeedsTableViewCell.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import SDWebImage

class NewsFeedsTableViewCell: UITableViewCell, CellDataSource {

    // MARK: CellDataSource delegate variables
    static var className: AnyClass = NewsFeedsTableViewCell.self
    static var identifer: String = "NewsFeedsTableViewCell"
    
    // MARK: Variables
    var newsFeedViewModel : NewsFeedCellViewModel?

    
    // MARK: IBOutlets
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Configure UI
    func configureUI(withViewModel viewModel : NewsFeedCellViewModel) {
        
        self.newsFeedViewModel = viewModel
        guard self.newsFeedViewModel != nil else {
            
            print("NewsFeedsTableViewCell.configureUI : viewmodel nil")
            return
        }
        
        self.titleLabel.text = self.newsFeedViewModel?.title()
        self.likesLabel.text = self.newsFeedViewModel?.likes()
        self.shareLabel.text = self.newsFeedViewModel?.shares()
        let url = URL(string: self.newsFeedViewModel?.imageURL() ?? "")
        
        guard url != nil else {
            return
        }
        DispatchQueue.main.async {
            
            self.feedImageView.sd_setImage(with: url) { [weak self](image,_,_,_) in
                
                guard image != nil else {return}
                let size = image?.size ?? CGSize.zero
                let height = size.aspectHeight(basedOnWidth: self?.frame.size.width ?? 0)
                self?.imageViewHeightConstraint.constant = height
                self?.loader?.stopAnimating()
                
            }
        }
    }
    
}
