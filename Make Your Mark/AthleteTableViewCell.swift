//
//  AthleteTableViewCell.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 11/21/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit

class AthleteTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var seedTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
