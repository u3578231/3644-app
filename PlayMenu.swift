
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
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    Section(header: Text("Game Mode")) {
                        NavigationLink(destination: generateRandomNoView(shuffle_question_set: 0,  username: username)) {
                            Text("Time Limit")
                        }
                        NavigationLink(destination: generateRandomNoView_no_time_limit(shuffle_question_set: 0,  username: username)) {
                            Text("No Time Limit")
                        }
                        NavigationLink(destination: generateRandomNoView_time_limit_heart_attack(username: username)) {
                            Text("Time Limit_heart_attack")
                        }
                    }
                    
                    Section(header: Text("Learning")) {
                        NavigationLink(destination: DictionaryView()){
                            Text("Dictionary")
                        }
                        NavigationLink(destination: ChartView(username: username)){
                            Text("Chart")
                        }
                        NavigationLink(destination: OverviewView(showMenu: $showMenu, navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToOverview){
                            Text("Overview")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Play Menu", displayMode: .large)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: backButton,
                    trailing: Button(action: {
                        // Handle profile icon tapped
                    }) {
                        Image(systemName: "person.circle")
                            .font(.system(size: 24))
                    }
                )
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
    }
}
struct PlayMenu_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
