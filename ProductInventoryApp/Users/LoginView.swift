//
//  LoginView.swift
//  RMISBankPortal
//
//  Created by Test User on 12/21/19.
//  Copyright © 2019 Test User. All rights reserved.
//

import Combine
import SwiftUI
//let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)


struct LoginView: View {
    
    
    @State var username: String = ""
    @State var password: String = ""
    
    @ObservedObject var status = LoginResponseVM()
    
    //    @EnvironmentObject var isLoggedIn: IsLoggedIn
    
    var wordCountInUsernamePassword: Bool {
        return !username.isEmpty && !password.isEmpty
    }
    
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    
    var body: some View {
        
        ZStack {
            VStack {
                WelcomeText()
                UserImage()
                UsernameTextField(username: $username)
                PasswordSecureField(password: $password)
                
                Button(action: {
                    self.status.loginNow(username: self.username, password: self.password)
                    if self.status.loginStatus == 200 {
                        self.authenticationDidSucceed = true
                        self.authenticationDidFail = false
                    } else if self.status.loginStatus != 200 {
                        self.authenticationDidFail = true
                        self.authenticationDidSucceed = false
                    }
                }) {
                    LoginButtonContentLoginView(username: $username,password: $password)
                }.disabled(!wordCountInUsernamePassword)
                
                Button(action: {
                    //print("Forgot pressed")
                }) {
                    ForgotPasswordContent()
                }
                
                Spacer()
                FooterView()
            }
            .padding()
            .padding(.top, 60)
            
            
            
            
            //response of success or failure
            
            if self.status.showingAreaView {
                if self.status.loginStatus == 200 {
                    AuthenticationDidSucceed()
                    if self.status.nextViewTrigger {
                        //                        LoginResponseView(loginResponse: status.loginResponses)
                        //                        ProductInventoryCombineView()
                        LandingPageView()
                            .padding(.top,60)
                    }
                } else {
                    AuthenticationDidFail(loginMessage: status.loginMessage)
                }
            }
            
            
        }
            
            // this passes the status object down to descendant views
            .environmentObject(status)
    }
}

// extension for printing in view, usage is Print("Here I am", self.status.showingAreaView)
extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}



struct AuthenticationDidSucceed : View {
    var body: some View {
        return Text("Login succeeded!")
            .font(.headline)
            .frame(width: 250, height: 80)
            .background(Color.green)
            .cornerRadius(20.0)
            .foregroundColor(.white)
            .offset(y: -130)
        //        .animation(.basic(duration: 0.5, curve: .easeIn))
    }
}

struct AuthenticationDidFail : View {
    let loginMessage: String
    
    var body: some View {
        return Text(loginMessage)
            .font(.headline)
            .frame(width: 250, height: 80)
            .background(Color.red)
            .cornerRadius(20.0)
            .foregroundColor(.white)
            .offset(y: -130)
    }
}

//struct AuthenticationDidFail : View {
//    var body: some View {
//        return Text("Information not correct. Try again!")
//            .offset(y: -10)
//            .foregroundColor(.red)
//    }
//}

struct WelcomeText : View {
    var body: some View {
        return Text("Inventory And Billing System")
            .font(.title)
            .fontWeight(.bold)
            .frame(height: 77)
            .multilineTextAlignment(.center)
            .padding(.bottom, 5)
    }
}

struct UserImage : View {
    var body: some View {
        return Image("bitcoin")
            .resizable()
            .aspectRatio(UIImage(named: "bitcoin")!.size, contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 15)
    }
}


struct UsernameTextField : View {
    
    @Binding var username: String
    
    var body: some View {
        return TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 10)
    }
}


struct PasswordSecureField : View {
    
    @Binding var password: String
    
    var body: some View {
        return SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 10)
    }
}

struct ForgotPasswordContent : View {
    
    var body: some View {
        return Text("Forgot password?")//.font(.custom("WorkSans-Regular", size: 14))
            .fontWeight(.light)
            .foregroundColor(.secondary)
            .padding(.top,10)
    }
}

struct LoginButtonContentLoginView : View {
    
    @Binding var username: String
    @Binding var password: String
    //@Binding var wordCountInUsernamePassword: Bool
    
    var body: some View {
        return Text("Sign In")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 50)
            .background((username.count > 0 && password.count > 0) ? Color.blue : Color.gray)
            .cornerRadius(15.0)
    }
}

struct FooterView : View {
    var body: some View {
        VStack {
            Text("Need an account?")
                .foregroundColor(.purple)
                .background(lightGreyColor)
                .padding(.bottom,30)
            Button(action: {
                print("signup pressed")
            }) {
                Text("SIGN UP")
                    .foregroundColor(.blue)
                    .background(Rectangle().frame(width:215,height: 60).cornerRadius(10).accentColor(Color(red: 255/255, green: 255/255, blue: 255/255)))
            }
        }.padding(.bottom, 50)
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
