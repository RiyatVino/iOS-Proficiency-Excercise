//
//  APIManager.swift
//  iOS Proficiency Excercise
//
//  Created by Vino on 4/7/20.
//  Copyright © 2020 Vino. All rights reserved.
//
/*
//MARK:- API Service call
func getData()
{
    var request = URLRequest(url: URL(string: jsonURLString)!,timeoutInterval: Double.infinity)
    
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        let str = String(decoding: data, as: UTF8.self)
        let jsonData = str.data(using: .utf8)!
        
        do {
            let jsonDecoder = JSONDecoder()
            self.mainData = try jsonDecoder.decode(MainModel.self, from: jsonData)
            DispatchQueue.main.async {
                self.navigationItem.title = self.mainData?.title
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
            }
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    task.resume()
}
*/
import UIKit

class APIManager: NSObject {

     let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

        static let sharedInstance = APIManager()
        
        func getData(onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                let str = String(decoding: data, as: UTF8.self)
                let jsonData = str.data(using: .utf8)!
                onSuccess(jsonData)
            }
        })
        task.resume()
    }

    
}
