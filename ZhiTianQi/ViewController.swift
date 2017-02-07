//
//  ViewController.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/8.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextView!
    let client = WeatherClient.sharedInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showWeather(_ sender: UIButton) {
        client.queryWithCityName(sender.currentTitle!){(data,error) in
            performUIUpdatesOnMain{
            if let weather = data!["weather"] as! [Any]?,let main = data!["main"]{
                let weather = weather[0] as! [String:Any]
                let main = main as! [String:Any]
                let temp = main["temp"] as! Double
                let weatherMain = weather["main"]
                let result = "Weather:\(weatherMain!)   Temperature:\(temp)"
                self.textField.text = result
            }
        }
        }
    }


}

