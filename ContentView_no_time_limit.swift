
//  ContentView_no_time_limit.swift
//  grammar
//
//  Created by Ryan Hui on 8/8/2023.
//

import SwiftUI


struct ContentView_no_time_limit: View {
    var generatedShuffleQuestionSet: Int
    @State private var navigateToQuestion2 = false
    @State private var navigateToOverview = false
    @State private var navigateToPlayMenu = false
    @State private var showMenu = false
    @State private var selectedTab = 0
    @State var isShowingNextView = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToDictionary = false
    @State private var selectedq1Answer = ""
    @Binding private var currentMark: Double
    @State private var showTips = false
    @State private var q1_mark : Double = 0
    @Binding private var tipPressed : Bool
    @Binding private var tipPressed_q2 : Bool
    @Binding private var tipPressed_q3 : Bool
    @Binding private var wrongQArray: [Int]
    let username: String
    func transitionToNextView() {
        self.isShowingNextView = true
    }
    func tipsView(for questionIndex: Int) -> some View{
        let tip = tips[questionIndex]
        print(tip)
        return VStack {
            Text(tip)
                .font(.headline)
                .padding()
            Spacer()
            Button("Close") {
                tipPressed = true
                showTips.toggle()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding()
        .transition(.scale)
        .background(Color.black.opacity(0.5))
        .ignoresSafeArea()
        }
    init(generatedShuffleQuestionSet: Int,currentMark: Binding<Double>, username: String, wrongQArray: Binding<[Int]>, tipPressed: Binding<Bool>, tipPressed_q2: Binding<Bool>, tipPressed_q3: Binding<Bool>) {
        self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
        self._currentMark = currentMark
        self.username = username
        self._wrongQArray = wrongQArray
        self._tipPressed = tipPressed
        self._tipPressed_q2 = tipPressed_q2
        self._tipPressed_q3 = tipPressed_q3
    }
    var body: some View {
        ZStack {
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Question 1")
                    .font(.title)
                    .padding(.top,50)
                let questionindex = findquestionIndex()
                QuestionView(number: questionindex, question: questions[questionindex], ansA: optionA[questionindex], ansB: optionB[questionindex], ansC: optionC[questionindex], ansD: optionD[questionindex]) { answer in
                    selectedq1Answer = answer
                    print("Answer = ", answer)
                    if answer == correctans[questionindex] {
                        print("showtips = ", showTips)
                        if tipPressed {
                            q1_mark = 0.5
                        } else {
                            q1_mark = 1
                        }
                        if let index = wrongQArray.firstIndex(of: questionindex) {
                            wrongQArray.remove(at: index)
                        }
                        print("q1_mark = ", q1_mark)
                        print("wrong_q_array =", wrongQArray)
                    } else {
                        q1_mark = 0
                        if !wrongQArray.contains(questionindex) {
                            wrongQArray.append(questionindex)
                        }
                        print("q1_mark = ", q1_mark)
                        print("wrong_q_array =", wrongQArray)
                    }
                }
                .padding(.top, 150)
                .offset(y: -30)
                
                HStack {
                    Button("Next question") {
                        self.transitionToNextView()
                    }
                    NavigationLink(destination: Question2View_no_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark, tipPressed: $tipPressed, tipPressed_q2: $tipPressed_q2, tipPressed_q3: $tipPressed_q3), isActive: $isShowingNextView) {
                        EmptyView()
                    }
                    .padding()
                    Button(action: {
                        showTips.toggle()
                        print(showTips)
                        if showTips {
                            showTips = true
                            }
                    }) {
                        Image(systemName: "lightbulb")
                            .imageScale(.large)
                    }
                }
            }
            .navigationBarTitle("Question 1")
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to PlayMenu?"
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                    
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to Overview?"
                    }) {
                        Label("Overview", systemImage: "info.circle")
                    }
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to Dictionary?"
                    }) {
                        Label("Dictionary", systemImage: "book.circle")
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            )
            .background(
                NavigationLink(destination: OverviewView(showMenu: $showMenu, navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToOverview) {
                    EmptyView()
                }
                .hidden()
            )
            .background(
                NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                    EmptyView()
                }
                .hidden()
            )
            .background(
                NavigationLink(destination: DictionaryView(navigateToPlayMenu: $navigateToPlayMenu,username: username), isActive: $navigateToDictionary) {
                        EmptyView()
                    }
                    .hidden()
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("You will lose your progress if you exit the test"),
                message: Text(alertMessage),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .default(Text("OK"), action: {
                    if alertMessage == "Are you sure you want to go to PlayMenu?" {
                        navigateToPlayMenu = true
                    } else if alertMessage == "Are you sure you want to go to Overview?" {
                        navigateToOverview = true
                    }
                    else if alertMessage == "Are you sure you want to go to Dictionary?"{
                        navigateToDictionary = true
                    }
                })
            )
        }
        .overlay(
            Group {
                if showTips {
                    tipsView(for: findquestionIndex())
                        .frame(maxWidth: 250, maxHeight: 250)
                        .padding(.bottom, -350)
                }
            }
        )
    }
    
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][0]
        print("shuffle_question_set for question 1: \(generatedShuffleQuestionSet)")
        print("question_no for question 1: \(question_no)")
        return question_no
    }
}

struct Question2View_no_time_limit: View {
    @State private var isShowingSideMenu = false
    @State private var selectedTab = 0
    @State private var navigateToQuestion3 = false
    @State private var navigateToOverview = false
    @State private var navigateToPlayMenu = false
    @State private var showMenu = false
    @State var isShowingNextView = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToDictionary = false
    @State private var selectedq2Answer = ""
    @State private var q2_mark : Double = 0
    var generatedShuffleQuestionSet: Int
    @Binding private var currentMark : Double
    @Binding private var wrongQArray: [Int]
    @State private var showTips = false
    @Binding private var tipPressed : Bool
    @Binding private var tipPressed_q2 : Bool
    @Binding private var tipPressed_q3 : Bool
    var q1_mark : Double
    let username: String
    init(generatedShuffleQuestionSet: Int,currentMark: Binding<Double>, username: String, wrongQArray: Binding<[Int]>, q1_mark: Double, tipPressed: Binding<Bool>, tipPressed_q2: Binding<Bool>, tipPressed_q3: Binding<Bool>) {
        self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
        self._currentMark = currentMark
        self.username = username
        self._wrongQArray = wrongQArray
        self.q1_mark = q1_mark
        self._tipPressed = tipPressed
        self._tipPressed_q2 = tipPressed_q2
        self._tipPressed_q3 = tipPressed_q3
    }
    func tipsView(for questionIndex: Int) -> some View{
            let tip = tips[questionIndex]
            print(tip)
            return VStack {
                Text(tip)
                    .font(.headline)
                    .padding()
                Spacer()
                Button("Close") {
                    tipPressed_q2 = true
                    showTips.toggle()
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            .transition(.scale)
            .background(Color.black.opacity(0.5))
            .ignoresSafeArea()
        }
    var body: some View {
        ZStack {
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Question 2")
                    .font(.title)
                    .padding(.top,50)
                let questionindex = findquestionIndex()
                QuestionView(number: questionindex, question: questions[questionindex], ansA: optionA[questionindex], ansB: optionB[questionindex], ansC: optionC[questionindex], ansD: optionD[questionindex]) { answer in
                    selectedq2Answer = answer
                    print("Answer = ", answer)
                    if answer == correctans[questionindex] {
                        print("showtips = ", showTips)
                        if tipPressed_q2 {
                            q2_mark = 0.5
                        } else {
                            q2_mark = 1
                        }
                        if let index = wrongQArray.firstIndex(of: questionindex) {
                            wrongQArray.remove(at: index)
                        }
                        print("q2_mark = ", q2_mark)
                        print("wrong_q_array =", wrongQArray)
                    } else {
                        q2_mark = 0
                        if !wrongQArray.contains(questionindex) {
                            wrongQArray.append(questionindex)
                        }
                        print("q1_mark = ", q2_mark)
                        print("wrong_q_array =", wrongQArray)
                    }
                }
                .padding(.top, 50)
                .offset(y: -30)
                
                HStack {
                    NavigationLink(destination: Question3View_no_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark, q2_mark: q2_mark, tipPressed: $tipPressed, tipPressed_q2: $tipPressed_q2,tipPressed_q3: $tipPressed_q3)) {
                        Text("Next question")
                    }
                    .padding()
                    Button(action: {
                        showTips.toggle()
                        print(showTips)
                        if showTips {
                            showTips = true
                            }
                    }) {
                        Image(systemName: "lightbulb")
                            .imageScale(.large)
                    }
                }
            }
            .navigationBarTitle("Question 2")
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to PlayMenu?"
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                    
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to Overview?"
                    }) {
                        Label("Overview", systemImage: "info.circle")
                    }
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to Dictionary?"
                    }) {
                        Label("Dictionary", systemImage: "book.circle")
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            )
            .background(
                NavigationLink(destination: OverviewView(showMenu: $showMenu, navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToOverview) {
                    EmptyView()
                }
                .hidden()
            )
            .background(
                NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                    EmptyView()
                }
                .hidden()
            )
            .background(
                NavigationLink(destination: DictionaryView(navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToDictionary) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("You will lose your progress if you exit the test"),
                message: Text(alertMessage),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .default(Text("OK"), action: {
                    if alertMessage == "Are you sure you want to go to PlayMenu?" {
                        navigateToPlayMenu = true
                    } else if alertMessage == "Are you sure you want to go to Overview?" {
                        navigateToOverview = true
                    }
                    else if alertMessage == "Are you sure you want to go to Dictionary?" {
                        navigateToDictionary = true
                    }
                })
            )
        }
        .overlay(
            Group {
                if showTips {
                    tipsView(for: findquestionIndex())
                        .frame(maxWidth: 250, maxHeight: 250)
                        .padding(.bottom, -350)
                }
            }
        )
    }
    
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][1]
        print("shuffle_question_set for question 2: \(generatedShuffleQuestionSet)")
        print("question_no for question 2: \(question_no)")
        return question_no
    }
}

struct Question3View_no_time_limit: View {
    var generatedShuffleQuestionSet: Int
    @State private var navigateToOverview = false
    @State private var navigateToPlayMenu = false
    @State private var isShowingSideMenu = false
    @State private var selectedTab = 0
    @State private var showMenu = false
    @State private var showResultView = false
    @State private var showAlert = false
    @State private var navigateToDictionary = false
    @State private var alertMessage = ""
    @Binding private var currentMark: Double
    @State private var selectedq3Answer = ""
    @State private var showTips = false
    @State private var dateArray: [Date] = []
    @Binding private var wrongQArray: [Int]
    @Binding private var tipPressed : Bool
    @Binding private var tipPressed_q2 : Bool
    @Binding private var tipPressed_q3 : Bool
    var q1_mark: Double
    var q2_mark: Double
    @State private var q3_mark : Double = 0
    let username: String
    func transitionToNextView() {
        self.showResultView = true
    }
    init(generatedShuffleQuestionSet: Int,currentMark: Binding<Double>, username: String, wrongQArray: Binding<[Int]>, q1_mark: Double, q2_mark: Double, tipPressed: Binding<Bool>, tipPressed_q2: Binding<Bool>, tipPressed_q3: Binding<Bool>) {
        self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
        self._currentMark = currentMark
        self.username = username
        self._wrongQArray = wrongQArray
        self.q1_mark = q1_mark
        self.q2_mark = q2_mark
        self._tipPressed = tipPressed
        self._tipPressed_q2 = tipPressed_q2
        self._tipPressed_q3 = tipPressed_q3
    }
    func tipsView(for questionIndex: Int) -> some View{
            let tip = tips[questionIndex]
            print(tip)
            return VStack {
                Text(tip)
                    .font(.headline)
                    .padding()
                Spacer()
                Button("Close") {
                    tipPressed_q3 = true
                    showTips.toggle()
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            .transition(.scale)// Set a fixed width for the tips view
            .background(Color.black.opacity(0.5)) // Semi-transparent background
            .ignoresSafeArea()
        }
    func generateCurrentDateTime(q1_mark: Double, q2_mark: Double, q3_mark: Double, currentMark: Binding<Double>) {
        let currentDate = Date()
        currentMark.wrappedValue = q1_mark + q2_mark + q3_mark
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Hong_Kong") // Set the time zone to Hong Kong

        // Format the date to a string using the formatter
        let formattedDate = dateFormatter.string(from: currentDate)
        print("Current Date: \(formattedDate)")
        if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
                userArray[userIndex].dateArray.append(formattedDate)
                userArray[userIndex].playermodeArray.append("no time limit")
                userArray[userIndex].MarkArray.append(currentMark.wrappedValue)
                userArray[userIndex].wrong_q_2D_array.append(wrongQArray)
                print("Date array = ", userArray[userIndex].dateArray)
                print("Username = ", userArray[userIndex].username)
                print("player mode = ", userArray[userIndex].playermodeArray)
                print("current mark = ", userArray[userIndex].MarkArray)
                print("Wrong questions = ", userArray[userIndex].wrong_q_2D_array)
            }
    }
    var body: some View {
        ZStack {
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Question 3")
                    .font(.title)
                    .padding(.top,50)
                let questionindex = findquestionIndex()
                QuestionView(number: questionindex, question: questions[questionindex], ansA: optionA[questionindex], ansB: optionB[questionindex], ansC: optionC[questionindex], ansD: optionD[questionindex]) { answer in
                    selectedq3Answer = answer
                    print("Answer = ", answer)
                    if answer == correctans[questionindex] {
                        print("showtips = ", showTips)
                        if tipPressed_q3 {
                            q3_mark = 0.5
                        } else {
                            q3_mark = 1
                        }
                        if let index = wrongQArray.firstIndex(of: questionindex) {
                            wrongQArray.remove(at: index)
                        }
                        print("q3_mark = ", q3_mark)
                        print("wrong_q_array =", wrongQArray)
                    } else {
                        q3_mark = 0
                        if !wrongQArray.contains(questionindex) {
                            wrongQArray.append(questionindex)
                        }
                        print("q1_mark = ", q3_mark)
                        print("wrong_q_array =", wrongQArray)
                    }
                }
                .padding(.top, 50)
                .navigationTitle("Question 3")
                .offset(y: -30)
                
                HStack {
                    Button(action: {
                        generateCurrentDateTime(q1_mark: q1_mark, q2_mark: q2_mark, q3_mark: q3_mark, currentMark: $currentMark) 
                       self.showResultView = true
                   }) {
                       Text("See Result")
                   }
                    .padding()
                    Button(action: {
                        showTips.toggle()
                        print(showTips)
                        if showTips {
                            showTips = true
                            }
                    }) {
                        Image(systemName: "lightbulb")
                            .imageScale(.large)
                    }
                }
            }
            .fullScreenCover(isPresented: $showResultView) {
                ResultView(currentMark: $currentMark, username: username)
            }
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to PlayMenu?"
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                    
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to Overview?"
                    }) {
                        Label("Overview", systemImage: "info.circle")
                    }
                    Button(action: {
                        showAlert = true
                        alertMessage = "Are you sure you want to go to Dictionary?"
                    }) {
                        Label("Dictionary", systemImage: "book.circle")
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            )
            .background(
                NavigationLink(destination: OverviewView(showMenu: $showMenu, navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToOverview) {
                    EmptyView()
                }
                .hidden()
            )
            .background(
                NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                    EmptyView()
                }
                .hidden()
            )
            .background(
                NavigationLink(destination: DictionaryView(navigateToPlayMenu: $navigateToPlayMenu,username: username), isActive: $navigateToDictionary) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("You will lose your progress if you exit the test"),
                message: Text(alertMessage),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .default(Text("OK"), action: {
                    if alertMessage == "Are you sure you want to go to PlayMenu?" {
                        navigateToPlayMenu = true
                    } else if alertMessage == "Are you sure you want to go to Overview?" {
                        navigateToOverview = true
                    }
                    else if alertMessage == "Are you sure you want to go to Dictionary?" {
                        navigateToDictionary = true
                    }
                })
            )
        }
        .overlay(
            Group {
                if showTips {
                    tipsView(for: findquestionIndex())
                        .frame(maxWidth: 250, maxHeight: 250)
                        .padding(.bottom, -350)
                }
            }
        )
    }
    
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][2]
        print("shuffle_question_set for question 2: \(generatedShuffleQuestionSet)")
        print("question_no for question 2: \(question_no)")
        return question_no
    }
}


struct ContentView_no_time_limit_Previews:
    PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}



struct generateRandomNoView_no_time_limit: View {
    let shuffle_question_set: Int
    let username: String
    @State private var currentMark : Double = 0
    @State private var wrongQArray: [Int] = []
    @State private var selectedq1Answer = ""
    @State private var selectedq2Answer = ""
    @State private var selectedq3Answer = ""
    @State private var tipPressed = false
    @State private var tipPressed_q2 = false
    @State private var tipPressed_q3 = false
    var body: some View {
        let generatedShuffleQuestionSet = generateRandomIndex() // Use a different name here
        ZStack{
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("This gameplay has 3 questions in total, each question carries 1 mark. If you get the tips, the maximum mark carried is 0.5 mark.")
                    .font(.system(size:20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .frame(width: 600, height: 150)
                NavigationLink(destination: ContentView_no_time_limit(
                    generatedShuffleQuestionSet: generatedShuffleQuestionSet,
                    currentMark: $currentMark,
                    username: username,
                    wrongQArray: $wrongQArray, tipPressed: $tipPressed, tipPressed_q2: $tipPressed_q2, tipPressed_q3: $tipPressed_q3
                )) {
                    HStack {
                        Image(systemName: "play.fill")
                            .font(Font.system(size: 20))
                        Text("Start game")
                            .font(.title)
                    }
                    .padding()
                    .background(
                        ZStack {
                            Capsule()
                                .stroke(Color.black, lineWidth: 2) // Adjust the line width as desired
                        }
                    )
                }
            }
        }
    }
    
    func generateRandomIndex() -> Int {
        let shuffleQuestionSet = Int.random(in: 0..<34)
        let questionNo = randomarray[shuffleQuestionSet][0]
        print("shuffle_question_set: \(shuffleQuestionSet)")
        print("first question no: \(questionNo)")
        return shuffleQuestionSet // Return the generated value
    }
}
