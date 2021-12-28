//
//  FourthVC.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class FourthVC: UIViewController {

    @IBOutlet weak var userNickNameLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요

                        
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    UserApi.shared.me() {(user, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            if let profile = user?.kakaoAccount?.profile {
                                self.userNickNameLabel.text = profile.nickname
                                if profile.isDefaultImage ?? true {
                                
                                } else {
                                    if let url = profile.profileImageUrl {
                                        DispatchQueue.global().async {
                                            let data = try? Data(contentsOf: url)
                                            DispatchQueue.main.async {
                                                self.userProfileImageView.image = UIImage(data: data!)
                                            }
                                        }
                                    }
                                    
                                    
                                }
                            }

                            //do something
                            _ = user
                        }
                    }

                }
            }
        }
        else {
            //로그인 필요

        }

    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        self.loginViewShow()
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    
                }
            }
        }
        else {
            //로그인 필요
            self.loginViewShow()
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
        userProfileImageView.contentMode = .scaleAspectFill
        
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        
                        self.loginViewShow()
                        
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    UserApi.shared.me() {(user, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            if let profile = user?.kakaoAccount?.profile {
                                self.userNickNameLabel.text = profile.nickname
                                if profile.isDefaultImage ?? true {
                                
                                } else {
                                    if let url = profile.profileImageUrl {
                                        DispatchQueue.global().async {
                                            let data = try? Data(contentsOf: url)
                                            DispatchQueue.main.async {
                                                self.userProfileImageView.image = UIImage(data: data!)
                                            }
                                        }
                                    }
                                    
                                    
                                }
                            }
                            
                            
                            print("me() success.")
                            
                            
                            
                            
                            //do something
                            _ = user
                        }
                    }

                }
            }
        }
        else {
            //로그인 필요
            
            self.loginViewShow()
        
        }
        
    }
}


extension UIViewController {
    
    func loginViewShow() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
}
