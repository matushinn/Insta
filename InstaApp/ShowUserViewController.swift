//
//  ShowUserViewController.swift
//  InstaApp
//
//  Created by 大江祥太郎 on 2019/04/12.
//  Copyright © 2019 shotaro. All rights reserved.
//

/*
 #これでリサイズできる
 pod 'NYXImagesKit'
 #TextViewはplaceholderが付いてないから
 pod 'UITextView+Placeholder'
 #loading
 pod 'SVProgressHUD'
 #画像を非同期で読み込む
 pod 'Kingfisher'
 #日付を簡単に扱える
 pod 'SwiftDate'
 */
import UIKit
import NCMB
import Kingfisher
import SVProgressHUD


class ShowUserViewController: UIViewController {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userDisplayNameLabel: UILabel!
    @IBOutlet weak var userIntroduceTextVIew: UITextView!
    @IBOutlet weak var photoCollectionVIew: UICollectionView!
    @IBOutlet weak var postCountLabel: UILabel!
   
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //photoCollectionVIew.dataSource = self
        userImageView.layer.cornerRadius = userImageView.bounds.width/2.0
        userImageView.layer.masksToBounds = true
        
        
    }
    /*
    //返す画像の数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    //セルの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    */

    
    

    

}
