//
//  BlogDetailController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/20.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class BlogDetailController: UIViewController, UIWebViewDelegate {
    var id:String = "";
    var blog:NSMutableDictionary!;
    
    @IBOutlet weak var theWebView: UIWebView!
    
    var rest:BlogDetailRest = BlogDetailRest();
    
    ///初始化
    override func viewDidLoad() {
        rest.blogDetailController = self;
        rest.getData(id);
    }
    
    ///被rest回调
    func setWebViewContent(html:String){
        self.theWebView.loadHTMLString(html, baseURL: NSURL(string: "http://427studio.net/"));
    }
}
