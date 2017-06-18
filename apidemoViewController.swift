//
//  apidemoViewController.swift
//  swiftProjectDemo
//
//  Created by agilemac-74 on 01/06/17.
//  Copyright © 2017 Agile. All rights reserved.
//

import UIKit

import Alamofire


class apidemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //makeGetAPICall()
        
       // makePostCall()
        
        //AlamofireGet()
        
        AlamofirePostMethod()
    }
    func AlamofirePostMethod()
    {
        let requestString = "http://104.239.162.131/api/v3/mobile/api.php"
        
        let param = ["api" : "getcategories"]
        let headerParam = ["key" : "value"]
        
        //validate()
        
        Alamofire.request(requestString, method: .post, parameters: param, headers:headerParam).responseJSON { (response:DataResponse<Any>) in
            
            switch response.result
            {
            case.success(_):
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    
                    let mainDic = JSON as! NSDictionary
                    
                    let status = mainDic.object(forKey: "status")
                    print(status)
                    let responseDic = mainDic.object(forKey: "response") as? NSDictionary
                    print(responseDic)
                    
                    let getArray = responseDic?.object(forKey: "fields")
                    
                    
                    let fieldsArray = mainDic.value(forKeyPath: "response.fields") as? NSArray
                    
                    print(fieldsArray)
                    
                    
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func AlamofireGet()
    {
        Alamofire.request("http://104.239.162.131/api/v3/mobile/api.php?api=getcategories").responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            case .failure(let error):
                print("Error Discription = \(error)")
            }
        }
        
    }

    
    func makeGetAPICall()
    {
        let urlPath: String = "http://202.131.123.211/UdgamApi_v4/App_Services/UdgamService.asmx/GetAllTeacherData?StudentId=2011111"
        
        
        let url = URL(string: urlPath)
        
        var urlRequest = URLRequest(url: url!)
        
       // let postString = "StudentId=2011111" //"id=13&name=Jack"
        
        urlRequest.httpMethod = "GET"
       // urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        // set up the session
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        
        
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                
                guard let getResponseDic = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    else
                {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                
                print(getResponseDic as NSDictionary)
                
                let dic = getResponseDic as NSDictionary
                let msg = dic.object(forKey: "message")
                
                print(msg)
                let arrObj = dic.object(forKey: "teacherDetail") as! NSArray
                print(arrObj)
                
                let teacherDIc = arrObj.object(at: 0) as? NSDictionary
                
                let empName = teacherDIc?.object(forKey: "TeacherName")
                
                print(empName)
                
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                
                // print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            
            
            
        }
        
        task.resume()
        
        
    }
    
    func makePostCall()
    {
        let urlPath: String = "http://202.131.123.211/UdgamApi_v4/App_Services/UdgamService.asmx/GetAllTeacherData"
        let url = URL(string: urlPath)
        
        var urlRequest = URLRequest(url: url!)
        
        let postString = "StudentId=2011111" //"id=13&name=Jack"
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                
                guard let getResponseDic = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    else
                {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                
                print(getResponseDic as NSDictionary)
                
                let dic = getResponseDic as NSDictionary
                let msg = dic.object(forKey: "message")
                
                print(msg)
                let arrObj = dic.object(forKey: "teacherDetail") as! NSArray
                print(arrObj)
                
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                
                // print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            
            
            
        }
        
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
