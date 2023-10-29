
//  PlayMenu.swift
//  grammar
//
//  Created by Ryan Hui on 8/8/2023.
//

import SwiftUI

struct PlayMenu: View {
    let shuffle_question_set: Int
    let username: String
    //@Environment(\.presentationMode) var presentationMode
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
                List {
                    Section(header: Text("Game Mode")) {
                        NavigationLink(destination: generateRandomNoView(shuffle_question_set: 0, username: username)) {
                            Text("Time Limit")
                        }
                        NavigationLink(destination: generateRandomNoView_no_time_limit(shuffle_question_set: 0, username: username)) {
                            Text("No Time Limit")
                        }
                        NavigationLink(destination: generateRandomNoView_time_limit_heart_attack(username: username)) {
                            Text("Time Limit_heart_attack")
                        }
                        NavigationLink(destination: AR_View()) {
                            Text("AR")
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
                .navigationBarTitle("Play Menu", displayMode: .large)
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
            Label("Back", systemImage: "chevron.left")
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
