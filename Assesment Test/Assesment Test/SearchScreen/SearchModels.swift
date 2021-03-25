//
//  SearchModels.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


struct UnitsParse {
    var apt: String!
    var blockId: String!
    var blockName: String!
    var floor: String!
    var id: String!
    var propertyId: String!
    var title: String!
    var unitType: String!
    var activities:[ActivitiesParse]!
    
    init(json: JSON) {
        self.apt = json["apt"].string
        self.blockId = json["block_id"].string
        self.blockName = json["block_name"].string
        self.floor = json["floor"].string
        self.id = json["id"].string
        self.propertyId = json["property_id"].string
        self.title = json["title"].string
        self.unitType = json["unit_type"].string
        self.activities = json["activities"].array?.compactMap({ (activitiesJson) -> ActivitiesParse? in
            return ActivitiesParse(json: activitiesJson)
        })
    }
    
    init(unit: Units, activities:[Activities]) {
        self.apt = unit.apt
        self.blockId = unit.blockId
        self.blockName = unit.blockName
        self.floor = unit.floor
        self.id = unit.id
        self.propertyId = unit.propertyId
        self.title = unit.title
        self.unitType = unit.unitType
        
        self.activities = activities.compactMap({ (activitie) -> ActivitiesParse? in
            return ActivitiesParse(activitie: activitie)
        })
    }
}

struct ActivitiesParse {
    var progress: Int!
    var activityName: String!
    var activityStatus: String!
    var currentUserName: String!
    var id: String!
    var stepName: String!
    var wf: String!
    
    init(json: JSON) {
        self.progress = json["progress"].int
        self.activityName = json["activity_name"].string
        self.activityStatus = json["activity_status"].string
        self.currentUserName = json["current_user_name"].string
        self.id = json["id"].string
        self.stepName = json["step_name"].string
        self.wf = json["wf"].string
    }
    init(activitie: Activities) {
        self.progress = Int(activitie.progress)
        self.activityName = activitie.activityName
        self.activityStatus = activitie.activityStatus
        self.currentUserName = activitie.currentUserName
        self.id = activitie.id
        self.stepName = activitie.stepName
    }
}