//
//  ViewController.swift
//  Liqvidator
//
//  Created by Бекболат Куанышев on 03.03.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import UIKit
import Cartography

class GameViewController: UIViewController {

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
    
    private lazy var joinButton : UIButton = {
        let button = UIButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.join))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        button.sendActions(for: .touchUpInside)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setTitle("Join Game", for: .normal)
        button.titleLabel?.font = UIFont(name:"HelveticaNeue", size: 12.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var createButton : UIButton = {
        let button = UIButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.create))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        button.sendActions(for: .touchUpInside)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setTitle("Create Game", for: .normal)
        button.titleLabel?.font = UIFont(name:"HelveticaNeue", size: 12.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var myGamesButton : UIButton = {
        let button = UIButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.getGame))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        button.sendActions(for: .touchUpInside)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setTitle("My Games", for: .normal)
        button.titleLabel?.font = UIFont(name:"HelveticaNeue", size: 12.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Main"
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(joinButton)
        view.addSubview(createButton)
        view.addSubview(myGamesButton)
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
        constrain(view, titleLabel, joinButton, createButton, myGamesButton) {
            $2.top == $1.bottom + 40
            $2.centerX == $0.centerX
            $2.width == CGFloat(260)
            $2.height == CGFloat(40)
            
            $3.top == $2.bottom + 20
            $3.centerX == $0.centerX
            $3.width == CGFloat(260)
            $3.height == CGFloat(40)
            
            $4.top == $3.bottom + 20
            $4.centerX == $0.centerX
            $4.width == CGFloat(260)
            $4.height == CGFloat(40)
        }
    }
    
    @objc func join(sender: UIButton) {
        let newViewController = JoinViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func getGame(sender: UIButton) {
        
        let newViewController = MyGamesViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func create(sender: UIButton) {
        let newViewController = CreateViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

