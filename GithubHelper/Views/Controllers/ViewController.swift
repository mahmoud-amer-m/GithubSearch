//
//  ViewController.swift
//  GithubHelper
//
//  Created by Mahmoud Amer on 10/3/18.
//  Copyright © 2018 Amer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchModel: BaseModel?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Search"
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        searchBar.rx.text.throttle(0.5, scheduler: MainScheduler.instance).filter { !($0 ?? "").isEmpty }
            .distinctUntilChanged { (oldStr, newStr) -> Bool in
                return oldStr?.lowercased() == newStr?.lowercased()
            }.subscribe(onNext: {[weak self] (keyword) in
                self?.search(keyword: keyword ?? "GithubHelper")
            }).disposed(by: self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func search(keyword: String) {
        showLoading()
        ServicesManager.searchAPI(searchKeywork: keyword, completion: { [weak self] (model) in
            self?.searchModel = model
            self?.tableView.reloadData()
            self?.hideLoadingView()
        }) { [weak self] (error) in
            self?.hideLoadingView()
            self?.showAlert(title: "erro", message: error, buttonTitle: "Try Again", action: { _ in
                self?.search(keyword: keyword)
            })
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return searchModel?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! SearchTableViewCell
        cell.item = searchModel?.items?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC: ItemDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
        detailsVC.item = searchModel?.items?[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    
    }
}
