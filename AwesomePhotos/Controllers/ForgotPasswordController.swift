//
//  ForgotPasswordController.swift
//  AwesomePhotos
//
//  Created by Apple on 3/31/19.
//  Copyright © 2019 Minh Quang Pham. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

//ForgotPasswordController for ForgotPasswordView
class ForgotPasswordController : GenericViewController<ForgotPasswordView> {
    
    //MARK: - UI
    func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-left"), style: .plain, target: self, action: #selector(handleGoBack))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate; //To enable go back to previous screen with left swipe
    }
    
    //MARK: - Init
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Selectors
    @objc func handleGoBack(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleForgotPassword() {
        guard let email = contentView.emailTextField.text else { return }
        sendResetPassword(email: email)
    }
    
    @objc func alertClose(gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - API
    func sendResetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in //Attempt to send reset password email
            //If send email fails
            if let error = error {
                print("Failed to send email with error: ", error.localizedDescription)
                let alert = UIAlertController(title: "Invalid email", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion:{
                    alert.view.superview?.isUserInteractionEnabled = true
                    alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose)))
                })
                return
            }
            //If send email succeeds
            let alert = UIAlertController(title: "Help is on the way!", message: "Check your inbox for a password reset link", preferredStyle: .alert)
            self.present(alert, animated: true, completion:{
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose)))
            })
        }
    }
}