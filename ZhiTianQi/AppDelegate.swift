//
//  AppDelegate.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/8.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let stack = CoreDataStack(modelName: "Model")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        try! stack?.dropAllData()
//        stack?.context.reset()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        if try! stack?.context.count(for: fetchRequest) == 0{
        for item in city.data{
            let _ = City(item,(stack?.context)!)
        }
        }
        return true
    }
}

