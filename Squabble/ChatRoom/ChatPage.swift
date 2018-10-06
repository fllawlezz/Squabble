//
//  ChatPage.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol ChatPageDelegate{
    func resetNavigationBar();
}

class ChatPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate, SendMessageViewDelegate, ChatHeadlineBottomBarDelegate{
    
    var localFeedPage: LocalFeed?;
    var globalFeedPage: GlobalFeed?;
    
    let headlineReuse = "headline";
    let userMessageReuse = "userMessage";
    let otherMessageReuse = "otherMessage";
    
    let senders = ["user","other","user","user","other","other"]
    let messages = ["Donald Trump was elected teh 47th president of the United States after Barrack Obama. Obama was the first black president and Donald Trump was the first non laweyer/general politician.","FOREVER YOUNG! I WANT TO BE FOREVER YOUNG!!! DO YOU REALLY WANT TO LIVE FOREVER!!","Dude wtf is wrong with you?","Stop trolling us","I'm a crazy bitch! I Do what i want when I feel like it!!","But ok, I will stop XD"];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        localFeedPage?.handleCancel();//resets navigation bar
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
        self.collectionView?.keyboardDismissMode = .interactive;
        
    }
    
    lazy var sendMessageView: SendMessageView = {
        let sendMessageView = SendMessageView();
        sendMessageView.messageField.delegate = self;
        sendMessageView.sendMessageViewDelegate = self;
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
            cell.chatHeadlineBottomBarDelegate = self;
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let name = Notification.Name(rawValue: resignSendMessageView);
        NotificationCenter.default.post(name: name, object: nil);
    }
}

extension ChatPage{
    func scrollToBottom() {
//        print("scroll")
        let indexPath = IndexPath(row: self.senders.count-1, section: 1);
        self.collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true);
    }
    
    func showFlagAlert(){
        let alert = UIAlertController(title: "Flag?", message: "Flag this post as being inappropriate?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            print("flagged");
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
