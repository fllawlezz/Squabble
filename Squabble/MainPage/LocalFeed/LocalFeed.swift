//
//  LocalFeed.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class LocalFeed: UIViewController, UITextFieldDelegate,ComposeNewHeadlineDelegate, ChatPageDelegate{
    
    lazy var localFeed: FeedCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let localFeed = FeedCollectionView(frame: .zero, collectionViewLayout: layout);
        return localFeed;
    }()
    
    let refreshControl = UIRefreshControl();
    
    var localFeedTitleView: UISegmentedControl?;
    var composeButton: UIButton?;
    var searchButton: UIButton?;
    var searchBar: NormalUITextField?;
    
    //collectionView
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.view.snapshotView(afterScreenUpdates: true);
        setupNavBar();
        setupLocalFeed();
        setupRefreshControl();
    }
    
    fileprivate func setupNavBar(){
        localFeedTitleView = FeedTitleView(items: ["New","Hot"]);
        
        self.navigationItem.titleView = localFeedTitleView;
        
        searchButton = UIButton(type: .system);
        searchButton!.setImage(#imageLiteral(resourceName: "search"), for: .normal);
        searchButton!.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        searchButton!.addTarget(self, action: #selector(self.handleSearchPressed), for: .touchUpInside);
        
        composeButton = UIButton(type: .system);
        composeButton!.setImage(#imageLiteral(resourceName: "compose"), for: .normal);
        composeButton!.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        composeButton?.addTarget(self, action: #selector(self.handleComposeHeadline), for: .touchUpInside);
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchButton!);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: composeButton!);
        
        searchBar = NormalUITextField();
        searchBar!.backgroundColor = .white;
        searchBar!.layer.cornerRadius = 5;
        searchBar!.placeholder = "Search Names/Categories";
        searchBar!.font = UIFont.montserratRegular(fontSize: 14)
        searchBar!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width*(2/3), height: 25);
        searchBar!.delegate = self;
        searchBar!.returnKeyType = .search;
        
    }
    
    fileprivate func setupLocalFeed(){
        localFeed.localFeedPage = self;
        self.view.addSubview(localFeed);
        localFeed.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        localFeed.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        localFeed.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        localFeed.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupRefreshControl(){
        self.localFeed.refreshControl = self.refreshControl;
        
    }
    
    @objc func handleSearchPressed(){
        let cancelButton = UIButton(type: .system);
        cancelButton.frame = CGRect(x: 0, y: 0, width: 50, height: 40);
        cancelButton.setTitle("cancel", for: .normal);
        cancelButton.addTarget(self, action: #selector(self.handleCancel), for: .touchUpInside);
        
        localFeedTitleView?.isHidden = true;
        composeButton?.isHidden = true; 
        searchButton?.isHidden = true;
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: searchBar!), animated: true);
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: cancelButton), animated: true);
        
        searchBar?.becomeFirstResponder();
    }
    
    @objc func handleCancel(){
        let searchImageButton = UIButton(type: .system);
        searchImageButton.setImage(#imageLiteral(resourceName: "search"), for: .normal);
        searchImageButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        searchImageButton.addTarget(self, action: #selector(self.handleSearchPressed), for: .touchUpInside);
        
        self.searchBar?.text = "";

        self.localFeedTitleView?.isHidden = false;
        self.composeButton?.isHidden = false;
        self.searchButton?.isHidden = false;
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: searchButton!), animated: true);
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: composeButton!), animated: true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("return");
        return true;
    }
    
    func resetNavBar(){
        let searchImageButton = UIButton(type: .system);
        searchImageButton.setImage(#imageLiteral(resourceName: "search"), for: .normal);
        searchImageButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        searchImageButton.addTarget(self, action: #selector(self.handleSearchPressed), for: .touchUpInside);
        
        self.searchBar?.text = "";
        
        self.localFeedTitleView?.isHidden = false;
        self.composeButton?.isHidden = false;
        self.searchButton?.isHidden = false;
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: searchButton!), animated: false);
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: composeButton!), animated: false);
    }
    
    @objc func handleComposeHeadline(){
        let composePage = ComposeNewHeadline();
        self.present(composePage, animated: true, completion: nil);
    }
    
}

extension LocalFeed{
    func postHeadline(globalOrLocal: Int) {
        if(globalOrLocal == 0){
            self.localFeed.reloadData();
        }
    }
    
    func resetNavigationBar(){
        self.resetNavBar();
    }
}
