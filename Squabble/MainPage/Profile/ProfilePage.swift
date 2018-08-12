//
//  Profile.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ProfilePage: UIViewController{
    //collectionView
    
    lazy var profileCollectionView: ProfileCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let profileCollectionView = ProfileCollectionView(frame: .zero, collectionViewLayout: layout);
        return profileCollectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupProfileCollectionView();
    }
    
    fileprivate func setupProfileCollectionView(){
        self.view.addSubview(profileCollectionView);
        profileCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        profileCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        profileCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        profileCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        profileCollectionView.profilePage = self;
    }
    
}
