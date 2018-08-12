//
//  numberOfPeopleInChatView.swift
//  Squabble
//
//  Created by Brandon In on 7/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NumberOfPeopleInChatView: UIView{
    
    lazy var numberOfPeopleInChatLabel: NormalUILabel = {
        let numberOfPeopleInChatLabel = NormalUILabel(textColor: UIColor.gray, font: UIFont.systemFont(ofSize: 12), textAlign: .center);
//        numberOfPeopleInChatLabel.text = "5/100";
//        numberOfPeopleInChatLabel.backgroundColor = UIColor.red;
        return numberOfPeopleInChatLabel;
    }()
    
    lazy var chatImage: UIImageView = {
        let chatImage = UIImageView();
        chatImage.translatesAutoresizingMaskIntoConstraints = false;
        chatImage.image = #imageLiteral(resourceName: "chatRoom");
        return chatImage;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupNumberOfPeopleInChatLabel();
//        setupChatImage();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupNumberOfPeopleInChatLabel(){
        self.addSubview(numberOfPeopleInChatLabel);
        numberOfPeopleInChatLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
//        numberOfPeopleInChatLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
//        numberOfPeopleInChatLabel.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        numberOfPeopleInChatLabel.widthAnchor.constraint(equalToConstant: UIscreenWidth!/3).isActive = true;
        numberOfPeopleInChatLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        numberOfPeopleInChatLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        let attachedImage = NSTextAttachment();
        attachedImage.image = #imageLiteral(resourceName: "chatRoom");
        attachedImage.bounds = CGRect(x: 0, y: -4, width: 15, height: 15);
        
        let attachmentString = NSAttributedString(attachment: attachedImage);
        let usersText = NSMutableAttributedString(string: "5/100 ");
        usersText.append(attachmentString);
        
        self.numberOfPeopleInChatLabel.attributedText = usersText;
        
    }
    
//    fileprivate func setupChatImage(){
//        self.addSubview(chatImage);
//        chatImage.leftAnchor.constraint(equalTo: self.numberOfPeopleInChatLabel.rightAnchor, constant: 5).isActive = true;
////        chatImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
////        chatImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
////        chatImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
//        chatImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
//        chatImage.heightAnchor.constraint(equalToConstant: 15).isActive = true;
//        chatImage.widthAnchor.constraint(equalToConstant: 15).isActive = true;
//    }
    
}
