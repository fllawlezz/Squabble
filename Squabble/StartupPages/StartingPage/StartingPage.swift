//
//  StartingPage.swift
//  Squabble
//
//  Created by Brandon In on 8/10/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class StartingPage:UIViewController,SignUpViewDelegate,LoginCredentialsDelegate{
    
    lazy var titleView: StartingPageTitleView = {
        let titleView = StartingPageTitleView();
        return titleView;
    }()
    
    lazy var loginCredentialsView: LoginCredentialsView = {
        let loginCredentialsView = LoginCredentialsView();
        return loginCredentialsView;
    }()
    
    lazy var signUpView: SignUpView = {
        let signUpView = SignUpView();
        return signUpView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        setupTitleView();
        setupLoginCredentialsView();
        setupSignUpView();
    }
    
    fileprivate func setupTitleView(){
        self.view.addSubview(titleView);
        titleView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        titleView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        titleView.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        if #available(iOS 11.0, *) {
            titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        } else {
            // Fallback on earlier versions
            titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        };
        
    }
    
    fileprivate func setupLoginCredentialsView(){
        self.view.addSubview(loginCredentialsView);
        loginCredentialsView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        loginCredentialsView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        loginCredentialsView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 20).isActive = true;
        loginCredentialsView.heightAnchor.constraint(equalToConstant: 195).isActive = true;
        
        loginCredentialsView.delegate = self;
    }
    
    fileprivate func setupSignUpView(){
        self.view.addSubview(signUpView);
        signUpView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpView.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        if #available(iOS 11.0, *) {
            signUpView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            signUpView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        };
        signUpView.delegate = self;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loginCredentialsView.resignAll();
    }
    
}

extension StartingPage{
    
    func handleSignUp() {
        let signUpPage = SignUpPage();
        self.navigationController?.pushViewController(signUpPage, animated: true);
    }
    
    func handleLoginAttempt() {
        standard.set("1", forKey: "login");
        
        let customTabBarController = CustomTabBarController();
        self.present(customTabBarController, animated: true, completion: nil);
    }
    
}
