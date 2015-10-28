//
//  NoteDetailController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/22.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class NoteDetailController: UIViewController {
    
    var parent:NoteListController!
    
    var type:String = "";
    
    var dao:NoteDao = NoteDao.instance();
    
    var id:Int = 0;
    var content:String = "";

    @IBOutlet weak var contentInput: UITextField!
    
    override func viewDidLoad() {
        self.contentInput.text = self.content;
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        let c:String = contentInput.text!;
        
        if(type == "insert"){
            dao.insert(c);
        }else if(type == "update"){
            dao.update(id, content: c);
        }
        
        //让父页面重新载入数据并隐藏当前页面
        parent.reloadData();
        (self.parentViewController as! UINavigationController).popViewControllerAnimated(true);
    }
    
}
