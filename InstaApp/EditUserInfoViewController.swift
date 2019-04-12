
//
//  EditUserInfoViewController.swift
//  InstaApp
//
//  Created by 大江祥太郎 on 2019/04/12.
//  Copyright © 2019 shotaro. All rights reserved.
//

import UIKit
import NCMB
//画像を読み込むためのライブラリ
import NYXImagesKit

class EditUserInfoViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.layer.cornerRadius = userImageView.bounds.width/2.0
        userImageView.layer.masksToBounds = true
        
        userNameTextField.delegate = self
        userIdTextField.delegate = self
        introductionTextView.delegate = self
        
        if let user = NCMBUser.current() {
            //displayNameとして保存
            userNameTextField.text = user.object(forKey: "displayName") as? String
            //既存にあるユーザーネームを入れる
            userIdTextField.text = user.userName
            //introductionとして保存
            introductionTextView.text = user.object(forKey: "introduction") as? String
            
            //既存に画像があるとして、その場合の読み込み
            let file = NCMBFile.file(withName:user.objectId,data:nil) as! NCMBFile
            file.getDataInBackground { (data, error) in
                if error != nil{
                    //エラーあったら
                    let alert = UIAlertController(title: "画像取得エラー", message: error?.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        //okした時の処理
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }else{
                    if data != nil{
                        let image = UIImage(data: data!)
                       //userimageViewに設定
                        self.userImageView.image = image
                        
                    }
                }
            }
            
        }else{
            //ログアウト状態だったら
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            //画面遷移
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            //ログイン状態の保持
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //エンターで終了
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //取り出した値を引数のInfoに入る
        let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        
        //ClipToBoundsにチェックを入れる
        //NYXImagesKit = タテヨコ比を維持しながらbyFactor倍掛けてくれる。
        let resizedImage = selectedImage.scale(byFactor:0.4)
        
        //pickerを出して閉じる
        picker.dismiss(animated: true, completion: nil)
        
        //let data = UIImagePNGRepresentation(resizedImage!)
        let data = resizedImage!.pngData()
        
        let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: data) as! NCMBFile
        file.saveInBackground({ (error) in
            if error != nil{
                let alert = UIAlertController(title: "画像アップロードエラー", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    //アップロード失敗時のエラー処理
                })
                
                alert.addAction(okAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.userImageView.image = selectedImage
            }
        }) { (progress) in
            print(progress)
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        //カメラ起動
        let actionController = UIAlertController(title: "画像の選択", message: "選択してください", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true{
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            }else{
                print("この機種ではカメラが使用できません。")
            }
        }
        
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            //アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true{
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            }else{
                print("この機種ではフォトライブラリが使用できません。")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            actionController.dismiss(animated: true, completion: nil)
        }
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        self.present(actionController, animated: true, completion: nil)
        
        
        
        
    }
    @IBAction func closeEditViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveUserInfo(_ sender: Any) {
        let user = NCMBUser.current()
        user?.setObject(userNameTextField.text, forKey: "displayName")
        user?.setObject(userIdTextField.text, forKey: "userName")
        user?.setObject(introductionTextView.text, forKey: "introduction")
        user?.saveInBackground({ (error) in
            if error != nil{
                let alert = UIAlertController(title: "送信エラー", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        })
    
    }
}
