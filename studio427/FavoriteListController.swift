//
//  BlogListController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/20.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class FavoriteListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rest:FavoriteListRest = FavoriteListRest();
    
    var favList:NSMutableArray = [];
    
    @IBOutlet weak var theTableView: UITableView!
    
    ///初始化
    override func viewDidLoad() {
        rest.favoriteListController = self;
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
        return favList.count
    }
    
    ///决定单元格内容的重要方法
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("favCell")
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: "favCell")
        }
        
        let index = favList.count - 1 - indexPath.row;
        
        cell.textLabel?.text = (favList[index] as! NSMutableDictionary).valueForKey("title") as! String;
        
        return cell
    }
    
    ///点击单元格时触发
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = favList.count - 1 - indexPath.row;
        let link = (favList[index] as! NSMutableDictionary).valueForKey("link") as! NSString;
        
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let favDetail:FavoriteDetailController = sb.instantiateViewControllerWithIdentifier("favDetail") as! FavoriteDetailController
        
        favDetail.link = link as String;
        
        showViewController(favDetail, sender: nil);
        
    }
}
