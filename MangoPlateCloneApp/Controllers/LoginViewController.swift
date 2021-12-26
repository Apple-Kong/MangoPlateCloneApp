//
//  LoginViewController.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/27.
//


import UIKit

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
}
