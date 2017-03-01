//
//  HelpFunctions.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/3/1.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import Foundation
import CoreData
// create a new city obj if can't find it on db
func handleCity(_ name:String,_ stack :CoreDataStack){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    let results = try! stack.context.fetch(fetchRequest)
    if results.count != 0{
        let city = results[0] as! City
        city.lastViewedAt = NSDate()
    }else{
        let city = City(name,stack.context)
        city.lastViewedAt = NSDate()
    }
       stack.save()
}

func transformToPinYin(_ s:String)->String{
    let mutableString = NSMutableString(string: s)
    CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
    CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
    let string = String(mutableString)
    return string.replacingOccurrences(of:" ", with: "")
}
