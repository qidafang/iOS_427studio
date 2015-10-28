//
//  BlogListController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/20.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class BlogListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var rest:BlogListRest = BlogListRest();
    
    var blogList:NSMutableArray = [];
    
    @IBOutlet weak var theTableView: UITableView!
    
    ///初始化
    override func viewDidLoad() {
        rest.blogListController = self;
        rest.getData();
    }
    
    ///被rest回调
    func reloadData(){
        theTableView.dataSource = self;
        theTableView.reloadData();
        
        theTableView.delegate = self;
    }
    
    ///决定表格显示几行的重要方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogList.count
    }
    
    ///决定单元格内容的重要方法
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("myCell")
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
        }
        
        let index = blogList.count - 1 - indexPath.row;
        
        cell.textLabel?.text = (blogList[index] as! NSMutableDictionary).valueForKey("title") as! String;
        
        return cell
    }

    ///点击单元格时触发
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = blogList.count - 1 - indexPath.row;
        let id = (blogList[index] as! NSMutableDictionary).valueForKey("id") as! NSNumber;
        NSLog("%d", id);
        
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let blogDetail:BlogDetailController = sb.instantiateViewControllerWithIdentifier("blogDetail") as! BlogDetailController
        
        blogDetail.id = id.stringValue;
        
        showViewController(blogDetail, sender: nil);

    }
}
