//
//  Memory.swift
//  Remember.me
//
//  Created by Dakota-Cheyenne Brown on 3/10/20.
//  Copyright © 2020 Dakota-Cheyenne Brown. All rights reserved.
//

import Foundation
import CoreData

public class Memory: NSManagedObject, Identifiable {
    @NSManaged public var createdAt: String
    @NSManaged public var title: String
    @NSManaged public var isDone: Bool
}



extension Memory {
    static func getAllMemories() -> NSFetchRequest<Memory> {
        let request:NSFetchRequest<Memory> = Memory.fetchRequest() as! NSFetchRequest<Memory>
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
