//
//  NoteTableCell.swift
//  studio427
//
//  Created by 祁达方 on 15/10/22.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

class FavoriteTableCell: UITableViewCell {
    
    var controller:FavoriteManageListController!
    
    var f:Favorite!
    
    @IBOutlet weak var theLabel: UILabel!
    
    @IBAction func deleteClicked(sender: AnyObject) {
        controller.deleteClicked(f);
    }
    
    @IBAction func editClicked(sender: AnyObject) {
        controller.editClicked(f);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
}
