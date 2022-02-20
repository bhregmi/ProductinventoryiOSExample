//
//  CustomerVM.swift
//  ProductInventoryApp
//
//  Created by Test User on 4/29/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI
import Combine

class CustomerVM: ObservableObject {
    @Published var customerList = [Customer]()
    @Published var panData = PanModel(panNo: "", businessName: "", cutomerAddress: "", customerPhone: "")
  
    init(){
        getCustomer()
    }
    
    // Get Customer Information
    func getCustomer() {
        guard let url = URL(string: "http://127.0.0.1:8080/customer") else {
                    print("Error: cannot create URL")
           
                    return
                }
        
        
                var request = URLRequest(url: url)
                let headers = [
                    "content-type": "application/json",
                    "cache-control": "no-cache"
                ]
                
                request.httpMethod = "GET"
                    request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling GET")
                        print(error!)
                        return
                    }
                    guard data != nil else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                   
                    DispatchQueue.main.async {
                        self.customerList = try! JSONDecoder().decode([Customer].self, from: data!)
                    }

            
            
                }.resume()
            }
    
    
    // Get PAN data
    
    func panSearch(panNo:String) {
           
            guard let url = URL(string: "http://192.168.1.76:8080/customerpan") else {
                print("Error: cannot create URL")
                return
            }
    
            var request = URLRequest(url: url)
            let headers = [
                "content-type": "application/json",
                "cache-control": "no-cache"
            ]
            
            
            do {
//                request.httpMethod = "POST"
                request.httpMethod = "GET"
//                request.allHTTPHeaderFields = headers
//                request.httpBody = try JSONEncoder().encode(panNo)
            } catch {
                print("Error: cannot create JSON from customerInfo")
                return
            }
    

            // If you are using Basic Authentication uncomment the follow line and add your base64 string
    //        request.setValue("Basic MY_BASIC_AUTH_STRING", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling POST")
                    print(error!)
                    return
                }
                guard data != nil else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
               
                DispatchQueue.main.async {
                    //panInfoJsonData2
//                    let serverPanData = try! JSONDecoder().decode([PanModel].self, from: data!)
                    let serverPanData = try! JSONDecoder().decode(PanModel.self, from: panInfoJsonData2)
                    self.panData = serverPanData
                    print(self.panData)
                    
                    
                }
            }.resume()
        }
    
    
    // Post Customer Information
    func postCustomer(customerInfo : Customer ) {
               
                guard let url = URL(string: "http://192.168.1.76:8080/customer") else {
                    print("Error: cannot create URL")
                    return
                }
        
                var request = URLRequest(url: url)
                let headers = [
                    "content-type": "application/json",
                    "cache-control": "no-cache"
                ]
                
                
                do {
                    request.httpMethod = "POST"
        //          request.httpMethod = "GET"
                    request.allHTTPHeaderFields = headers
                    request.httpBody = try JSONEncoder().encode(customerInfo)
                } catch {
                    print("Error: cannot create JSON from customerInfo")
                    return
                }
        

                // If you are using Basic Authentication uncomment the follow line and add your base64 string
        //        request.setValue("Basic MY_BASIC_AUTH_STRING", forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling POST")
                        print(error!)
                        return
                    }
                    guard data != nil else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                   
                    DispatchQueue.main.async {
                        self.customerList = [try! JSONDecoder().decode(Customer.self, from: data!)]
                    }
                }.resume()
            }
    
    
    // Delete Customer Information
    func deleteCustomer(customerID: Int) {
        
        //only one iteam deleted at a time
        guard let url = URL(string: "http://192.168.1.76:8080/customer/\(customerID)") else {
            print("Error: cannot create URL")
            
            return
        }
        
        
        
        
        var request = URLRequest(url: url)
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }
            guard data != nil else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
//            DispatchQueue.main.async {
//                self.customerList = try! JSONDecoder().decode([Customer].self, from: data!)
//            }
        }.resume()
    }
}

