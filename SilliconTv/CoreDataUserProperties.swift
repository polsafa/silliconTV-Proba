//
//  CoreDataUserProperties.swift
//  SilliconTv
//
//  Created by Pol Galbarro on 21/3/21.
//  Copyright © 2021 Pol Galbarro. All rights reserved.
//

import Foundation
import CoreData


extension Users {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }
    @NSManaged public var page: Int32
}
