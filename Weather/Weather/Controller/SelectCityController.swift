//
//  SelectCityController.swift
//  Weather
//
//  Created by 刘皇逊 on 23/9/19.
//  Copyright © 2019 刘皇逊. All rights reserved.
//

import UIKit 
//1.自定义了一个控件
protocol SelectCityDelegate{
    func didChangeCity(city:String)
    
}
class SelectCityController: UIViewController {
    var currentCity = ""
    //2.在本页面有一些事件发生，这些事件函数究竟存放在哪里？？？？？
    var delegate:SelectCityDelegate?
    @IBOutlet weak var currentCityLabel: UILabel!
   
    @IBOutlet weak var cityInput: UITextField!
    @IBAction func changeCityLabel(_ sender: Any) {
       
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCityLabel.text = currentCity
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
