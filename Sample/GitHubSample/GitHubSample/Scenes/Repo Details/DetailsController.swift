//
//  DetailsController.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 29/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//


import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
protocol DetailsIntents : class {

    func intentLoad() -> Observable<Void>
    func display(viewModel : DetailsModel)
}



class DetailsController : SuperViewController, DetailsIntents {
    
    var presenter : DetailsPresenter!
    
    @IBOutlet weak var mTableView : UITableView!
    
    var dataSource = RxTableViewSectionedReloadDataSource<CommitSection>()
    var data = PublishSubject<[CommitSection]>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName : "CommitTableViewCell", bundle : nil)
        self.mTableView.register(cellNib, forCellReuseIdentifier: "commit")
        
        self.mTableView.rowHeight = UITableViewAutomaticDimension
        self.mTableView.estimatedRowHeight = 50
        
        self.data.bind(to: self.mTableView.rx.items(dataSource: self.dataSource)).addDisposableTo(self.bag)
        
        self.dataSource.configureCell = { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "commit")
            cell?.textLabel?.text = item.author.name
            cell?.detailTextLabel?.text = item.message
            return cell!
        }
        self.presenter.attach()
        
    }
    
    func display(viewModel: DetailsModel) {
        self.title = viewModel.title
        self.data.onNext(viewModel.commits)
    }
    
    
    func intentLoad() -> Observable<Void> {
        return Observable.just()
    }
    
    deinit {
        print("Deinit \(#file)")
    }
    
}
