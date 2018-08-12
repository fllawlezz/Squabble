//
//  ComposeNewHeadline.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol ComposeNewHeadlineDelegate {
    func postHeadline(globalOrLocal: Int);
}

class ComposeNewHeadline: UIViewController, UITextViewDelegate,NewHeadLineTitleViewDelegate{
    
    var delegate: ComposeNewHeadlineDelegate?
    
    lazy var postButton: NormalUIButton = {
        let postButton = NormalUIButton(backgroundColor: UIColor.appBlue, title: "Post Headline", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.white);
        return postButton;
    }()
    
    lazy var backgroundTopCover: UIView = {
        let backgroundTopCover = UIView();
        backgroundTopCover.translatesAutoresizingMaskIntoConstraints = false;
        backgroundTopCover.backgroundColor = UIColor.appBlue;
        return backgroundTopCover;
    }()
    
    lazy var titleView: NewHeadlineTitleView = {
        let titleView = NewHeadlineTitleView();
        titleView.translatesAutoresizingMaskIntoConstraints = false;
        titleView.delegate = self;
        return titleView;
    }()
    
    lazy var newHeadlineView: NewHeadlineView = {
        let newHeadlineView = NewHeadlineView();
        return newHeadlineView;
    }()
    
    lazy var buttonViews: HeadlineAnonymousView = {
        let buttonViews = HeadlineAnonymousView();
        buttonViews.translatesAutoresizingMaskIntoConstraints = false;
        return buttonViews;
    }()
    
    lazy var localorGlobalView: LocalOrGlobalView = {
        let localOrGlobalView = LocalOrGlobalView();
        return localOrGlobalView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupTopBackground();
        setupPostButton();
        setupTitleView();
        setupNewHeadlineView();
        setupButtonViews();
        setupLocalOrGlobalView();
    }
    
    fileprivate func setupPostButton(){
        self.view.addSubview(postButton);
        postButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        postButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        if #available(iOS 11.0, *) {
            postButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            // Fallback on earlier versions
            postButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        };
        postButton.addTarget(self, action: #selector(postHeadline), for: .touchUpInside);
    }
    
    fileprivate func setupTitleView(){
        self.view.addSubview(titleView);
        titleView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        titleView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        titleView.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        if #available(iOS 11.0, *) {
            titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            titleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        };
    }
    
    fileprivate func setupTopBackground(){
        self.view.addSubview(backgroundTopCover);
        backgroundTopCover.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        backgroundTopCover.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        backgroundTopCover.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        backgroundTopCover.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupNewHeadlineView(){
        self.view.addSubview(newHeadlineView);
        newHeadlineView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        newHeadlineView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        newHeadlineView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10).isActive = true;
        newHeadlineView.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        
//        newHeadlineView.composeNewHeadlinePage = self;
//        newHeadlineView.backgroundColor = UIColor.red;
    }
    
    fileprivate func setupButtonViews(){
        self.view.addSubview(buttonViews);
        buttonViews.topAnchor.constraint(equalTo: self.newHeadlineView.bottomAnchor).isActive = true;
        buttonViews.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        buttonViews.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        buttonViews.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        
    }
    
    fileprivate func setupLocalOrGlobalView(){
        self.view.addSubview(localorGlobalView);
        localorGlobalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        localorGlobalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        localorGlobalView.topAnchor.constraint(equalTo: self.buttonViews.bottomAnchor).isActive = true;
        localorGlobalView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.newHeadlineView.headlineTextView.resignFirstResponder();
    }
}

extension ComposeNewHeadline{
    
    @objc func postHeadline(){
        //get info
        
        //post to server and into the queue
        
        delegate?.postHeadline(globalOrLocal: 0);
//        self.navigationController?.popViewController(animated: true);
        self.dismiss(animated: true, completion: nil);
    }
    
    func didCancel() {
        self.newHeadlineView.headlineTextView.resignFirstResponder();
        self.dismiss(animated: true, completion: nil);
    }
    
}
