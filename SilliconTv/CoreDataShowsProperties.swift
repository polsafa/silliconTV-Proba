//
//  CoreDataShowsProperties.swift
//  SilliconTv
//
//  Created by Pol Galbarro on 21/3/21.
//  Copyright © 2021 Pol Galbarro. All rights reserved.
//

import Foundation
import CoreData


extension Tvshows {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tvshows> {
        return NSFetchRequest<Tvshows>(entityName: "Shows")
    }
    
 //   @NSManaged public var series: [Serie]
}

