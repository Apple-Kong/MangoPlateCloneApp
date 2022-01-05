//
//  LoginViewController.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/27.
//


import UIKit
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookButton.layer.masksToBounds = true
        facebookButton.layer.cornerRadius = 20
        facebookButton.imageView?.contentMode = .scaleAspectFill
        facebookButton.imageView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        kakaoButton.layer.masksToBounds = true
        kakaoButton.layer.cornerRadius = 20
        
        appleButton.layer.masksToBounds = true
        appleButton.layer.cornerRadius = 20
        appleButton.imageView?.contentMode = .scaleAspectFill
        appleButton.imageView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        emailButton.layer.masksToBounds = true
        emailButton.layer.cornerRadius = 20
    }
    
    
    @IBAction func skipButtonTap(_ sender: Any) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    @IBAction func loginButtonTap(_ sender: UIButton) {
        let id = sender.restorationIdentifier
        
        if id == "kakao" {
            //카카오계정 정보를 입력하여 로그인합니다
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")
                        
                        //로그인 성공.

                        //do something
                        _ = oauthToken
                        
                        self.dismiss(animated: true) {
                            print("dismissed")
                            
                            //뷰 디스미스 시
                        }
                        
                      
                    }
                }
        }
    }
}
