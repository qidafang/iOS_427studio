//
//  FavoriteManageDetailController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/27.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class FavoriteManageDetailController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var groups:NSArray!//用于保存下拉选项们
    
    var parent:FavoriteManageListController!
    
    var favorite:Favorite!//model
    
    var type:String = "";//标识：insert代表在新增，update代表在修改
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var linkInput: UITextField!
    @IBOutlet weak var descInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var groupSelect: UIPickerView!
    
    override func viewDidLoad() {
        self.titleInput.text = self.favorite.title;
        self.linkInput.text = self.favorite.link;
        self.descInput.text = self.favorite.desc;
        self.weightInput.text = self.favorite.weight;
        
        //获得select的选项
        let rest:GroupRest = GroupRest();
        rest.favoriteManageDetailController = self;
        rest.getData();
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        self.favorite.title = self.titleInput.text!
        self.favorite.link = self.linkInput.text!
        self.favorite.desc = self.descInput.text!
        self.favorite.weight = self.weightInput.text!
        //这行代码看起来长，其实很简单，获得类似网页中option上的value
        self.favorite.group = ((groups[groupSelect.selectedRowInComponent(0)] as! NSDictionary).valueForKey("id") as! NSNumber).stringValue
        
        if(type == "insert"){
            let rest:FavoriteAddRest = FavoriteAddRest();
            rest.favoriteManageListController = parent;
            rest.favoriteManageDetailController = self;
            rest.doAdd(self.favorite);
        }else if(type == "update"){
            let rest:FavoriteEditRest = FavoriteEditRest();
            rest.favoriteManageListController = parent;
            rest.favoriteManageDetailController = self;
            rest.doEdit(self.favorite);
        }
    }
    
    ///有几个select
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    ///每个select有几个选项
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groups.count
    }
    
    ///select的选项显示的汉字
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let g:NSDictionary = groups[row] as! NSDictionary;
        return g.valueForKey("name") as? String;
    }
    
    ///被获取下拉选项的rest调用的回调
    func reloadGroups(){
        groupSelect.dataSource = self;
        groupSelect.delegate = self;
        groupSelect.reloadAllComponents();
        
        //设置下拉框默认选中的值
        if(self.favorite.group != ""){
            var goalIndex:Int = 0;
            for(var i:Int = 0; i < groups.count; i++){
                let optionId:String = ((groups[i] as! NSDictionary).valueForKey("id") as! NSNumber).stringValue;
                if(optionId == self.favorite.group){
                    goalIndex = i;
                    break;
                }
            }
            groupSelect.selectRow(goalIndex, inComponent: 0, animated: false);
        }
    }
}
