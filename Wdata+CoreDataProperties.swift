//
//  Wdata+CoreDataProperties.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/13.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import Foundation
import CoreData


extension Wdata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wdata> {
        return NSFetchRequest<Wdata>(entityName: "Wdata");
    }

    @NSManaged public var data: NSData?
    @NSManaged public var city: City?

}
