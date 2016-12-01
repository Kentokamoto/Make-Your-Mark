//
//  MainTableViewCell.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 11/20/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    /*
     * Outlet Variables
     */
    @IBOutlet weak var competitionNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
