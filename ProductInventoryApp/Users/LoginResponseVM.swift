//
//  LoginResponseVM.swift
//  RMISBankPortal
//
//  Created by Test User on 12/21/19.
//  Copyright © 2019 Test User. All rights reserved.
//

import SwiftUI
import Combine

var token  = [String: String]()
//var statusCode: Int = 0

class IsLoggedIn: ObservableObject {
    @Published var isLoggedIn = false
}
var isLoggedIn = false
class LoginResponseVM: ObservableObject {
//    @EnvironmentObject var isLoggedIn: IsLoggedIn
    @Published var userLoginResponses = [UserResponse]()
    @Published var loginMessage = "ok"
    @Published var loginStatus = 0
    @Published var showingAreaView = false
    @Published var nextViewTrigger = false
    
    init(){}
    
    func loginNow(username:String, password:String) {
        //var login_result = false
//        let loginCredential = LoginUser(username:"\(username)",password:"\(password)")
//        let loginCredential = LoginUser(username:"john",password:"nepal123")
        
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        guard let url = URL(string: "http://127.0.0.1:8080/users/login") else {
                    print("Error: cannot create URL")
                    return
                }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
//        URLSession.shared.dataTask(with: request) { data, response, error in
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                print("error calling the username")
                return
            }
            guard data != nil else {
                print("Error: did not receive data")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            DispatchQueue.main.async {
                                self.loginStatus = httpResponse.statusCode
//                self.loginStatus = 200
                self.showingAreaView = true
                print("loginresponseVM statuscode \(self.loginStatus)")
                print("loginresponseVM showingAreaView \(self.showingAreaView)")
                
                
                if self.loginStatus == 200 {
                    isLoggedIn = true
                    self.nextViewTrigger = true
                    self.userLoginResponses = try! [JSONDecoder().decode(UserResponse.self, from: data!)]
//                    print("result from VM 22 \(self.userLoginResponses)")
                    print("login status: \(isLoggedIn)")
                } else if self.loginStatus == 401 {
                    self.loginMessage = try! JSONDecoder().decode(Message.self, from: data!).message
                    
                } else {
                    return
                }
            }
            
            //print response header in console
            let responseHeader = httpResponse.description
            print("responsehHeader = \(String(describing: responseHeader))")
            //print response data in console
            let responseString = String(data: data!, encoding: .utf8)!
            print("responseString = \(String(describing: responseString))")
            let responseString2 = String(describing: responseString)
//            token["token"] = responseString["token"]
            //print JWT token
//            token["token"] = httpResponse.allHeaderFields["token"] as? String
            print("Resultant token is : \(token)")
        })
        task.resume()
        print("login status2: \(isLoggedIn)")
    }
}


