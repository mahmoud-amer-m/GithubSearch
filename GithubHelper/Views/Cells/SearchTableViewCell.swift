//
//  SearchTableViewCell.swift
//  GithubHelper
//
//  Created by Mahmoud Amer on 10/4/18.
//  Copyright © 2018 Amer. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoDescLabel: UILabel!
    @IBOutlet weak var numberOfForksLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var item: Items? {
        didSet {
            ownerNameLabel.text = item?.owner?.login ?? ""
            avatarImageView.sd_setImage(with: URL(string: item?.owner?.avatar_url ?? ""), placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
            numberOfForksLabel.text = "Forks: \(item?.forks_count ?? 0)"
            repoDescLabel.text = item?.description ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
