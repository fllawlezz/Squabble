//
//  SignUpCollectionView.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SignUpCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SignUpCollectionViewCellDelegate{
    
    let reuseField = "reuseField";
    let cellTitles = ["UserName","FirstName","LastName","Email","Password"];
    
    var signUpPage: SignUpPage?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.clear;
        self.register(SignUpCollectionViewCell.self, forCellWithReuseIdentifier: reuseField);
        self.delegate = self;
        self.dataSource = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func resignAll(){
        var count = 0;
        while(count < 5){
            let indexPath = IndexPath(item: count, section: 0);
            let cell = self.cellForItem(at: indexPath) as! SignUpCollectionViewCell;
            cell.inputTextField.resignFirstResponder();
            count+=1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseField, for: indexPath) as! SignUpCollectionViewCell
        cell.setData(title: cellTitles[indexPath.item], placeholderString: cellTitles[indexPath.item]);
        cell.cellIndex = indexPath.item;
        cell.delegate = self;
        if(indexPath.item == 3){
            cell.inputTextField.keyboardType = .emailAddress;
        }else if(indexPath.item == 4){
            cell.inputTextField.isSecureTextEntry = true;
        }
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 50);
    }
}

extension SignUpCollectionView{
    func nextTextField(cellIndex: Int) {
        let nextCellIndex = cellIndex+1;
        let newIndexPath = IndexPath(item: nextCellIndex, section: 0);
        let nextCell = self.cellForItem(at: newIndexPath) as! SignUpCollectionViewCell;
        nextCell.inputTextField.becomeFirstResponder();
    }
}
