//
//  CustomerPanListView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/19/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI


/*

struct CustomerFormView: View {

//    @State var pan1: String = ""
//    //voucherForm.panData[0].panNo
//    @State var payerEdesc1: String = ""
//    @State var payerAddress1: String = ""
//    @State var payerPhone1: String = ""
//
    

//    @ObservedObject private var customerInfo = PanInfoVM()
    @State private var customerInfo = PanInfoVM()

    
    
   @ObservedObject private var customers = CustomerVM()
   //binding from the
   @Binding var addMode: Bool
   
   @State private var customerName: String = ""
   @State private var customerPAN: String = ""
//    @State private var businessName: String = ""
//   @State private var customerAddress: String = ""
//   @State private var customerPhone: String = ""
    @State private var isActive: Bool = true
   
   
   var body: some View {
       List {
           ScrollView(.horizontal, showsIndicators: false) {
               VStack {
                   LabelTextField1(label: "Customer Name", placeHolder: "Customer name", customerInfo: $customerName)
                HStack {
                    LabelTextField1(label: "PAN", placeHolder: "PAN", customerInfo: $customerPAN)
                    Button(action: { self.customerInfo.panSearch(panNo: self.customerPAN)
                    })
                    {
                        Image(systemName: "magnifyingglass").frame( alignment: .trailing)

                    }
                }
//
                LabelTextField1(label: "Business Name", placeHolder: "Business Name", customerInfo: $customerInfo.panData.businessName)
                LabelTextField1(label: "Address", placeHolder: "Business Address", customerInfo: $customerInfo.panData.cutomerAddress)
                LabelTextField1(label: "Phone", placeHolder: "Phone", customerInfo: $customerInfo.panData.customerPhone)

                   Button(action: {let customerInfo = Customer(
                        customerPAN: self.customerPAN,
                        businessName: "\(self.customerInfo.panData.businessName)",
                        customerAddress: "\(self.customerInfo.panData.cutomerAddress)",
                        customerName: self.customerName,
                        id: nil,
                        customerPhone: "\(self.customerInfo.panData.customerPhone)",
                        createdOn: ISO8601DateFormatter().string(from: Date()),
                        createdBy: "TestUser",
                        isActive: self.isActive)
                       
                       self.customers.postCustomer(customerInfo: customerInfo)
                       self.addMode.toggle()
                    print(self.$customerInfo.panData.businessName)
                   }
                   ) {
                       
                       LoginButtonContent()
                   }
               }
           }
       }
    }
}

struct CustomerPanListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerFormView(addMode: .constant(false))
    }
}





//struct PanModel: Codable {
//    var id: Int
//    var panNo: Int
//    var businessName: String
//    var cutomerAddress: String
//    var customerPhone: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case panNo = "PAN no"
//        case businessName = "Business Name"
//        case cutomerAddress = "Address"
//        case customerPhone = "Phone"
//    }
//}


struct LabelTextField1 : View {

    var label: String
    var placeHolder: String
    @Binding var customerInfo: String
 
    var body: some View {
        HStack {
            VStack {
                Text(label)
            }
                Spacer()
            VStack {
                TextField(placeHolder, text: $customerInfo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 180, alignment: .leading)
            }
            .padding(.leading)
        }
        .padding(.horizontal)
        .fixedSize(horizontal: false, vertical: true)
    .font(.system(size: 11))
    }
}

struct LabelNumField1 : View {

    var label: String
    var placeHolder: String
    @Binding var customerInfo: Int
 
    var body: some View {
        HStack {
            VStack {
                Text(label)
            }
                Spacer()
            VStack {
                TextField(placeHolder, value: $customerInfo, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 180, alignment: .leading)
            }
            .padding(.leading)
        }
        .padding(.horizontal)
        .fixedSize(horizontal: false, vertical: true)
    .font(.system(size: 11))
    }
}



class PanInfoVM: ObservableObject {
//        @Published var panData = PanModel(id: 11, panNo: 34343, businessName: "new business", cutomerAddress: "new york", customerPhone: 12342)
    @Published var panData = PanModel(panNo: "", businessName: "", cutomerAddress: "", customerPhone: "999")
    
//
//    @Binding  var customerPAN: String
//    @Binding  var businessName: String
//    @Binding  var customerAddress: String
//    @Binding  var customerPhone: String
//
    var pan1 = "000000000"
    //    var payerEdesc = "" {didSet {update()}}
    //    var payerAddress = "" {didSet {update()}}
    //    var payerPhone = "9999999999" {didSet {update()}}
    
    init(){}
    
    func panSearch(panNo:String) {
        //var login_result = false
        print("Typed pan: \(panNo)")
        // make dictionary from input data
        let panParameters = ["PAN": panNo]
        let loginEndpoint: String = "https://www.nhs.com/pan"
        
        guard let loginURL = URL(string: loginEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var loginUrlRequest = URLRequest(url: loginURL)
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        
        do {
            loginUrlRequest.httpMethod = "POST"
//            loginUrlRequest.httpMethod = "GET"
            loginUrlRequest.allHTTPHeaderFields = headers
            loginUrlRequest.httpBody = try JSONEncoder().encode(panParameters)
//            loginUrlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            
        } catch {
            print("Error: cannot create JSON from pan parameters")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: loginUrlRequest, completionHandler: {
            (data, response, error) in
        /*    guard error == nil else {
                print("error calling the pan")
                return
            }
            guard data != nil else {
                print("Error: did not receive data")
                return
            }
            */
            
            
            DispatchQueue.main.async {
                //if httpResponse.statusCode != 200 {
                   //self.loginResponses = [try! JSONDecoder().decode(LoginResponse.self, from: panInfo)]
                    //let panData = String(data: panInfoJsonData, encoding: .utf8)
                    self.panData = try! JSONDecoder().decode(PanModel.self, from: panInfoJsonData2)
                    print("result from VM 24 \(self.panData)")
//                } else {
//                    //var loginMessage = try! JSONDecoder().decode(Message.self, from: data!).message
//                    return
//                }
            }
            
 
        })
        task.resume()
    }
    
}

*/

let panInfoJsonData2 = """
{
    "customerPAN": "999777888",
    "customerAddress": "Dallas",
    "customerName": "Mario",
    "id": 2,
    "customerPhone": "9878965676",
    "createdOn": "2020-05-20T17:10:19Z",
    "createdBy": "TestUser",
    "businessName": "Nestle Bottlings",
    "isActive": false
}
""".data(using: .utf8)!


