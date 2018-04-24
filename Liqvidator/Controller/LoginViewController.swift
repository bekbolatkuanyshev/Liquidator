//
//  MainViewController.swift
//  Liqvidator
//
//  Created by Бекболат Куанышев on 16.04.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import UIKit
import UIView_Shake
import Cartography

class LoginViewController: UIViewController {
    
    var success = false
    
    private lazy var logoImageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "logo")
        return view
    }()
    
    private lazy var emailTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.textColor = .black
        field.textAlignment = .center
        field.clipsToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .white
        return field
    }()
    
    private lazy var passwordTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.textColor = .black
        field.textAlignment = .center
        field.clipsToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .white
        return field
    }()
    
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.login))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        button.sendActions(for: .touchUpInside)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name:"HelveticaNeue", size: 12.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var signupButton : UIButton = {
        let button = UIButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.signup))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        button.sendActions(for: .touchUpInside)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name:"HelveticaNeue", size: 12.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Liquidator"
        
        setupViews()
        setupConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
        
    }
    
    func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
    }
    
    func setupConstraints() {
        constrain(view, logoImageView) {
            $1.top == $0.top + 80
            $1.centerX == $0.centerX
            $1.width == CGFloat(250)
            $1.height == CGFloat(250)
            
        }
        constrain(view, logoImageView, emailTextField, passwordTextField) {
            $2.top == $1.bottom + 20
            $2.centerX == $0.centerX
            $2.width == CGFloat(260)
            $2.height == CGFloat(40)
            
            $3.top == $2.bottom + 20
            $3.centerX == $0.centerX
            $3.width == CGFloat(260)
            $3.height == CGFloat(40)
        }
        constrain(view, passwordTextField, loginButton, signupButton) {
            $2.top == $1.bottom + 20
            $2.centerX == $0.centerX
            $2.width == CGFloat(260)
            $2.height == CGFloat(40)
            
            $3.top == $2.bottom + 20
            $3.centerX == $0.centerX
            $3.width == CGFloat(260)
            $3.height == CGFloat(40)
        }
    }
    
    @objc func tapAction() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc func login(sender: UIButton) {
        let dict : Dictionary<String, Any> = ["email" : emailTextField.text!,
                                              "password": passwordTextField.text!
        ]
        
        APIManager.sharedInstance.logIn(parameters: dict, onSuccess: { (json) in
            if json["message"].string == "success" {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(json["token"].string, forKey: "token")
                    self.success = true
                    let newViewController = GameViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            } else {
                self.emailTextField.shake()
                self.passwordTextField.shake()
            }
            print ("Success ", json)
        }) { (Error) in
            self.emailTextField.shake()
            self.passwordTextField.shake()
            print ("Error ", Error.localizedDescription)
        }
    }
    
    @objc func signup(sender: UIButton) {
        emailTextField.text = ""
        passwordTextField.text = ""
        let newViewController = SignUpViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

