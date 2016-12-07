//
//  FlightCollectionViewCell.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 12/6/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import UIKit

@IBDesignable
class FlightCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        setup()
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5.0
    }
    
}
