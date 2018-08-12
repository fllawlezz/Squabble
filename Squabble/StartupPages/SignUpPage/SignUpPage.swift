//
//  SignUpPage.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let keyboardUpNotification = Notification.Name("keyboardUp");
let keyboardDownNotification = Notification.Name("keyboardDown");


class SignUpPage: UIViewController, SignUpTitleViewDelegate{
    
    lazy var signUpTitleView: SignUpTitleView = {
        let signUpTitleView = SignUpTitleView();
        return signUpTitleView;
    }()
    
    lazy var signUpCollectionView: SignUpCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let signUpCollectionView = SignUpCollectionView(frame: .zero, collectionViewLayout: layout);
        return signUpCollectionView;
    }()
    
    lazy var signUpBottomView: SignUpBottomView = {
        let signUpBottomView = SignUpBottomView();
        return signUpBottomView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        createObservers();
        setupSignUpTitle();
        setupCollectionView();
        setupBottomView();
    }
    
    fileprivate func setupSignUpTitle(){
        self.view.addSubview(signUpTitleView);
        signUpTitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpTitleView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        if #available(iOS 11.0, *) {
            signUpTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            signUpTitleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        };
        signUpTitleView.delegate = self;
    }
    
    fileprivate func setupCollectionView(){
        self.view.addSubview(signUpCollectionView);
        signUpCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpCollectionView.topAnchor.constraint(equalTo: self.signUpTitleView.bottomAnchor).isActive = true;
        signUpCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true;
    }
    
    fileprivate func setupBottomView(){
        self.view.addSubview(signUpBottomView);
        signUpBottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpBottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpBottomView.topAnchor.constraint(equalTo: self.signUpCollectionView.bottomAnchor, constant: 15).isActive =  true;
        signUpBottomView.heightAnchor.constraint(equalToConstant: 100).isActive = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.signUpCollectionView.resignAll();
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0;
        }
    }
    
    fileprivate func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: keyboardUpNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: keyboardDownNotification, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc func keyboardWillShow(notification: Notification){
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -50;
        }
    }
    
    @objc func keyboardDown(){
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0;
        }
    }
}

extension SignUpPage{
    func handleClear() {
        self.navigationController?.popViewController(animated: true);
    }
}
