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
    
//    var headlines:[Headline]?;
    var headlines = [Headline]();
    
    var localFeedTitleView: UISegmentedControl?;
    var composeButton: UIButton?;
    var searchButton: UIButton?;
    var searchBar: NormalUITextField?;
    
    var categories = [Category]();
    
    //collectionView
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.view.snapshotView(afterScreenUpdates: true);
        setupCategories();
        setupNavBar();
        setupLocalFeed();
        setupRefreshControl();
//        refreshControl.beginRefreshing();
    }
    
    fileprivate func setupCategories(){
        let general = Category(categoryName: "General", categoryID: 1);
        let sports = Category(categoryName: "Sports", categoryID: 2);
        let politics = Category(categoryName: "Politics", categoryID: 3);
        let other = Category(categoryName: "Other", categoryID: 4);
        
        categories.append(general);
        categories.append(sports);
        categories.append(politics);
        categories.append(other);
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
        
        localFeed.headlines = self.headlines;
    }
    
    fileprivate func setupRefreshControl(){
        self.localFeed.refreshControl = self.refreshControl;
        refreshControl.addTarget(self, action: #selector(self.refreshHeadlines), for: .valueChanged);
        self.localFeed.refreshControl!.beginRefreshing();
        refreshHeadlines();
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
        composePage.categories = self.categories;
        composePage.delegate = self;
        self.present(composePage, animated: true, completion: nil);
    }
    
}

extension LocalFeed{

    func postHeadline(headline: Headline) {
        if(headline.globalOrLocal == 0){
            self.headlines.insert(headline, at: 0);
            self.localFeed.headlines = self.headlines;
            let insertIndex = IndexPath(item: 0, section: 0);
            self.localFeed.insertItems(at: [insertIndex]);
        }
    }
    
    func resetNavigationBar(){
        self.resetNavBar();
    }
}

extension LocalFeed{
    
    @objc func refreshHeadlines(){
        var userID = standard.object(forKey: "userID") as! String;
        userID = "0";
        let url = URL(string: "http://54.202.134.243:3000/load_headlines")!
        var request = URLRequest(url: url);
        let postBody = "userID=\(userID)"
        request.httpBody = postBody.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            if(err != nil){
                //show error
                DispatchQueue.main.async {
                    self.showErrorAlert();
                }
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response != "error"){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        
                        DispatchQueue.main.async {
                            //headlineIDs,posterIDs,posterNames,descriptions,upVotes,downVotes,chatRoomPopulations,categories
                            let headlineIDs = json["headlineIDs"] as! NSArray;
                            let posterIDs = json["posterIDs"] as! NSArray;
                            let posterNames = json["posterNames"] as! NSArray;
                            let descriptions = json["descriptions"] as! NSArray;
                            let upVotes = json["upVotes"] as! NSArray;
                            let downVotes = json["downVotes"] as! NSArray;
                            let chatRoomPopulations = json["chatRoomPopulations"] as! NSArray;
                            let categories = json["categories"] as! NSArray;
                            let categoryIDs = json["categoryIDs"] as! NSArray;
                            
                            var count = 0;
                            while(count<headlineIDs.count){
                                
                                let headlineID = String(headlineIDs[count] as! Int);
                                _ = String(posterIDs[count] as! Int);
                                let posterName = posterNames[count] as! String;
                                let description = descriptions[count] as! String;
                                let upVote = upVotes[count] as! Int;
                                let downVote = downVotes[count] as! Int;
                                let chatRoomPop = chatRoomPopulations[count] as! Int;
                                let category = categories[count] as! String;
                                let categoryID = categoryIDs[count] as! Int;
                                
                                let totalVoteCount = upVote - downVote;
                                
                                let newHeadline = Headline(headline: description, headlineID: headlineID, posterName: posterName, categoryName: category, categoryID: categoryID, voteCount: totalVoteCount, chatRoomPopulation: chatRoomPop, globalOrLocal: 0);
                                
                                self.headlines.append(newHeadline);
                                count+=1;
                            }
                            
                            DispatchQueue.main.async {
                                
                                self.localFeed.headlines = self.headlines;
                                self.localFeed.reloadData();
                                
                                self.refreshControl.endRefreshing();
                                
                            }
                            
                            
                
                        }
                    }catch{
                        print("error");
                    }
                }else{
                    //show error loading
                }
            }
        }
        task.resume();
        
        
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Ugh-Oh!", message: "It seems there was an error connecting to our servers... try again later ", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.refreshControl.endRefreshing();
        }))
        self.present(alert, animated: true, completion: nil);
    }
}
