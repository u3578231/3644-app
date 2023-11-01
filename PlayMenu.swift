
//  PlayMenu.swift
//  grammar
//
//  Created by Ryan Hui on 8/8/2023.
//

import SwiftUI

struct PlayMenu: View {
    let shuffle_question_set: Int
    let username: String
    @State private var navigateToRegisterView = false
    @State private var navigateToPlayMenu = false
    @State private var navigateToOverview = false
    @State private var showMenu = false
    @State private var navigateToDictionary = false
    @State private var showBackButton = true
    @State private var showProfilePicture = true
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack{
                    Text("Play Menu")
                        .font(.title)
                }
                List {
                    Section(header: Text("Game Mode")) {
                        NavigationLink(destination: generateRandomNoView(shuffle_question_set: 0, username: username)) {
                            HStack {
                                Image("time limit easy")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150) // Adjust the size as needed
                                
                                VStack(alignment: .leading) {
                                    Text("Mode: Time Limit Easy")
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("Difficulty: ")
                                            .foregroundColor(.red)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .padding()
                            }
                        }
                        NavigationLink(destination: generateRandomNoView_no_time_limit(shuffle_question_set: 0, username: username)) {
                            HStack {
                                Image("no time limit")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150) // Adjust the size as needed
                                
                                VStack(alignment: .leading) {
                                    Text("Mode: No Time Limit")
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("Difficulty: ")
                                            .foregroundColor(.red)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .padding()
                            }
                        }
                        NavigationLink(destination: generateRandomNoView_time_limit_heart_attack(username: username)) {
                            HStack {
                                Image("time limit hard")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150) // Adjust the size as needed
                                
                                VStack(alignment: .leading) {
                                    Text("Mode: Time Limit Hard")
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("Difficulty: ")
                                            .foregroundColor(.red)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .padding()
                            }
                        }
                        NavigationLink(destination: AR_View()) {
                            HStack (spacing: 50){
                                Image("AR")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150) // Adjust the size as needed
                                
                                VStack(alignment: .leading) {
                                    Text("Mode: AR")
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("Difficulty: ")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    
                    Section(header: Text("Learning")) {
                        NavigationLink(destination: DictionaryView(navigateToPlayMenu: $navigateToPlayMenu, username: username)) {
                            Text("Dictionary")
                        }
                        NavigationLink(destination: ChartView(username: username)) {
                            Text("Chart")
                        }
                        NavigationLink(destination: OverviewView(showMenu: $showMenu, navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToOverview) {
                            Text("Overview")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .padding(.top, 200) // Adjust the top padding as needed
                
                Spacer() // Add a spacer to push the lists to the top
                    .navigationTitle("Play Menu")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: backButton,
                    trailing: showProfilePicture ? profileButton : nil
                )
                .navigationBarHidden(navigateToPlayMenu || navigateToOverview)
            }
            
            NavigationLink(destination: RegisterView(), isActive: $navigateToRegisterView) {
                EmptyView()
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            navigateToRegisterView = true
        }) {
            Image(systemName: "chevron.left")
                .font(.title)
                .foregroundColor(.blue)
        }
        .padding()
        .opacity(showBackButton ? 1.0 : 0.0)
        .disabled(!showBackButton)
    }
    
    private var profileButton: some View {
        NavigationLink(destination: ProfileView(username: username)) {
            Image(systemName: "person.circle")
                .font(.system(size: 24))
        }
    }
}
struct PlayMenu_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
