//
//  BlogDetailController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/20.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class FavoriteDetailController: UIViewController, UIWebViewDelegate {
    var link:String = "";
    
    @IBOutlet weak var theWebView: UIWebView!
    
    ///初始化
    override func viewDidLoad() {
        let url = NSURL(string: self.link);
        let request = NSURLRequest(URL: url!);
        theWebView.loadRequest(request);
        theWebView.delegate = self;
    }
    
}
