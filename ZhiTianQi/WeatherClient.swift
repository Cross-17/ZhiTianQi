//
//  WeatherClient.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/8.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import Foundation
class WeatherClient : NSObject {
    
    // shared session
    var session = URLSession.shared
    let base = "api.openweathermap.org/data/2.5/weather"
    let apiKey = "113cae959b360a77cae56537dc57c4ae"
    
    func queryWithCityName(_ name:String, completionHandler:@escaping (_ result: AnyObject?, _ error: NSError?) -> Void){
        let query = "q=\(name)"
        let url = "http://\(base)?\(query)&units=metric&APPID=\(apiKey)"
        requestWithURL(url,completionHandler)
    }
    
    private func requestWithURL(_ url:String,_ completionHandler:@escaping (_ result: AnyObject?, _ error: NSError?) -> Void){
        let request = URLRequest(url: NSURL(string:url) as! URL)
        let task = session.dataTask(with: request){ data, response, error in
            
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            self.convertDataWithCompletionHandler(data,completionHandler)
        }
        task.resume()
    }
    
    private func convertDataWithCompletionHandler(_ data: Data,_ completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    
    class func sharedInstance() -> WeatherClient {
        struct Singleton {
            static var sharedInstance = WeatherClient()
        }
        return Singleton.sharedInstance
    }
    
    
}
