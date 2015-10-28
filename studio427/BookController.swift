//
//  BookController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/21.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class BookController: UIViewController {

    @IBOutlet weak var theWebView: UIWebView!
    
    var rest:BookRest = BookRest();
    
    ///初始化
    override func viewDidLoad() {
        rest.bookController = self;
        rest.getData();
    }
    
    ///被rest回调
    func setWebViewContent(html:String){
        self.theWebView.loadHTMLString(html, baseURL: NSURL(string: "http://427studio.net/"));
    }
}
