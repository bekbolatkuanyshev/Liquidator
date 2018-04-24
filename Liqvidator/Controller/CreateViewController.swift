//
//  CreateViewController.swift
//  Liqvidator
//
//  Created by Бекболат Куанышев on 04.03.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import UIKit
import Cartography

class CreateViewController: UIViewController {

    let datePicker = UIDatePicker()
    
    private lazy var logoImageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "logo")
        return view
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Liquidator"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        return label
    }()
    
    private lazy var gameNameField : UITextField = {
        let field = UITextField()
        field.placeholder = "set game name"
        field.backgroundColor = .white
        field.textColor = .black
        field.textAlignment = .center
        return field
    }()
    
    private lazy var startTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Start Time"
        field.backgroundColor = .white
        field.textColor = .black
        field.textAlignment = .center
        return field
    }()
    
    private lazy var endTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "End Time"
        field.backgroundColor = .white
        field.textColor = .black
        field.textAlignment = .center
        return field
    }()
    
    private lazy var countTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "People count"
        field.backgroundColor = .white
        field.textColor = .black
        field.textAlignment = .center
        return field
    }()
    
    private lazy var createButton : UIButton = {
        let button = UIButton()
        button.sendActions(for: .touchUpInside)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setTitle("Create Game", for: .normal)
        button.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateViewController.create))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
        createDatePicker()
    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: false)
        startTextField.inputAccessoryView = toolBar
        startTextField.inputView = datePicker
        
        endTextField.inputAccessoryView = toolBar
        endTextField.inputView = datePicker
    }
    
    @objc func donePressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        if (startTextField.isEditing) {
            startTextField.text = "Start time: " + dateFormatter.string(from: datePicker.date)
        } else {
            endTextField.text = "End time: " + dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }
    
    @objc func create() {
        let dict : Dictionary<String, Any> = ["title" : gameNameField.text!]
        
        APIManager.sharedInstance.createGame(parameters: dict, onSuccess: { (JSON) in
            if JSON["message"].string == "success" {
                DispatchQueue.main.async {
                    let newViewController : UINavigationController = self.navigationController!
                    newViewController.popViewController(animated: true)
                }
            }
            print ("Success ", JSON)
        }) { (Error) in
            print ("Error ", Error.localizedDescription)
        }
    }
    
    func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(gameNameField)
        view.addSubview(startTextField)
        view.addSubview(endTextField)
        view.addSubview(countTextField)
        view.addSubview(createButton)
    }
    
    func setupConstraints() {
        constrain(view, logoImageView, titleLabel) {
            $1.top == $0.top + 80
            $1.centerX == $0.centerX
            $1.width == CGFloat(250)
            $1.height == CGFloat(250)
            
            $2.top == $1.bottom
            $2.centerX == $1.centerX
            $2.height == CGFloat(30)
        }
        constrain(view, gameNameField, startTextField, endTextField) {
            $1.top == $0.top + 120
            $1.leading == $0.leading + 20
            $1.trailing == $0.trailing - 20
            $1.height == CGFloat(30)
                
            $2.top == $1.bottom + 25
            $2.leading == $0.leading + 20
            $2.trailing == $0.trailing - 20
            $2.height == CGFloat(30)
            
            $3.top == $2.bottom + 25
            $3.leading == $0.leading + 20
            $3.trailing == $0.trailing - 20
            $3.height == CGFloat(30)   
        }
        
        constrain(endTextField, createButton) {
            $1.top == $0.bottom + 20
            $1.centerX == $0.centerX
            $1.width == CGFloat(200)
            $1.height == CGFloat(50)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
