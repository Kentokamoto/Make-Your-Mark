//
//  EventModel.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 11/8/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

import Foundation

enum EventType {
    case HIGH_JUMP
    case LONG_JUMP
    case TRIPLE_JUMP
    case HAMMER_THROW
    case DISCUS_THROW
    case WEIGHT_THROW
    case JAVELIN_THROW
    case SHOT_PUT
    case POLE_VAULT
}
enum Gender {
    case MALE
    case FEMALE
    case MIXED
}

enum Units{
    case METRIC
    case ENGLISH
}

enum FlightAssignmentType {
    case SEED
    case ALPHABETICAL
    case SERPENTINE
    case RANDOM
    case CUSTOM
}

enum FlightOrder {
    case BEST2WORST
    case WORST2BEST
    case CUSTOM
}


class EventModel{
    var season = String()
    var competitionName = String()
    var gender = Gender.MALE
    var units = Units.METRIC
    var flightAssignmentType = FlightAssignmentType.SEED
    var flightOrder = FlightOrder.BEST2WORST
    var numOfFlights = Int()
    var finals = false
    var numInFinals = 9
    var provisionalMarksInMeters = Float()
    var automaticMarksInMeters = Float()
    var athletes = [AthleteModel]()
    var flights = [FlightModel]()
}
