//
//  RepoListController.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//


import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol RepoListIntents : class {
    func intentLoad() -> Observable<String>
    func intentReload() -> Observable<Void>
    func intentSelectRepository() -> Observable<E.Repository>
    func display(model : RepoListModel)
}



class RepoListController : SuperViewController, RepoListIntents {
    
    var presenter : RepoListPresenter!
    var dataSource = RxTableViewSectionedReloadDataSource<GitHubRepositorySection>()
    var data = PublishSubject<[GitHubRepositorySection]>()
    @IBOutlet weak var mActivityLoader: UIActivityIndicatorView!
    @IBOutlet private var mTableView : UITableView!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName : "RepoListCellTableViewCell", bundle : nil)
        self.mTableView.register(cellNib, forCellReuseIdentifier: "cell")
        
        self.mTableView.rowHeight = UITableViewAutomaticDimension
        self.mTableView.estimatedRowHeight = 50
        
        self.data.bind(to: self.mTableView.rx.items(dataSource: self.dataSource)).addDisposableTo(self.bag)
        
        self.dataSource.configureCell = { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = item.name
            cell?.detailTextLabel?.text = item.description
            return cell!
        }
        
        self.presenter.attach()
    }
    
    //MARK:- Rx Display Protocol
    func display(model: RepoListModel) {
        self.title = model.title
        self.mActivityLoader.isHidden = !model.isLoading
        self.data.onNext(model.sections)
    }
    
    
    
    //MARK:- Rx Intent Protocol
    func intentLoad() -> Observable<String> {
        return Observable.just("celian-m")
    }
    
    
    func intentReload() -> Observable<Void> {
        return self.reloadButton.rx.tap.flatMap { _ in
            return Observable.just()
        }
    }
    
    func intentSelectRepository() -> Observable<E.Repository> {
        return self.mTableView.rx.itemSelected.map { indexPath in
            return self.dataSource.sectionModels[indexPath.section].items[indexPath.row]
        }
    }

    
}
