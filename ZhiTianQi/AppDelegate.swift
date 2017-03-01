//
//  AppDelegate.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/8.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager  = CLLocationManager()
    let stack = CoreDataStack(modelName: "Model")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        locationManager.requestAlwaysAuthorization()
        DispatchQueue.init(label: "background").async {
        for item in CityData.rawdata{
            var data = CityForSearch()
            data.name = item
            data.matchString.append(item)
            data.matchString.append(transformToPinYin(item))
            CityData.formatedData.append(data)
        }
    }
        return true
    }
}

