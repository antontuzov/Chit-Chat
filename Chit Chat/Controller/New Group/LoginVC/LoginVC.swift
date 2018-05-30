//
//  SignInVC.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 30/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func signInDidTap(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil {
            
            AuthService.instance.loginUser(withEmail: emailTextField.text!, withPassword: passwordTextField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTextField.text!, withPassword: self.passwordTextField.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailTextField.text!, withPassword: self.passwordTextField.text!, loginComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                            print("Successfully registered user")
                        })
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
            })
        }
    }
    
    @IBAction func closeDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
}
