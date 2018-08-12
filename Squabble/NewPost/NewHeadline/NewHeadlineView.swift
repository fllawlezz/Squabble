//
//  NewHeadlineView.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NewHeadlineView: UIView, UITextViewDelegate {
    
    var composeNewHeadlinePage: ComposeNewHeadline?
    
    lazy var titleView: NormalUILabel = {
        let titleView = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 18), textAlign: .center);
        titleView.text = "Headline";
        return titleView;
    }()
    
    lazy var headlineTextView: HeadlineTextView = {
        let headlineTextView = HeadlineTextView();
        return headlineTextView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        setupTitleView();
        setupHeadlineTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleView(){
        self.addSubview(titleView);
        titleView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        titleView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupHeadlineTextView(){
        self.addSubview(headlineTextView);
        headlineTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        headlineTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        headlineTextView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10).isActive = true;
        headlineTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
        headlineTextView.delegate = self;
//        headlineTextView.delegate = self.composeNewHeadlinePage!;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.headlineTextView.resignFirstResponder();
    }
    
}
