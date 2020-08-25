//
//  SecondTableViewCell.swift
//  DeletablePageVC
//
//  Created by ichikawa on 2020/08/22.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

class ChildTableViewCell: UITableViewCell {

    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ text: String) {
        self.label.text = text
    }
}
