//
//  ChatPage.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ChatPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate{
    var localFeedPage: LocalFeed?;
    var globalFeedPage: GlobalFeed?;
    
    let headlineReuse = "headline";
    let userMessageReuse = "userMessage";
    let otherMessageReuse = "otherMessage";
    
    let senders = ["user","other","user","user","other","other"]
    let messages = ["Donald Trump was elected teh 47th president of the United States after Barrack Obama. Obama was the first black president and Donald Trump was the first non laweyer/general politician.","FOREVER YOUNG! I WANT TO BE FOREVER YOUNG!!! DO YOU REALLY WANT TO LIVE FOREVER!!","Dude wtf is wrong with you?","Stop trolling us","I'm a crazy bitch! I Do what i want when I feel like it!!","But ok, I will stop XD"];
//    let messages = ["Yo wats up people!"];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        localFeedPage?.handleCancel();//resets navigation bar
//        setupSendMessageView();
        self.navigationItem.title = "Category";
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.montserratSemiBold(fontSize: 16)];
        navigationController?.navigationBar.titleTextAttributes = textAttributes;
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        self.collectionView?.register(ChatHeadlineCell.self, forCellWithReuseIdentifier: headlineReuse);
        self.collectionView?.register(UserMessageCell.self, forCellWithReuseIdentifier: userMessageReuse);
        self.collectionView?.register(OtherMessageCell.self, forCellWithReuseIdentifier: otherMessageReuse);
        self.collectionView?.delegate = self;
        self.collectionView?.dataSource = self;
        self.collectionView?.backgroundColor = UIColor.white;
//        self.collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 60, right: 0);
//        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 60, right: 0);
        self.collectionView?.keyboardDismissMode = .interactive;
        
    }
    
    lazy var sendMessageView: SendMessageView = {
        let sendMessageView = SendMessageView();
        sendMessageView.messageField.delegate = self;
//        sendMessageView.autoresizingMask = .flexibleHeight;
//        sendMessageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80);
        return sendMessageView;
    }()

    
    override var inputAccessoryView: UIView?{
        get{
            return sendMessageView;
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true;
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = "";
        textView.textColor = UIColor.black;
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headlineReuse, for: indexPath) as! ChatHeadlineCell
            return cell;
        }else{
            if(senders[indexPath.item] == "user"){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userMessageReuse, for: indexPath) as! UserMessageCell
                cell.setUserMessageText(message: messages[indexPath.item]);
                cell.bubbleWidthAnchor?.constant = self.estimateFrameForText(message: messages[indexPath.item]).width+20;
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: otherMessageReuse, for: indexPath) as! OtherMessageCell
                cell.bubbleViewWidthAnchor?.constant = self.estimateFrameForText(message: messages[indexPath.item]).width+20;
                cell.setMessage(message: messages[indexPath.item]);
                return cell;
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1;
        }else{
            return senders.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: self.view.frame.width, height: 150);
        }else{
//            print(messages[indexPath.item]);
            if(senders[indexPath.item] == "user"){
                let frame = estimateFrameForText(message: messages[indexPath.item]);
                return CGSize(width: self.view.frame.width, height: frame.height+30);
            }else{
                let frame = estimateFrameForText(message: messages[indexPath.item]);
                return CGSize(width: self.view.frame.width, height: frame.height+30+30);
            }
        }
    }
    
    private func estimateFrameForText(message: String)->CGRect{
        let approximateWidthOfChatCell = 200;
        let size = CGSize(width: approximateWidthOfChatCell, height: 1000);
        let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)];
        let estimatedFrame = NSString(string: message).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil);
        return estimatedFrame;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    
    
}
