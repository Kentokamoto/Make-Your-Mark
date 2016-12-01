//
//  FlightModel.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 11/8/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import Foundation


class FlightModel{
    var flightNumber = Int()
    var athletesInFlight = [AthleteModel]()
    
    init(flightNum: Int, athletes: [AthleteModel]){
        flightNumber = flightNum
        athletesInFlight = athletes
    }
}
