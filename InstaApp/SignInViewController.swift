//
//  SignInViewController.swift
//  InstaApp
//
//  Created by 大江祥太郎 on 2019/04/11.
//  Copyright © 2019 shotaro. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //定型文
        userIdTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //エンターキーで返す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signIn(_ sender: Any) {
        if userIdTextField.text != nil && passwordTextField.text != nil{
            NCMBUser.logInWithUsername(inBackground: userIdTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil{
                    print(error)
                }else{
                    //ログイン成功
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    //画面の切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                    
                }
            }
        }
    }
    @IBAction func forgetPassword(_ sender: Any) {
        //置いていく
    }
    
    

}
