//  login view.swift
//  grammar
//
//  Created by Ryan Hui on 22/8/2023.
//

import SwiftUI

struct User {
    var username: String
    var password: String
    var dateArray: [String]
    var playermodeArray: [String]
    var MarkArray: [Double]
    var wrong_q_2D_array: [[Int]]
}

var userArray: [User] = []
var playermodeArray: [User] = []
var MarkArray: [User] = []
var wrong_q_2D_array: [User] = []
func checkIfUsernameExists(username: String) -> Bool {
    for user in userArray {
        if user.username == username {
            return true
        }
    }
    return false
}
func loginUser(username: String, password: String) -> Bool {
    for user in userArray {
        print(user)
        if user.username == username && user.password == password {
            return true
        }
    }
    return false
}

struct RegisterView: View {
    @State private var registerUsername = ""
    @State private var registerPassword = ""
    @State private var navigateToLoginView = false
    @State private var navigateToWelcomeView = false
    @State private var navigateToRegisterView = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isRegistering = false
    func registerUser(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            showAlert(message: "Username and password fields cannot be empty.")
        } else {
            let isUsernameAlreadyRegistered = checkIfUsernameExists(username: username)
            if isUsernameAlreadyRegistered {
                showAlert(message: "Do not register with the same username.")
            } else {
                let newUser = User(username: username, password: password, dateArray: [], playermodeArray: [], MarkArray: [], wrong_q_2D_array: [])
                userArray.append(newUser)
                print("User registered successfully!")
                navigateToLoginView = true
            }
        }
        isRegistering = false
    }
    var body: some View {
        ZStack{
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Register a new user:")
                    .font(.headline)
                    .padding()
                
                TextField("Username", text: $registerUsername)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                SecureField("Password", text: $registerPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                NavigationLink(destination: LoginView(), isActive: $navigateToLoginView) {
                    Button("Register") {
                        if !isRegistering {
                            isRegistering = true
                            registerUser(username: registerUsername, password: registerPassword)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.red)
                            .frame(width: 200, height: 50)
                    )
                    .foregroundColor(.white)
                    .padding()
                    
                }
                Button("Already have an account? Click Login tab") {
                    navigateToLoginView = true
                }
                .padding()
                .navigationBarBackButtonHidden(true)
            }
            .background(
                NavigationLink(destination: WelcomeView(), isActive: $navigateToWelcomeView) {
                    EmptyView()
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            navigateToRegisterView = true
        }
    }
    func showAlert(message: String) {
            alertMessage = message
            showAlert = true
        }
}

struct LoginView: View {
    @State private var loginUsername = ""
    @State private var loginPassword = ""
    @State private var loginFailed = false
    @State private var navigateToPlayMenu = false

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Login to the app:")
                    .font(.headline)
                    .padding()

                TextField("Username", text: $loginUsername)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                SecureField("Password", text: $loginPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                Button(action: {
                    let success = loginUser(username: loginUsername, password: loginPassword)
                    if success {
                        loginFailed = false
                        navigateToPlayMenu = true
                    } else {
                        loginFailed = true
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.red)
                        )
                }
                .padding()

                if loginFailed {
                    Text("Login failed. Please check your credentials.")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .overlay(
            NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: loginUsername), isActive: $navigateToPlayMenu) {
                EmptyView()
            }
            .hidden()
        )
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
