//
//  JoinViewController.swift
//  Liqvidator
//
//  Created by Бекболат Куанышев on 04.03.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import UIKit
import Cartography

class SignUpViewController: UIViewController {

    private lazy var logoImageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "logo")
        return view
    }()
    
    private lazy var nameTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.textColor = .black
        field.textAlignment = .center
        field.clipsToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .white
        return field
    }()
    
    private lazy var surnameTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Surname"
        field.textColor = .black
        field.textAlignment = .center
        field.clipsToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .white
        return field
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
    
    private lazy var enterButton : UIButton = {
        let button = UIButton()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.click))
//        button.isUserInteractionEnabled = true
//        button.addGestureRecognizer(tap)
        button.sendActions(for: .touchUpInside)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.register))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        return button
    }()
    
//    func getUserInfo() {
//        APIManager.sharedInstance.getDetail(parameters: [:], onSuccess: { (JSON) in
//            print ("Success ", JSON)
//        }) { (Error) in
//            print ("Error ", Error.localizedDescription)
//        }
//    }
    
    func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(enterButton)
    }
    
    func setupConstraints() {
        constrain(view, logoImageView) {
            $1.top == $0.top + 50
            $1.centerX == $0.centerX
            $1.width == CGFloat(250)
            $1.height == CGFloat(250)
        }
        
        constrain(view, logoImageView, nameTextField) {
            $2.top == $1.bottom + 40
            $2.centerX == $0.centerX
            $2.width == CGFloat(260)
            $2.height == CGFloat(40)
        }
        
        constrain(nameTextField, surnameTextField, emailTextField, passwordTextField) {
            $1.centerX == $0.centerX
            $1.width == $0.width
            $1.height == $0.height
            $1.top == $0.bottom + 10
            
            $2.centerX == $1.centerX
            $2.width == $1.width
            $2.height == $1.height
            $2.top == $1.bottom + 10
            
            $3.centerX == $2.centerX
            $3.width == $2.width
            $3.height == $2.height
            $3.top == $2.bottom + 10
        }
        
        constrain(passwordTextField, enterButton) {
            $1.top == $0.bottom + 20
            $1.centerX == $0.centerX
            $1.width == CGFloat(260)
            $1.height == CGFloat(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
        
        navigationItem.title = "Sign Up"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    }
    
    @objc func register() {
        let dict : Dictionary<String, Any> = ["name" : nameTextField.text!,
                                              "surname": surnameTextField.text!,
                                              "email" : emailTextField.text!,
                                              "password": passwordTextField.text!,
                                              "c_password": passwordTextField.text!]
        
        APIManager.sharedInstance.register(parameters: dict, onSuccess: { (json) in
            if json["message"].string == "success" {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(json["token"].string, forKey: "token")
                    let newViewController : UINavigationController = self.navigationController!
                    newViewController.popViewController(animated: true)
                }
            }
            print ("Success ", json)
        }) { (Error) in
            print ("Error ", Error.localizedDescription)
        }
    }
    
    @objc func tapAction() {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
