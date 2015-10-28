//
//  FavoriteManageListController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/27.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class FavoriteManageListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var rest:FavoriteManageListRest = FavoriteManageListRest();
    
    var favList:NSMutableArray = [];
    
    @IBOutlet weak var theTableView: UITableView!
    
    ///初始化
    override func viewDidLoad() {
        reloadData();
    }
    
    ///从服务器加载数据
    func reloadData(){
        rest.favoriteManageListController = self;
        rest.getData();
    }
    
    func reloadCallback(){
        theTableView.dataSource = self;
        theTableView.delegate = self;
        theTableView.reloadData();
    }
    
    ///决定表格显示几行的重要方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    
    ///决定单元格内容的重要方法
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:FavoriteTableCell! = tableView.dequeueReusableCellWithIdentifier("favMngCell") as! FavoriteTableCell
        cell.controller = self;
        
        let index = favList.count - 1 - indexPath.row;
        
        let dict:NSMutableDictionary = (favList[index] as! NSMutableDictionary);
        
        let id = (dict.valueForKey("id") as! NSNumber).stringValue;
        let title = dict.valueForKey("title") as! String;
        let link = dict.valueForKey("link") as! String;
        let desc = dict.valueForKey("description") as! String;
        let weight = (dict.valueForKey("weight") as! NSNumber).stringValue;
        let group = (dict.valueForKey("favoriteGroupId") as! NSNumber).stringValue;
        
        let f:Favorite = Favorite();
        f.id = id;
        f.title = title;
        f.link = link;
        f.desc = desc;
        f.weight = weight;
        f.group = group;
        
        cell.f = f;
        
        cell.theLabel.text = title;
        
        return cell
    }
    
    @IBAction func addClicked(sender: AnyObject) {
        
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let favMngDetail:FavoriteManageDetailController = sb.instantiateViewControllerWithIdentifier("favMngDetail") as! FavoriteManageDetailController
        favMngDetail.favorite = Favorite();
        favMngDetail.parent = self;
        favMngDetail.type = "insert";
        
        showViewController(favMngDetail, sender: nil);
    }
    
    //点击删除按钮
    func deleteClicked(f:Favorite){
        let rest:FavoriteDeleteRest = FavoriteDeleteRest();
        rest.favoriteManageListController = self;
        rest.doDelete(f.id);
    }
    
    func editClicked(f:Favorite){
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let favMngDetail:FavoriteManageDetailController = sb.instantiateViewControllerWithIdentifier("favMngDetail") as! FavoriteManageDetailController
        favMngDetail.favorite = f;
        favMngDetail.parent = self;
        favMngDetail.type = "update";
        
        showViewController(favMngDetail, sender: nil);
    }
}
