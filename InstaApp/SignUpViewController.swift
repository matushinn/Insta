//
//  SignUpViewController.swift
//  InstaApp
//
//  Created by 大江祥太郎 on 2019/03/26.
//  Copyright © 2019 shotaro. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        userIdTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //改行が効くようになる
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUp(_ sender: Any) {
        let user = NCMBUser()
        if (userIdTextField.text?.characters.count)! <= 4{
            print("文字数が足りません。")
            return
        }
        user.userName = userIdTextField.text!
        user.mailAddress = emailTextField.text!
        
        if passwordTextField.text == confirmTextField.text {
            user.password = passwordTextField.text!
        }else{
            print("パスワードの不一致")
        }
        user.signUpInBackground { (error) in
            if error != nil{
                print(error)
            }else{
                //登録成功
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                //画面の切り替え
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                //ログインの保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
                
                
                
            }
        }
    }
    
    

}
