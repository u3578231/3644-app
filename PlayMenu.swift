
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
    @State private var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var show = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    GeometryReader { g in
                        Image("learning")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: g.size.width * 0.8)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                            .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.6 + g.frame(in: .global).minY : UIScreen.main.bounds.height / 2.6)
                            .onReceive(self.time) { _ in
                                let y = g.frame(in: .global).minY
                                if -y > (UIScreen.main.bounds.height / 2.6) - 50 {
                                    withAnimation {
                                        self.show = true
                                    }
                                } else {
                                    withAnimation {
                                        self.show = false
                                    }
                                }
                            }
                    }
                    .frame(height: UIScreen.main.bounds.height / 2.6)
                    Spacer()
                    VStack(spacing: 20){
                        ForEach(data){i in
                            PlayItemView(data: i, username:username, navigateToPlayMenu: $navigateToPlayMenu)
                        }
                    }
                    .padding(.top)
                Spacer()
                }
            }
            if self.show {
            }
        }
        .navigationBarItems(
            leading: backButton,
            trailing: showProfilePicture ? profileButton : nil
        )
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(destination: RegisterView(), isActive: $navigateToRegisterView) {
                EmptyView()
            }
        )
    }
    private var profileButton: some View {
        NavigationLink(destination: ProfileView(username: username)) {
            Image(systemName: "person.circle")
                .font(.system(size: 28))
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
}
struct PlayItemView : View {
    var data : PlayItem
    let username: String
    @Binding var navigateToPlayMenu: Bool
    var body: some View{
        HStack(alignment: .top, spacing: 40){
            Image(self.data.image)
                .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 175, height: 150)
            VStack(alignment: .leading, spacing: 10) {
                Text(self.data.title)
                    .fontWeight(.bold)
                Text(self.data.subTitile)
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack(spacing: 50) {
                    if self.data.title == "Time Limit Easy" {
                        NavigationLink(destination: generateRandomNoView(shuffle_question_set: 0, username: username)) {
                            Text("Proceed")
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.primary.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    }
                    if self.data.title == "Time Limit Hard/Heart Attack"{
                        NavigationLink(destination: generateRandomNoView_time_limit_heart_attack(username: username)) {
                            Text("Proceed")
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.primary.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    }
                    if self.data.title == "No Time Limit"{
                        NavigationLink(destination: generateRandomNoView_no_time_limit(shuffle_question_set: 0, username: username)) {
                            Text("Proceed")
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.primary.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    }
                    if self.data.title == "AR"{
                        NavigationLink(destination: AR_View()){
                            Text("Proceed")
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.primary.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    }
                    if self.data.title == "Dictionary"{
                        NavigationLink(destination: DictionaryView( username: username)){
                            Text("Proceed")
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.primary.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    }
                    if self.data.title == "Charts"{
                        NavigationLink(destination: ChartView(username: username)){
                            Text("Proceed")
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.primary.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    }
                    if self.data.title == "Overview"{
                        NavigationLink(destination: OverviewView(username: username)){
                            Text("Proceed")
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.primary.opacity(0.06))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
}
struct PlayMenu_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
struct PlayItem : Identifiable {
    var id : Int
    var image : String
    var title : String
    var subTitile : String
}
var data = [
    PlayItem(id: 0, image: "time limit easy", title: "Time Limit Easy", subTitile: "Difficulty: 2 star"),
    PlayItem(id: 1, image: "time limit hard", title: "Time Limit Hard/Heart Attack", subTitile: "Difficulty: 3 star"),
    PlayItem(id: 2, image: "no time limit", title: "No Time Limit", subTitile: "Difficulty: 1 star"),
    PlayItem(id: 3, image: "AR", title: "AR", subTitile: "Experience AI generated 3D models and look for defects"),
    PlayItem(id: 4, image: "Dictionary", title: "Dictionary", subTitile: "Check for previous gameplay records"),
    PlayItem(id: 5, image: "Charts", title: "Charts", subTitile: "Check for progress along with time"),
    PlayItem(id: 6, image: "Overview", title: "Overview", subTitile: "Check for gameplay details"),
]
