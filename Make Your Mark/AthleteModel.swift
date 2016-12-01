//
//  AthleteModel.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 11/8/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import Foundation


class AthleteModel {
    var position : Int?
    var firstName = String()
    var lastName = String()
    var team  = String()
    var seedInMeters = Float()
    var marksInMeters = [Float]()
    var bestMarkInMeters : Float?
    var provisionalQualifying  = false
    var automaticQualifying = false
    
    init(pos : Int){
        position = pos
    }
}
