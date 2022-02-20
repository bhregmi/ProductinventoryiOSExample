//
//  ProductInventoryVM.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/5/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI
import Combine


class ProductInventoryVM: ObservableObject {
    @Published var productInventoryList = [ProductInventory]()
  
    init(){
        getProductInventory()
    }
    
    // Get ProductNameRate Information
    func getProductInventory() {
        guard let url = URL(string: "http://127.0.0.1:8080/productinventory") else {
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
                        self.productInventoryList = try! JSONDecoder().decode([ProductInventory].self, from: data!)
                    }
                }.resume()
            }
    
    
    // Post ProductNameRate Information
    func postProductInventory(productInventoryInfo : ProductInventory ) {
               
                guard let url = URL(string: "http://192.168.1.76:8080/productinventory") else {
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
                    request.httpBody = try JSONEncoder().encode(productInventoryInfo)
                } catch {
                    print("Error: cannot create JSON from productInventoryInfo")
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
                        self.productInventoryList = [try! JSONDecoder().decode(ProductInventory.self, from: data!)]
                    }
                }.resume()
            }
    
    
    // Delete ProductNameRate Information
    func deleteProductNameRate(productInventoryID: Int) {
        
        //only one iteam deleted at a time
        guard let url = URL(string: "http://192.168.1.76:8080/productnamerate/\(productInventoryID)") else {
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
//                self.productNameRateList = try! JSONDecoder().decode([ProductNameRate].self, from: data!)
//            }
        }.resume()
    }
}
