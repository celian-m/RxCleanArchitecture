//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit 

protocol ___VARIABLE_sceneName___AdapterDelegate : AnyObject {
    

}
class ___VARIABLE_sceneName___Adapter: NSObject {
    
    enum Element  {
       
       
    }
    
    
    typealias Delegate =  UIScrollViewDelegate & ___VARIABLE_sceneName___AdapterDelegate
    weak var delegate: Delegate?
    
    private(set) var data: [Element] = []
    weak var mCollectionView: UICollectionView!
    
    var topSectionInset: CGFloat = 0
    public var interItemSpacing: CGFloat = 20
    
    func attach(to: UICollectionView, topSectionInset: CGFloat = 0, delegate: Delegate? = nil) {
        self.mCollectionView = to
        to.dataSource = self
        to.delegate = self
        self.topSectionInset = topSectionInset
        self.delegate = delegate
        //Attach Cells

    }
    
    func update(_ data: [Element]) {
        self.data = data
        self.layout()
    }
    
    private func layout() {
        self.mCollectionView.reloadData()
    }
    
    fileprivate func elemAt(_ index: IndexPath) -> Element {
        return data[index.row]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
}

extension ___VARIABLE_sceneName___Adapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        switch elemAt(indexPath) {
//
//        }
            fatalError()
    }
    
}


extension ___VARIABLE_sceneName___Adapter: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .zero
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .zero
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch elemAt(indexPath) {
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    
}
