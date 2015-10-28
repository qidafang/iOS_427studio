//
//  LoginController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/27.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var info: UILabel!
    
    var rest:LoginRest = LoginRest();
    
    @IBOutlet weak var userNameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    
    @IBOutlet weak var loginClicked: UIButton!
    
    //点击登录
    @IBAction func loginClicked(sender: AnyObject) {
        let userName = userNameInput.text!
        let password = passwordInput.text!
        
        rest.loginController = self;
        rest.login(userName, password: password);
    }
    
    //点击取消
    @IBAction func cancelClicked(sender: AnyObject) {
        closeLogin();
    }
    
    //关闭登录页面
    func closeLogin(){
        dismissViewControllerAnimated(true, completion: nil);
    }
}
