//
//  ViewController.swift
//  Weather
//
//  Created by 刘皇逊 on 21/9/19.
//  Copyright © 2019 刘皇逊. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
//delegete
//protocol
class ViewController: UIViewController{
    
    let locationManger = CLLocationManager()
    let weather = Weather()
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self //CLLlocationManager的代理人是self（Viewcontroller)
        // Do any additional setup after loading the view.
         locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManger.requestLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManger.requestWhenInUseAuthorization()//请求授权获取当前的位置
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters//设置位置精度，精度越高，耗电越大
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        print(lat,lon)
        
        let parameter = ["lat":"\(lat)","lon":"\(lon)","appid":"91533923abf89fce86cf94655e7557fd"];
        getWeather(parameters: parameter)
        
//                ?lat=\(lat)&lon=\(lon)&APPID=91533923abf89fce86cf94655e7557fd
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectCity"{
            let vc = segue.destination as! SelectCityController
            vc.currentCity = weather.city
            vc.delegate = self
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "获取位置失败"
    }
    
            
}

extension ViewController:CLLocationManagerDelegate,SelectCityDelegate{
    func didChangeCity(city:String) {
        print(city)
        let parameters = ["q":city,"appid":"91533923abf89fce86cf94655e7557fd"]
        getWeather(parameters: parameters)
    }
    
    
    
   
    
    func getWeather(parameters:[String:String]){
        AF.request("http://api.openweathermap.org/data/2.5/weather",parameters:parameters).responseJSON { response in
            if let json = response.value{
                //print("JSON:\(json)")
                let weather = JSON(json)
                //            debugPrint(weather)
                //                print(weather["name"].stringValue)
                //                print(weather["main","temp"].stringValue)
                self.createWeather(weatherJSON: weather)
                self.updateUI()
            }
        }
    }
    func createWeather(weatherJSON:JSON){
        weather.city = weatherJSON["name"].stringValue
        weather.temp = Int (round(weatherJSON["main","temp"].doubleValue-273.15))
        weather.condition = weatherJSON["weather",0,"id"].intValue
    }
    func updateUI(){
        cityLabel.text = weather.city
        tempLabel.text = "\(weather.temp)˚"
        imageView.image = UIImage(named: weather.icon)
    }
}
