//
//  WeatherClient.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/8.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import Foundation
class WeatherClient {
    
    // shared session
    var session = URLSession.shared
    let key = "07efc3b0e455ddeb"
    let apiKey = "113cae959b360a77cae56537dc57c4ae"
    
    func queryWithCityName(_ name:String, completionHandler:@escaping (_ result: AnyObject?, _ error: String?) -> Void){
        let base = "api.wunderground.com/api/07efc3b0e455ddeb/forecast10day/conditions/astronomy/hourly"
        let query = "q/\(name).json"
        let url = "https://\(base)/\(query)"
        requestWithURL(url,completionHandler)
    }
    
    private func requestWithURL(_ url:String,_ completionHandler:@escaping (_ result: AnyObject?, _ error: String?) -> Void){
        let request = URLRequest(url: NSURL(string:url) as! URL)
        let task = session.dataTask(with: request){ data, response, error in
            
            guard (error == nil) else {
                completionHandler(nil,"There was an error with your request: \(error)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                 let statusCode = (response as? HTTPURLResponse)?.statusCode
                completionHandler(nil,"Your request returned a status code other than 2xx!\(statusCode)")
                return
            }
            guard let data = data else {
               completionHandler(nil,"No data was returned by the request!")
                return
            }
            completionHandler(data as AnyObject?,nil)
        }
        task.resume()
    }
    
     func parseData(_ data: Data,_ completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        completionHandlerForConvertData(parsedResult, nil)
    }
    

    static let shared: WeatherClient = {
        let instance = WeatherClient()
        return instance
    }()
    
    
}
