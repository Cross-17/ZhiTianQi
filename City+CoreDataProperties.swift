//
//  City+CoreDataProperties.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/13.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var name: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var lastViewedAt: NSDate?
    @NSManaged public var location: String?
    @NSManaged public var weather: NSOrderedSet?

}

// MARK: Generated accessors for weather
extension City {

    @objc(insertObject:inWeatherAtIndex:)
    @NSManaged public func insertIntoWeather(_ value: Wdata, at idx: Int)

    @objc(removeObjectFromWeatherAtIndex:)
    @NSManaged public func removeFromWeather(at idx: Int)

    @objc(insertWeather:atIndexes:)
    @NSManaged public func insertIntoWeather(_ values: [Wdata], at indexes: NSIndexSet)

    @objc(removeWeatherAtIndexes:)
    @NSManaged public func removeFromWeather(at indexes: NSIndexSet)

    @objc(replaceObjectInWeatherAtIndex:withObject:)
    @NSManaged public func replaceWeather(at idx: Int, with value: Wdata)

    @objc(replaceWeatherAtIndexes:withWeather:)
    @NSManaged public func replaceWeather(at indexes: NSIndexSet, with values: [Wdata])

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: Wdata)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: Wdata)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSOrderedSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSOrderedSet)

}
