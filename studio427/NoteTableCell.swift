//
//  NoteTableCell.swift
//  studio427
//
//  Created by 祁达方 on 15/10/22.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class NoteTableCell: UITableViewCell {
    
    var controller:NoteListController!
    var dao:NoteDao = NoteDao.instance();
    
    var id:Int = 0;
    var content:String = "";
    @IBOutlet weak var theLable: UILabel!
    
    @IBAction func deleteClicked(sender: AnyObject) {
        dao.delete(id);
        controller.reloadData();
    }
    
    @IBAction func editClicked(sender: AnyObject) {
        controller.editClicked(id, content: content);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
}
