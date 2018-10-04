//
//  ItemDetailsViewController.swift
//  GithubHelper
//
//  Created by Mahmoud Amer on 10/4/18.
//  Copyright © 2018 Amer. All rights reserved.
//

import UIKit

class ItemDetailsViewController: BaseViewController {
    
    var item: Items?
    var subscribers: [Owner]?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var subscribersCountLabel: UILabel!
    @IBOutlet weak var subscribersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = item?.owner?.login ?? ""
        avatarImageView.sd_setImage(with: URL(string: item?.owner?.avatar_url ?? ""), placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
        repoNameLabel.text = item?.full_name ?? ""
        subscribersCountLabel.text = "Number of subscribers: \(item?.watchers_count ?? 0)"
        getSubscribers(urlString: item?.subscribers_url ?? "")
    }
    
    func getSubscribers(urlString: String) {
        showLoading()
        ServicesManager.getSubscribers(subscribtionsURL: urlString, completion: { [weak self] (subscribers) in
            self?.hideLoadingView()
            self?.subscribers = subscribers
            self?.subscribersTableView.reloadData()
        }) { [weak self] (error) in
            self?.hideLoadingView()
            self?.showAlert(title: "erro", message: error, buttonTitle: "Try Again", action: { _ in
                self?.getSubscribers(urlString: urlString)
            })
        }
    }
}

extension ItemDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let subscriber = subscribers?[indexPath.row]
        cell.textLabel?.text = subscriber?.login ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
