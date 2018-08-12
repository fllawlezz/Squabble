//
//  File.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class MyHeadlines:UIViewController{
    
    lazy var myFeedCollectionView: FeedCollectionView = {
        let flowLayout = UICollectionViewFlowLayout();
        let myFeedCollectionView = FeedCollectionView(frame: .zero, collectionViewLayout: flowLayout);
        return myFeedCollectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupMyFeedCollectionView();
    }
    
    fileprivate func setupMyFeedCollectionView(){
        self.view.addSubview(myFeedCollectionView);
        myFeedCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        myFeedCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        myFeedCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        myFeedCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
}
