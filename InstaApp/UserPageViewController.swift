//
//  UserPageViewController.swift
//  InstaApp
//
//  Created by 大江祥太郎 on 2019/04/11.
//  Copyright © 2019 shotaro. All rights reserved.
//

import UIKit
import NCMB

class UserPageViewController: UIViewController {
    @IBOutlet weak var userImageVIew: UIImageView!
    
    @IBOutlet weak var userDisplayNameLabel: UILabel!
    @IBOutlet weak var userIntroductionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //imageView丸くなる
        userImageVIew.layer.cornerRadius = userImageVIew.bounds.width/2.0
        userImageVIew.layer.masksToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        //ユーザー情報の読み込み
        let user = NCMBUser.current()
        if let user = NCMBUser.current(){
            userDisplayNameLabel.text = user.object(forKey: "displayName") as? String
            userIntroductionTextView.text = user.object(forKey: "introduction") as? String
            self.navigationItem.title = user.userName
            
            //画像読み込み
            let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: nil) as! NCMBFile
            
            file.getDataInBackground { (data, error) in
                if error != nil{
                    print(error)
                }else{
                    if data != nil{
                        let image = UIImage(data: data!)
                        self.userImageVIew.image = image
                        
                    }
                }
            }
            
        }else{
            //NCMBUser.current()現在のユーザーがいなかったら
            //ログアウト成功
            //SignIn Storyboardをインスタンス化
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            //SignInstoryboardのインスタンスを取得する
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            //画面の切り替え
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            //ログイン状態の保持
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
            
            
            
        }
        
    }
    
    @IBAction func showMenu(_ sender: Any) {
        let alertController = UIAlertController(title: "メニュー", message: "メニューを選択してください。", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground({ (error) in
                if error != nil{
                    print(error)
                }else{
                    //ログアウト成功
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewCOntroller = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    //画面の切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewCOntroller
                    
                    //ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                    
                    
                    
                }
            })
        }
        
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            user?.deleteInBackground({ (error) in
                if error != nil{
                    print(error)
                }else{
                    //ログアウト成功
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationControler")
                    //画面に切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    //ログイン状態の処理
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                    
                    
                    
                }
            })
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(signOutAction)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
        
        
        
        
    }
    
    
    
}
