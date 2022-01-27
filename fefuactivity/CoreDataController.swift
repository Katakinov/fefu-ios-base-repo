//
//  coreDataControllet.swift
//  fefuactivity
//
//  Created by wsr1 on 23.01.2022.
//

import Foundation

class CoreDataController {
    /*func fetch() throws -> [ActivityDataModel] {
        let context = CoreDataContainer.instance.context
        let request = ActivityDataModel.fetchRequest()
        let rawActivities = try context.fetch(request)
        return rawActivities
    }*/
    
    func saveActivity(_ distance: Double,
                      _ duration: Double,
                      _ currentName: String,
                      _ startDate: Date,
                      _ startTime: String,
                      _ endTime: String) {
        let context = CoreDataContainer.instance.context
        
        let activity = ActivityDataModel(context: context)
        
        activity.typeName = currentName
        activity.date = startDate
        activity.distance = distance
        activity.startTime = startTime
        activity.endTime = endTime
        activity.duration = duration
        
        CoreDataContainer.instance.saveContext()
    }
}
