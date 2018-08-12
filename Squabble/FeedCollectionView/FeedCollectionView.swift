//
//  LocalFeedCollectionView.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class FeedCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var localFeedPage: LocalFeed?;
    var globalFeedPage: GlobalFeed?;
    
    var feedReuse = "feedReuse";
    var mockupNames = ["Anonymous","Swarles Barkley","Dr.Julius Erving"];
    var mockupHeadlines = ["Ray Charles turned republican! All liberals come and bash him now!!","Swarles Barkely gave the New York Moons a good beating today. What do you guys think about the game?","Dr.J did a windmill dunk today at the age of 72!!! Who else can dunk at that age?!?"];
    var mockUpCategories = ["Politics","Sports","Sports"];
    var voteMockUps = [3,20,55];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0);
        self.backgroundColor = UIColor.veryLightGray;
        self.delegate = self;
        self.dataSource = self;
        self.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: feedReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedReuse, for: indexPath) as! FeedCollectionViewCell;
        cell.setPosterName(posterName: mockupNames[indexPath.item]);
        cell.setheadline(headline: mockupHeadlines[indexPath.item]);
        cell.setCategory(categoryName: mockUpCategories[indexPath.item]);
        cell.setVotingValue(voteValue: voteMockUps[indexPath.item]);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width-20, height: 130);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout();
        let chatPage = ChatPage(collectionViewLayout: layout);
        chatPage.hidesBottomBarWhenPushed = true;
        chatPage.title = "Category";
//        chatPage.localFeedPage = self.localFeedPage;
        
        localFeedPage?.resetNavBar();
        
        self.localFeedPage?.navigationController?.pushViewController(chatPage, animated: true);
        self.globalFeedPage?.navigationController?.pushViewController(chatPage, animated: true);
    }
    
}
