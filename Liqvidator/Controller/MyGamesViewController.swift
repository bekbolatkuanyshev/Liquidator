//
//  MyGamesViewController.swift
//  Liqvidator
//
//  Created by Бекболат Куанышев on 24.04.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cartography

class MyGamesViewController: UIViewController {
    
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
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
        
        get()
    }
    
    
    func get() {
        
        APIManager.sharedInstance.getGame(parameters: [:], onSuccess: { (JSON) in
            
            print ("Success ", JSON)
            DispatchQueue.main.async {
//                self.nameLabel.text = JSON["title"]
            }
        }) { (Error) in
            print ("Error ", Error.localizedDescription)
        }
    }
    
    @objc func join() {
//        let dict : Dictionary<String, Any> = ["code" : codeTextField.text!]
//
//        APIManager.sharedInstance.joinGame(parameters: dict, onSuccess: { (JSON) in
//            print ("Success ", JSON)
//        }) { (Error) in
//            print ("Error ", Error.localizedDescription)
//        }
    }
    
    func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
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
//        constrain(view, codeTextField) {
//            $1.top == $0.top + 120
//            $1.leading == $0.leading + 20
//            $1.trailing == $0.trailing - 20
//            $1.height == CGFloat(30)
//        }
//
//        constrain(codeTextField, createButton) {
//            $1.top == $0.bottom + 20
//            $1.centerX == $0.centerX
//            $1.width == CGFloat(200)
//            $1.height == CGFloat(50)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
