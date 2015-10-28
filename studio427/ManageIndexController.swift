//
//  ManageIndexController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/26.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class ManageIndexController: UIViewController {

    @IBAction func favoriteClicked(sender: AnyObject) {
        if(Holder.token == ""){
            
            let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginController:LoginController = sb.instantiateViewControllerWithIdentifier("loginController") as! LoginController
            
            //新窗口登录，而不是通常的导航窗口前进方式，这就是presentViewController与showViewController的不同
            self.presentViewController(loginController, animated: true, completion: nil)
        }else{
            
            let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let favoriteManageListController:FavoriteManageListController = sb.instantiateViewControllerWithIdentifier("favoriteManageListController") as! FavoriteManageListController
            
            showViewController(favoriteManageListController, sender: nil);
        }
    }
}
