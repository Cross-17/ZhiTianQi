//
//  City+CoreDataClass.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/8.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject {
    convenience init(_ name: String,_ context: NSManagedObjectContext ){
        let entity = NSEntityDescription.entity(forEntityName: "City", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
    }
}
