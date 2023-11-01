//content view heart attack
//  ContentView_no_time_limit.swift
//  grammar
//
//  Created by Ryan Hui on 8/8/2023.
//

import SwiftUI
import Combine
class TimerManager_heart_attack: ObservableObject {
    @Published var timeRemaining = 15
    private var timer: Timer?
    private var cancellables: Set<AnyCancellable> = []

    init(timeRemaining: Int = 15) {
        self.timeRemaining = timeRemaining
    }

    func startTimer() {
        timer?.invalidate()
        if timeRemaining == 0 && timer == nil {
            timeRemaining = 15
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeRemaining -= 1
            if self.timeRemaining == 0 {
                self.timer?.invalidate()
                self.objectWillChange.send()
            }
        }
        timer?.fire()
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        timer?.invalidate()
    }
}

struct ContentView_time_limit_heart_attack: View {
    @State private var isShowingSideMenu = false
    @State private var selectedTab = 0
    @State private var selectedq1Answer: String?
    @State private var navigateToQuestion3 = false
    @State private var navigateToOverview = false
    @State private var navigateToPlayMenu = false
    @State private var showMenu = false
    @ObservedObject var timer: TimerManager_heart_attack
    @Binding var isShowingResultView: Bool
    @Binding var currentMark: Double
    @State private var navigateToDictionary = false
    @State var isShowingNextView = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var previousAnswer = ""
    @State private var questionAnsweredCorrectly: Bool = false
    @Binding private var wrongQArray: [Int]
    @State private var q1_mark : Double = 0
    let username: String
    var generatedShuffleQuestionSet: Int
    func transitionToNextView() {
        timer.startTimer()
        self.isShowingNextView = true
    }
    func generateCurrentDateTime(currentMark: Binding<Double>) {
        let currentDate = Date()
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Hong_Kong") // Set the time zone to Hong Kong

        // Format the date to a string using the formatter
        let formattedDate = dateFormatter.string(from: currentDate)
        print("Current Date: \(formattedDate)")
        if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
            if !userArray[userIndex].dateArray.contains(formattedDate) {
                userArray[userIndex].dateArray.append(formattedDate)
                userArray[userIndex].playermodeArray.append("time limit heart attack")
                userArray[userIndex].MarkArray.append(currentMark.wrappedValue)
                userArray[userIndex].wrong_q_2D_array.append(wrongQArray)
            }
                print("Date array = ", userArray[userIndex].dateArray)
                print("Username = ", userArray[userIndex].username)
                print("player mode = ", userArray[userIndex].playermodeArray)
                print("current mark = ", userArray[userIndex].MarkArray)
                print("Wrong questions = ", userArray[userIndex].wrong_q_2D_array)
            }
    }
    init(timer: TimerManager_heart_attack,isShowingResultView: Binding<Bool>, generatedShuffleQuestionSet: Int, currentMark: Binding<Double>, username: String,wrongQArray: Binding<[Int]>) {
            self.timer = timer
            self._isShowingResultView = isShowingResultView
            self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
            self._currentMark = currentMark
            self.username = username
            self._wrongQArray = wrongQArray
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
                        q1_mark = 1
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
                .padding(.top, 50)
                .offset(y: -30)
                HStack {
                    Button("Next question") {
                        self.transitionToNextView()
                    }
                    NavigationLink(destination: Question2View_time_limit_heart_attack(timer: timer, isShowingResultView: $isShowingResultView, generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark),
                                   isActive: $isShowingNextView) {
                      EmptyView()
                    }
                }
                Text("Time remaining: \(timer.timeRemaining)")
                    .edgesIgnoringSafeArea(.bottom)
                    .onReceive(timer.objectWillChange) { _ in
                            if timer.timeRemaining == 0 {
                                generateCurrentDateTime(currentMark: $currentMark)
                                isShowingResultView = true
                            }
                        }
                }
            .fullScreenCover(isPresented: $isShowingResultView) {
                ResultView(currentMark: $currentMark, username: username)
            }
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
                        alertMessage = "Are you sure you want to go to PlayMenu?"
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                    
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
                        alertMessage = "Are you sure you want to go to Overview?"
                    }) {
                        Label("Overview", systemImage: "info.circle")
                    }
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
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
                NavigationLink(destination: OverviewView(showMenu: $showMenu,navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToOverview) {
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
                primaryButton: .cancel(Text("Cancel"), action: {
                    timer.startTimer()
                }),
                secondaryButton: .default(Text("OK"), action: {
                    if alertMessage == "Are you sure you want to go to PlayMenu?" {
                        navigateToPlayMenu = true
                        timer.stopTimer()
                    } else if alertMessage == "Are you sure you want to go to Overview?" {
                        navigateToOverview = true
                        timer.stopTimer()
                    }
                    else if alertMessage == "Are you sure you want to go to Dictionary?" {
                       navigateToDictionary = true
                       timer.stopTimer()
                   }
                })
            )
        }
    }
    
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][0]
        return question_no
    }
}

struct Question2View_time_limit_heart_attack: View {
    @State private var isShowingSideMenu = false
    @State private var selectedTab = 0
    @State private var selectedq2Answer: String?
    @State private var navigateToQuestion3 = false
    @State private var navigateToOverview = false
    @State private var navigateToPlayMenu = false
    @State private var showMenu = false
    @ObservedObject var timer: TimerManager_heart_attack
    @Binding var isShowingResultView: Bool
    @State var isShowingNextView = false
    @State private var navigateToDictionary = false
    @State private var q2_mark : Double = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding private var currentMark: Double
    @State private var previousAnswer = ""
    @Binding private var wrongQArray: [Int]
    var generatedShuffleQuestionSet: Int
    let username: String
    var q1_mark : Double
    func transitionToNextView() {
        timer.startTimer()
        self.isShowingNextView = true
    }
    func generateCurrentDateTime(currentMark: Binding<Double>) {
        let currentDate = Date()
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Hong_Kong") // Set the time zone to Hong Kong

        // Format the date to a string using the formatter
        let formattedDate = dateFormatter.string(from: currentDate)
        print("Current Date: \(formattedDate)")
        if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
            if !userArray[userIndex].dateArray.contains(formattedDate) {
                userArray[userIndex].dateArray.append(formattedDate)
                userArray[userIndex].playermodeArray.append("time limit heart attack")
                userArray[userIndex].MarkArray.append(currentMark.wrappedValue)
                userArray[userIndex].wrong_q_2D_array.append(wrongQArray)
            }
                print("Date array = ", userArray[userIndex].dateArray)
                print("Username = ", userArray[userIndex].username)
                print("player mode = ", userArray[userIndex].playermodeArray)
                print("current mark = ", userArray[userIndex].MarkArray)
                print("Wrong questions = ", userArray[userIndex].wrong_q_2D_array)
            }
    }
    init(timer: TimerManager_heart_attack,isShowingResultView: Binding<Bool>, generatedShuffleQuestionSet: Int, currentMark: Binding<Double>, username: String,wrongQArray: Binding<[Int]>, q1_mark: Double) {
            self.timer = timer
            self._isShowingResultView = isShowingResultView
            self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
            self._currentMark = currentMark
            self.username = username
            self._wrongQArray = wrongQArray
            self.q1_mark = q1_mark
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
                        q2_mark = 1
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
                        print("q2_mark = ", q2_mark)
                        print("wrong_q_array =", wrongQArray)
                    }
                }
                .padding(.top, 50)
                .offset(y: -30)
                
                HStack {
                    Button("Next question") {
                        self.transitionToNextView()
                    }
                    NavigationLink(destination: Question3View_time_limit_heart_attack(timer: timer, isShowingResultView: $isShowingResultView, generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark, q2_mark: q2_mark),
                                   isActive: $isShowingNextView) {
                      EmptyView()
                    }
                }
                Text("Time remaining: \(timer.timeRemaining)")
                    .edgesIgnoringSafeArea(.bottom)
                    .onReceive(timer.objectWillChange) { _ in
                            if timer.timeRemaining == 0 {
                                generateCurrentDateTime(currentMark: $currentMark)
                                isShowingResultView = true
                            }
                        }
                }
            .fullScreenCover(isPresented: $isShowingResultView) {
                ResultView(currentMark: $currentMark, username: username)
            }
            .navigationBarTitle("Question 2")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
                        alertMessage = "Are you sure you want to go to PlayMenu?"
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                    
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
                        alertMessage = "Are you sure you want to go to Overview?"
                    }) {
                        Label("Overview", systemImage: "info.circle")
                    }
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
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
                NavigationLink(destination: OverviewView(showMenu: $showMenu,navigateToPlayMenu: $navigateToPlayMenu, username: username), isActive: $navigateToOverview) {
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
                NavigationLink(destination: DictionaryView( navigateToPlayMenu:$navigateToPlayMenu,username: username), isActive: $navigateToDictionary) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("You will lose your progress if you exit the test"),
                message: Text(alertMessage),
                primaryButton: .cancel(Text("Cancel"), action: {
                    timer.startTimer()
                }),
                secondaryButton: .default(Text("OK"), action: {
                    if alertMessage == "Are you sure you want to go to PlayMenu?" {
                        navigateToPlayMenu = true
                        timer.stopTimer()
                    } else if alertMessage == "Are you sure you want to go to Overview?" {
                        navigateToOverview = true
                        timer.stopTimer()
                    }
                    else if alertMessage == "Are you sure you want to go to Dictionary?" {
                        navigateToDictionary = true
                        timer.stopTimer()
                    }
                })
            )
        }
    }
    
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][1]
        print("shuffle_question_set for question 2: \(generatedShuffleQuestionSet)")
        print("question_no for question 2: \(question_no)")
        return question_no
    }
}

struct Question3View_time_limit_heart_attack: View {
    @State private var selectedq3Answer: String?
    @State private var navigateToOverview = false
    @State private var navigateToPlayMenu = false
    @State private var showMenu = false
    @State private var isShowingSideMenu = false
    @State private var selectedTab = 0
    @State private var answercorrect = false
    @ObservedObject var timer: TimerManager_heart_attack
    @Binding var isShowingResultView: Bool
    @State var isShowingNextView = false
    @State private var navigateToDictionary = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding private var currentMark : Double
    @State private var questionAnsweredCorrectly = false
    @State private var previousAnswer = ""
    var generatedShuffleQuestionSet: Int
    let username: String
    @Binding private var wrongQArray: [Int]
    var q1_mark: Double
    var q2_mark: Double
    @State private var q3_mark : Double = 0
    func transitionToNextView() {
        timer.startTimer()
        self.isShowingNextView = true
    }
    func generateCurrentDateTime(currentMark: Binding<Double>) {
        let currentDate = Date()
        currentMark.wrappedValue = q1_mark + q2_mark + q3_mark
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Hong_Kong") // Set the time zone to Hong Kong
        // Format the date to a string using the formatter
        let formattedDate = dateFormatter.string(from: currentDate)
        print("Current Date: \(formattedDate)")
        if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
            if !userArray[userIndex].dateArray.contains(formattedDate) {
                userArray[userIndex].dateArray.append(formattedDate)
                userArray[userIndex].playermodeArray.append("time limit heart attack")
                userArray[userIndex].MarkArray.append(currentMark.wrappedValue)
                userArray[userIndex].wrong_q_2D_array.append(wrongQArray)
            }
                print("Date array = ", userArray[userIndex].dateArray)
                print("Username = ", userArray[userIndex].username)
                print("player mode = ", userArray[userIndex].playermodeArray)
                print("current mark = ", userArray[userIndex].MarkArray)
                print("Wrong questions = ", userArray[userIndex].wrong_q_2D_array)
            }
    }
    init(timer: TimerManager_heart_attack,isShowingResultView: Binding<Bool>, generatedShuffleQuestionSet: Int, currentMark: Binding<Double>, username: String,wrongQArray: Binding<[Int]>, q1_mark: Double, q2_mark: Double) {
            self.timer = timer
            self._isShowingResultView = isShowingResultView
            self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
            self._currentMark = currentMark
            self.username = username
            self._wrongQArray = wrongQArray
            self.q1_mark = q1_mark
            self.q2_mark = q2_mark
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
                        q3_mark = 1
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
                        print("q3_mark = ", q3_mark)
                        print("wrong_q_array =", wrongQArray)
                    }
                }
                .padding(.top, 50)
                .offset(y: -30)
                Text("Wait for timer to finish")
                Text("Time remaining: \(timer.timeRemaining)")
                    .edgesIgnoringSafeArea(.bottom)
                    .onReceive(timer.objectWillChange) { _ in
                            if timer.timeRemaining == 0 {
                                generateCurrentDateTime(currentMark: $currentMark)
                                isShowingResultView = true
                            }
                        }
            }
            .fullScreenCover(isPresented: $isShowingResultView) {
                ResultView(currentMark: $currentMark, username: username)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
                        alertMessage = "Are you sure you want to go to PlayMenu?"
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                    
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
                        alertMessage = "Are you sure you want to go to Overview?"
                    }) {
                        Label("Overview", systemImage: "info.circle")
                    }
                    Button(action: {
                        showAlert = true
                        timer.stopTimer()
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
                primaryButton: .cancel(Text("Cancel"), action: {
                    timer.startTimer()
                }),
                secondaryButton: .default(Text("OK"), action: {
                    if alertMessage == "Are you sure you want to go to PlayMenu?" {
                        navigateToPlayMenu = true
                        timer.stopTimer()
                    } else if alertMessage == "Are you sure you want to go to Overview?" {
                        navigateToOverview = true
                        timer.stopTimer()
                    }
                    else if alertMessage == "Are you sure you want to go to Dictionary?" {
                        navigateToDictionary = true
                        timer.stopTimer()
                    }
                })
            )
        }
        .onReceive(timer.objectWillChange) { _ in
                    if timer.timeRemaining == 0 {
                        isShowingResultView = true
                    }
                }
    }
    
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][2]
        print("shuffle_question_set for question 3: \(generatedShuffleQuestionSet)")
        print("question_no for question 3: \(question_no)")
        return question_no
    }
}


struct ContentView_time_limit_heart_atack_Previews: PreviewProvider {
    static var previews: some View {
        return WelcomeView()
    }
}



struct generateRandomNoView_time_limit_heart_attack: View {
    @State private var generatedShuffleQuestionSet = 0
    @ObservedObject var timer = TimerManager_heart_attack()
    @State var isShowingNextView = false
    @State var isShowingResultView = false
    @State private var wrongQArray: [Int] = []
    @State private var currentMark : Double = 0
    let username: String
    var body: some View {
        ZStack{
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Button {
                    generatedShuffleQuestionSet = generateRandomIndex()
                    timer.startTimer()
                    isShowingNextView.toggle()
                } label: {
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
                NavigationLink(destination: ContentView_time_limit_heart_attack(timer: timer, isShowingResultView: $isShowingResultView, generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray), isActive: $isShowingNextView) {
                    EmptyView()
                }
            }
        }
    }
    func transitionToNextView() {
            timer.startTimer()
            isShowingNextView.toggle()
        }
    func generateRandomIndex() -> Int {
        let generatedShuffleQuestionSet = Int.random(in: 0..<34)
        let questionNo = randomarray[generatedShuffleQuestionSet][0]
        print("shuffle_question_set: \(generatedShuffleQuestionSet)")
        print("first question no: \(questionNo)")
        return generatedShuffleQuestionSet // Return the generated value
    }
}

