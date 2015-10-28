//
//  NoteListController.swift
//  studio427
//
//  Created by 祁达方 on 15/10/22.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class NoteListController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var theTableView: UITableView!
    
    var dao:NoteDao = NoteDao.instance();
    var noteList:NSMutableArray!;
    
    ///初始化
    override func viewDidLoad() {
        self.reloadData();
        theTableView.delegate = self;
    }
    
    func reloadData(){
        noteList = dao.select();
        
        theTableView.dataSource = self;
        theTableView.reloadData();
    }
    
    @IBAction func addClicked(sender: AnyObject) {
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let noteForm:NoteDetailController = sb.instantiateViewControllerWithIdentifier("noteForm") as! NoteDetailController;
        noteForm.type = "insert";
        noteForm.parent = self;
        showViewController(noteForm, sender: nil);
    }
    
    func editClicked(id:Int, content:String){
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let noteForm:NoteDetailController = sb.instantiateViewControllerWithIdentifier("noteForm") as! NoteDetailController;
        noteForm.type = "update";
        noteForm.parent = self;
        noteForm.id = id;
        noteForm.content = content;
        showViewController(noteForm, sender: nil);
    }
    
    ///决定表格显示几行的重要方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count;
    }
    
    ///决定单元格内容的重要方法
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NoteTableCell! = tableView.dequeueReusableCellWithIdentifier("noteCell") as? NoteTableCell
        let note:Note = (noteList.objectAtIndex(indexPath.row) as! Note);
        cell.theLable?.text = note.content;
        cell.id = note.id;
        cell.content = note.content;
        cell.controller = self;
        
        return cell
    }
    

}
