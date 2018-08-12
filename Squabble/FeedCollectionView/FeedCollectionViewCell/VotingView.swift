//
//  VotingView.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class VotingView: UIView{
    
    lazy var upvoteButton: NormalUIButton = {
        let upvoteButton = NormalUIButton(backgroundColor: UIColor.white, title: "", font: UIFont.montserratRegular(fontSize: 14), fontColor: UIColor.black);
        upvoteButton.setBackgroundImage(#imageLiteral(resourceName: "upvote"), for: .normal);
        return upvoteButton;
    }();
    
    lazy var downvoteButton: NormalUIButton = {
        let downvoteButton = NormalUIButton(backgroundColor: UIColor.white, title: "", font: UIFont.montserratRegular(fontSize: 14), fontColor: UIColor.black);
        downvoteButton.setBackgroundImage(#imageLiteral(resourceName: "downvote"), for: .normal);
        return downvoteButton;
    }();
    
    lazy var voteCount: NormalUILabel = {
        let votecount = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 18), textAlign: .center);
        votecount.text = "15";
        return votecount;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupVoteCount();
        setupUpvoteButton();
        setupDownvoteButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupVoteCount(){
        self.addSubview(voteCount);
        voteCount.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        voteCount.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        voteCount.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        voteCount.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupUpvoteButton(){
        self.addSubview(upvoteButton);
//        upvoteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        upvoteButton.bottomAnchor.constraint(equalTo: self.voteCount.topAnchor, constant: -10).isActive = true;
        upvoteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        upvoteButton.heightAnchor.constraint(equalToConstant: 22).isActive = true;
        upvoteButton.widthAnchor.constraint(equalToConstant: 22).isActive = true;
    }
    
    fileprivate func setupDownvoteButton(){
        self.addSubview(downvoteButton);
//        downvoteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
        downvoteButton.topAnchor.constraint(equalTo: self.voteCount.bottomAnchor, constant: 10).isActive = true;
        downvoteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        downvoteButton.heightAnchor.constraint(equalToConstant: 22).isActive = true;
        downvoteButton.widthAnchor.constraint(equalToConstant: 22).isActive = true;
    }
    
    func setVoteCount(voteCount: Int){
        self.voteCount.text = String(voteCount);
    }
    
}
