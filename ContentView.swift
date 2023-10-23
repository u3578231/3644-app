//content view time limit
//  ContentView.swift
//  grammar
//
//  Created by Ryan Hui on 22/7/2023.
//


import SwiftUI
let question_no = [1, 2, 3]
let randomarray = [[2,3,5], [0, 1, 3], [5,2,1], [1, 3, 2], [2,3,4], [5,3,4], [0, 2, 1], [4,3,5], [3, 2, 0], [4,1,5], [2, 0, 1], [3,4,1], [1,4,5], [2, 1, 3], [1,2,3], [3,5,4],  [3,2,1], [5,3,1],[4,1,2], [3,1,4], [2,5,1]]
let questions = ["Which of the following is a subfield of AI that focuses on enabling computers to understand and process human language?", "What is the process of teaching a machine learning model with labeled data called?", "Which technique is commonly used for training deep learning models?", "What is the primary goal of artificial intelligence (AI)?", "Which algorithm is commonly used for clustering data points in unsupervised machine learning?", "What is the concept of teaching an AI model to perform a task by providing feedback on its performance called?"]
let optionA = ["A: Computer vision", "A: Unsupervised learning", "A: Reinforcement learning", "A: Automating repetitive tasks", "A: K-means", "A: Active learning"]
let optionB = ["B: Natural language processing (NLP)", "B: Reinforcement learning", "B: Naive Bayes", "B: Simulating human intelligence", "B: Random Forest", "B: Semi-supervised learning"]
let optionC = ["C: Robotics", "C: Supervised learning", "C: Convolutional neural networks", "C: Enhancing decision-making", "C: Support Vector Machines (SVM)", "C: Transfer learning"]
let optionD = ["D: Genetic algorithms", "D: Transfer learning", "D: Decision trees", "D: Improving data security", "D: Gradient Boosting", "D: Reinforcement learning"]
let correctans = ["B: Natural language processing (NLP)", "C: Supervised learning", "C: Convolutional neural networks", "B: Simulating human intelligence", "B: It is difficult", "D: Reinforcement learning"]
let tips = ["Both robotics and genetic algorithms are not subfields of AI", "Unsupervised learning means providing no guidance to system to analyze the data", "Neural networks contain convolutional and pooling layers for extracting features", "AI aims to possess human brain thinking ability", "b) Random Forest, Support Vector Machines (SVM), Gradient Boosting are related to classification", "Reinforcement learning learns by having agents as environment sensingand feedbacks as return"]
let dictionary_word = ["Supervised learning", "Unsupervised learning", "Reinforcement learning", "Artificial intelligence", "Convolutional layers"]
let dictionary_purpose = ["model learns from labeled training data to make predictions or classify new, unseen data", "explore and extract insights from the data, uncover hidden patterns", "maximize a cumulative reward signal over a sequence of actions taken by the agent in a dynamic environment", "create intelligent systems that can perceive, reason, learn, and make decisions or predictions", "extract spatial hierarchies of features from input data"]
let dictionary_how_does_it_work = ["1. the training data is collected or generated\n 2. the data is split into two sets: the training set used to train the model and the test set\n 3. fine-tuning hyperparameters", "1. analyzing the input data and finding inherent patterns or similarities OR reduce the number of input features while preserving important information \n2. iteratively updating model parameters or optimizing certain criteria to minimize the differences or maximize the similarities between data points", "1. interacts with the environment by taking actions and receiving feedback in the form of rewards or penalties based on its actions.\n2. learns by updating its policy based on the rewards received and the observed consequences of its actions", "1. training AI model to extract patterns\n2. fine-tuning models\n3. develop human-like functionalies", "1. application of convolutional filters or kernels to the input data\n2. shift filters across the input to capture patterns\n3. feature map generated, which is the response of a particular filter"]
let dictionary_example = ["1. classifying spam and non-spam emails\n 2.sentiment analysis", "1. Anomaly detection\n 2. group customers based on their purchasing behavior", "1. autonomous driving agent.\n2. chess games", "1. Face detection\n2. voice assistants\n3. recommendation systems", "1. Detection of edges in image\n2. identify certain sequence pattern in genome"]
struct BackgroundImageView: View {
    var imageName: String
    var rotationAngle: Double
    var xOffset: CGFloat
    var yOffset: CGFloat
    var scale: Double
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .rotationEffect(Angle(degrees: rotationAngle))
            .scaleEffect(scale)
            .offset(x: xOffset, y: yOffset)
    }
}
class QuestionData: ObservableObject {
  @Published var answeredarray = Array(repeating: false, count: 5)
}

class TimerManager: ObservableObject {
    @Published var timeRemaining = 10
    @Published var score = 0
    private var timer: Timer?
    var onTimerFinished: (() -> Void)?
    private var pausedTimeRemaining = 0

    func startTimer() {
        timer?.invalidate()
        if pausedTimeRemaining > 0 {
            timeRemaining = pausedTimeRemaining
        } else {
            timeRemaining = 10
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.onTimerFinished?()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        pausedTimeRemaining = timeRemaining
        timer = nil
    }
}


struct ContentView_time_limit: View {
    var generatedShuffleQuestionSet: Int
    @StateObject private var timerManager = TimerManager()
    @State private var isShowingSideMenu = false
    @State private var selectedq1Answer: String?
    @State private var navigateToQuestion2 = false
    @State private var navigateToOverview = false
    @State private var showMenu = false
    @State private var selectedTab = 0
    @State private var navigateToScore = false
    @State private var showCorrectMessage = false
    @State private var showWrongMessage = false
    @State private var answercorrect = false
    @State private var showPlayMenu = false
    @State private var showAlert = false
    @State private var navigateToPlayMenu = false
    @State private var alertMessage = ""
    @State private var pausedTimeRemaining = 0
    @State private var currentquestion_mark = 0
    @State private var previousAnswer = ""
    @State private var selectedMenuItem = 0
    @State private var show_OK_Alert = false
    @Binding private var currentMark : Double
    @Binding private var wrongQArray: [Int]
    @State private var q1_mark : Double = 0
    let username: String
    init(generatedShuffleQuestionSet: Int, currentMark: Binding<Double>, username: String, wrongQArray: Binding<[Int]>) {
        self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
        self._currentMark = currentMark
        self._timerManager = StateObject(wrappedValue: TimerManager())
        self.username = username
        self._wrongQArray = wrongQArray
    }
    func checkAnswerAndIncrementMark() {
        let questionindex = findquestionIndex()
        if let selectedq1Answer = selectedq1Answer, selectedq1Answer == correctans[randomarray[generatedShuffleQuestionSet][0]] {
            answercorrect = true
            q1_mark = 1
            if let index = wrongQArray.firstIndex(of: questionindex) {
                wrongQArray.remove(at: index)
            }
        }
        else{
            answercorrect = false
            q1_mark = 0
            if !wrongQArray.contains(questionindex) {
                wrongQArray.append(questionindex)
            }
        }
    }
    var body: some View {
            ZStack{
                Image("background") // Set the desired image as the background
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    let questionindex = findquestionIndex()
                    Text("Question 1")
                        .font(.title)
                        .padding(.top,50)
                    QuestionView(number: questionindex, question: questions[questionindex], ansA: optionA[questionindex], ansB: optionB[questionindex], ansC: optionC[questionindex], ansD: optionD[questionindex]) { answer in
                        selectedq1Answer = answer
                        if timerManager.timeRemaining > 0 {
                            selectedq1Answer = answer
                            checkAnswerAndIncrementMark()
                        }
                    }
                    .padding(.top, 50)
                    .offset(y: -30)
                    .disabled(showCorrectMessage || showWrongMessage)
                    NavigationLink(destination: Question2View_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark).environmentObject(timerManager)) {
                        Text("Next question")
                    }
                    .onDisappear(){
                        checkAnswerAndIncrementMark()
                        pausedTimeRemaining = timerManager.timeRemaining
                        timerManager.stopTimer()
                    }
                    .onAppear {
                        timerManager.timeRemaining = pausedTimeRemaining
                        timerManager.onTimerFinished = {
                            handleTimerFinished(answercorrect: answercorrect)
                        }
                        timerManager.startTimer()
                    }
                    Text("Time Remaining: \(timerManager.timeRemaining)")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing:
                    Menu {
                        Button(action: {
                            handleMenuItemSelection(0) // PlayMenu
                        }) {
                            Label("PlayMenu", systemImage: "play")
                        }
                        
                        Button(action: {
                            handleMenuItemSelection(1) // Overview
                        }) {
                            Label("Overview", systemImage: "info.circle")
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
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert"),
                    message: Text(alertMessage),
                    primaryButton: .cancel(Text("Cancel"), action: {
                        // Resume timer counting down
                        timerManager.startTimer()
                    }),
                    secondaryButton: .default(Text("OK"), action: {
                        if alertMessage == "You will lose your progress if you go to PlayMenu" {
                            navigateToPlayMenu = true
                        } else if alertMessage == "You will lose your progress if you go to Overview" {
                            navigateToOverview = true
                            timerManager.stopTimer()
                        }
                    })
                )
            }
            .overlay(
                Group {
                    if showCorrectMessage {
                        Text("You are correct")
                    } else if showWrongMessage {
                        Text("You are wrong")
                    } else {
                        EmptyView()
                    }
                }
            )
        }
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][0]
        print("shuffle_question_set for question 1: \(generatedShuffleQuestionSet)")
        print("question_no_3: \(question_no)")
        return question_no
    }
    func handleTimerFinished(answercorrect: Bool) {
        DispatchQueue.main.async {
            if answercorrect {
                q1_mark = 1
                showCorrectMessage = true
                showWrongMessage = false
            } else {
                q1_mark = 0
                showCorrectMessage = false
                showWrongMessage = true
            }
            show_OK_Alert = true
        }
    }
    func handleMenuItemSelection(_ value: Int) {
        switch value {
        case 0: // PlayMenu
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to PlayMenu"
        case 1: // Overview
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to Overview"
        default:
            break
        }
    }
}


struct Question2View_time_limit: View {
    var generatedShuffleQuestionSet: Int
    @Binding private var currentMark: Double
    @StateObject private var timerManager = TimerManager()
    @State private var isShowingSideMenu = false
    @State private var selectedq1Answer: String?
    @State private var navigateToQuestion2 = false
    @State private var navigateToOverview = false
    @State private var showMenu = false
    @State private var selectedTab = 0
    @State private var navigateToScore = false
    @State private var showCorrectMessage = false
    @State private var showWrongMessage = false
    @State private var answercorrect = false
    @State private var showPlayMenu = false
    @State private var showAlert = false
    @State private var navigateToPlayMenu = false
    @State private var alertMessage = ""
    @State private var show_OK_Alert = false
    @State private var pausedTimeRemaining = 0
    @Binding private var wrongQArray: [Int]
    var q1_mark: Double
    @State private var q2_mark : Double = 0
    let username: String
    init(generatedShuffleQuestionSet: Int, currentMark: Binding<Double>, username: String, wrongQArray: Binding<[Int]>, q1_mark: Double) {
        self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
        self._currentMark = currentMark
        self._timerManager = StateObject(wrappedValue: TimerManager())
        self.username = username
        self._wrongQArray = wrongQArray
        self.q1_mark = q1_mark
    }
    func checkAnswerAndIncrementMark() {
        let questionindex = findquestionIndex()
        if let selectedq1Answer = selectedq1Answer, selectedq1Answer == correctans[randomarray[generatedShuffleQuestionSet][1]] {
            answercorrect = true
            q2_mark = 1
            if let index = wrongQArray.firstIndex(of: questionindex) {
                wrongQArray.remove(at: index)
            }
        }
        else{
            answercorrect = false
            q2_mark = 0
            if !wrongQArray.contains(questionindex) {
                wrongQArray.append(questionindex)
            }
        }
    }
    var body: some View {
            ZStack{
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
                        selectedq1Answer = answer
                        // Increment mark if answer is correct
                        if timerManager.timeRemaining > 0 {
                            selectedq1Answer = answer
                            checkAnswerAndIncrementMark()
                        }
                    }
                    .padding(.top, 50)
                    .offset(y: -30)
                    .disabled(showCorrectMessage || showWrongMessage)
                    NavigationLink(destination: Question3View_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark,q2_mark: q2_mark).environmentObject(timerManager)) {
                        Text("Next question")
                    }
                    .onDisappear(){
                        checkAnswerAndIncrementMark()
                        pausedTimeRemaining = timerManager.timeRemaining
                        timerManager.stopTimer()
                    }
                    .onAppear {
                        timerManager.timeRemaining = pausedTimeRemaining
                        timerManager.onTimerFinished = {
                            handleTimerFinished(answercorrect: answercorrect)
                        }
                        timerManager.startTimer()
                    }
                    Text("Time Remaining: \(timerManager.timeRemaining)")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing:
                    Menu {
                        Button(action: {
                            handleMenuItemSelection(0) // PlayMenu
                        }) {
                            Label("PlayMenu", systemImage: "play")
                        }
                        
                        Button(action: {
                            handleMenuItemSelection(1) // Overview
                        }) {
                            Label("Overview", systemImage: "info.circle")
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
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert"),
                    message: Text(alertMessage),
                    primaryButton: .cancel(Text("Cancel"), action: {
                        timerManager.startTimer()
                    }),
                    secondaryButton: .default(Text("OK"), action: {
                        if alertMessage == "You will lose your progress if you go to PlayMenu" {
                            navigateToPlayMenu = true
                        } else if alertMessage == "You will lose your progress if you go to Overview" {
                            navigateToOverview = true
                            timerManager.stopTimer()
                        }
                    })
                )
            }
            .overlay(
                Group {
                    if showCorrectMessage {
                        Text("You are correct")
                    } else if showWrongMessage {
                        Text("You are wrong")
                    } else {
                        EmptyView()
                    }
                }
            )
        }
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][1]
        print("shuffle_question_set for question 2: \(generatedShuffleQuestionSet)")
        print("question_no_2: \(question_no)")
        return question_no
    }

    func handleTimerFinished(answercorrect: Bool) {
        DispatchQueue.main.async {
            if answercorrect {
                q2_mark = 1
                showCorrectMessage = true
                showWrongMessage = false
                alertMessage = "You are correct"
            } else {
                q2_mark = 0
                showCorrectMessage = false
                showWrongMessage = true
                alertMessage = "You are wrong"
            }
            show_OK_Alert = true
        }
    }
    func handleMenuItemSelection(_ value: Int) {
        switch value {
        case 0: // PlayMenu
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to PlayMenu"
        case 1: // Overview
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to Overview"
        default:
            break
        }
    }
}


struct Question3View_time_limit: View {
    var generatedShuffleQuestionSet: Int
    @Binding private var currentMark: Double
    @StateObject private var timerManager = TimerManager()
    @State private var isShowingSideMenu = false
    @State private var selectedq1Answer: String?
    @State private var navigateToQuestion2 = false
    @State private var navigateToOverview = false
    @State private var showMenu = false
    @State private var selectedTab = 0
    @State private var navigateToScore = false
    @State private var showCorrectMessage = false
    @State private var showWrongMessage = false
    @State private var answercorrect = false
    @State private var showPlayMenu = false
    @State private var showAlert = false
    @State private var navigateToPlayMenu = false
    @State private var alertMessage = ""
    @State private var pausedTimeRemaining = 0
    @State private var show_OK_Alert = false
    @State private var showResultView = false
    @Binding private var wrongQArray : [Int]
    var q1_mark: Double
    var q2_mark: Double
    @State private var q3_mark : Double = 0
    let username: String
    init(generatedShuffleQuestionSet: Int, currentMark: Binding<Double>, username: String, wrongQArray: Binding<[Int]>, q1_mark: Double, q2_mark: Double) {
        self.generatedShuffleQuestionSet = generatedShuffleQuestionSet
        self._currentMark = currentMark
        self._timerManager = StateObject(wrappedValue: TimerManager())
        self.username = username
        self._wrongQArray = wrongQArray
        self.q1_mark = q1_mark
        self.q2_mark = q2_mark
    }
    func checkAnswerAndIncrementMark() {
        let questionindex = findquestionIndex()
        if let selectedq1Answer = selectedq1Answer, selectedq1Answer == correctans[randomarray[generatedShuffleQuestionSet][2]] {
            answercorrect = true
            q3_mark = 1
            if let index = wrongQArray.firstIndex(of: questionindex) {
                wrongQArray.remove(at: index)
            }
        }
        else{
            answercorrect = false
            q3_mark = 0
            if !wrongQArray.contains(questionindex) {
                wrongQArray.append(questionindex)
            }
        }
    }
    func generateCurrentDateTime(q1_mark: Double, q2_mark: Double, q3_mark: Double, currentMark: Binding<Double>) {
        let currentDate = Date()
        currentMark.wrappedValue = q1_mark + q2_mark + q3_mark
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Hong_Kong")
        let formattedDate = dateFormatter.string(from: currentDate)
        print("Current Date: \(formattedDate)")
        if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
                userArray[userIndex].dateArray.append(formattedDate)
                userArray[userIndex].playermodeArray.append("no time limit")
                userArray[userIndex].MarkArray.append($currentMark.wrappedValue)
                userArray[userIndex].wrong_q_2D_array.append(wrongQArray)
                print("Date array = ", userArray[userIndex].dateArray)
                print("Username = ", userArray[userIndex].username)
                print("player mode = ", userArray[userIndex].playermodeArray)
                print("current mark = ", userArray[userIndex].MarkArray)
                print("Wrong questions = ", userArray[userIndex].wrong_q_2D_array)
            }
    }
    var body: some View {
        ZStack{
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
                        selectedq1Answer = answer
                        if timerManager.timeRemaining > 0 {
                            selectedq1Answer = answer
                            checkAnswerAndIncrementMark()
                        }
                    }
                .padding(.top, 50)
                .offset(y: -30)
                .disabled(showCorrectMessage || showWrongMessage)
                Button(action: {
                    generateCurrentDateTime(q1_mark: q1_mark, q2_mark: q2_mark, q3_mark: q3_mark, currentMark: $currentMark)
                   self.showResultView = true
               }) {
                   Text("See Result")
               }
                .onDisappear(){
                    checkAnswerAndIncrementMark()
                    pausedTimeRemaining = timerManager.timeRemaining
                    timerManager.stopTimer()
                }
                .onAppear {
                    timerManager.timeRemaining = pausedTimeRemaining
                    timerManager.onTimerFinished = {
                        handleTimerFinished(answercorrect: answercorrect)
                    }
                    timerManager.startTimer()
                }
                Text("Time Remaining: \(timerManager.timeRemaining)")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            .fullScreenCover(isPresented: $showResultView) {
                ResultView(currentMark: $currentMark, username: username).environmentObject(timerManager)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        handleMenuItemSelection(0) // PlayMenu
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                    
                    Button(action: {
                        handleMenuItemSelection(1) // Overview
                    }) {
                        Label("Overview", systemImage: "info.circle")
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
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert"),
                message: Text(alertMessage),
                primaryButton: .cancel(Text("Cancel"), action: {
                    timerManager.startTimer()
                }),
                secondaryButton: .default(Text("OK"), action: {
                    if alertMessage == "You will lose your progress if you go to PlayMenu" {
                        navigateToPlayMenu = true
                    } else if alertMessage == "You will lose your progress if you go to Overview" {
                        navigateToOverview = true
                        timerManager.stopTimer()
                    }
                })
            )
        }
        .overlay(
            Group {
                if showCorrectMessage {
                    Text("You are correct")
                } else if showWrongMessage {
                    Text("You are wrong")
                } else {
                    EmptyView()
                }
            }
        )
    }
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][2]
        print("shuffle_question_set for question 1: \(generatedShuffleQuestionSet)")
        print("question_no_3: \(question_no)")
        return question_no
    }

    func handleTimerFinished(answercorrect: Bool) {
        DispatchQueue.main.async {
            if answercorrect {
                q3_mark = 1
                showCorrectMessage = true
                showWrongMessage = false
                alertMessage = "You are correct"
            } else {
                q3_mark = 0
                showCorrectMessage = false
                showWrongMessage = true
                alertMessage = "You are wrong"
            }
            show_OK_Alert = true
        }
    }
    func handleMenuItemSelection(_ value: Int) {
        switch value {
        case 0: // PlayMenu
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to PlayMenu"
        case 1: // Overview
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to Overview"
        default:
            break
        }
    }
}

struct QuestionView: View {
    var number: Int
    var question: String
    var ansA: String
    var ansB: String
    var ansC: String
    var ansD: String
    
    var answerSelected: ((String) -> Void)?
    
    @State private var selectedAnswer: String?
    
    var body: some View {
        VStack {
            Text(question)
                .padding()
                .bold()
            
            HStack {
                VStack {
                    OptionA(ansA: ansA)
                        .background(selectedAnswer == ansA ? Color.green : Color.white)
                        .onTapGesture {
                            selectedAnswer = ansA
                            answerSelected?(ansA)
                        }
                    OptionB(ansB: ansB)
                        .background(selectedAnswer == ansB ? Color.green : Color.white)
                        .onTapGesture {
                            selectedAnswer = ansB
                            answerSelected?(ansB)
                        }
                }
                
                VStack {
                    OptionC(ansC: ansC)
                        .background(selectedAnswer == ansC ? Color.green : Color.white)
                        .onTapGesture {
                            selectedAnswer = ansC
                            answerSelected?(ansC)
                        }
                    OptionD(ansD: ansD)
                        .background(selectedAnswer == ansD ? Color.green : Color.white)
                        .onTapGesture {
                            selectedAnswer = ansD
                            answerSelected?(ansD)
                        }
                }
            }
        }
    }
}

struct OptionA: View{
    var ansA: String
    var body: some View{
        Text(ansA)
            .padding()
    }
}

struct OptionB: View{
    var ansB: String
    var body: some View{
        Text(ansB)
            .padding()
    }
}

struct OptionC: View{
    var ansC: String
    var body: some View{
        Text(ansC)
            .padding()
    }
}

struct OptionD: View{
    var ansD: String
    var body: some View{
        Text(ansD)
            .padding()
    }
}

struct ResultView: View {
    @State private var navigateToPlayMenu = false
    @Binding var currentMark: Double
    let username: String
    
    private var formattedMark: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: roundedMark)) ?? ""
    }
    
    private var roundedMark: Double {
        return (currentMark * 10).rounded() / 10
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("background") // Set the desired image as the background
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Result is \(formattedMark)")
                        .font(.largeTitle)
                        .padding()
                    
                    NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                        EmptyView()
                    }
                    
                    Button("Menu") {
                        print("Navigating to TestView")
                        navigateToPlayMenu = true
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
struct OverviewView: View {
    @State private var isShowingPlayMenu = false
    @Binding var showMenu: Bool
    @Binding var navigateToPlayMenu: Bool
    @EnvironmentObject var timer: TimerManager
    @EnvironmentObject var timer1: TimerManager_heart_attack
    @State private var showPlayMenu = false
    @State private var selectedTab = 0
    let username: String
    @Environment(\.presentationMode) var presentationMode // Add this line

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(username)
                    .font(.title)
                    .padding()
                List {
                    HStack {
                        Text("Date")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Player Mode")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Mark")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
                        ForEach(0..<userArray[userIndex].dateArray.count, id: \.self) { index in
                            NavigationLink(destination: ReflectionView(username: username,userIndex: userIndex, index: index)) {
                                HStack {
                                    Text(userArray[userIndex].dateArray[index])
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(userArray[userIndex].playermodeArray[index])
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(userArray[userIndex].MarkArray[index])")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                }
                .padding()
                .scrollContentBackground(.hidden)
            }
            
            NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                EmptyView()
            }
            .padding()
            .padding()
            .navigationBarItems(leading: backButton)
            .navigationBarItems(leading: LargeTitleNavBarTitle(text: "Overview Page"))
            .navigationBarBackButtonHidden(true)
        }
    }
    private var backButton: some View {
        Button(action: {
            navigateToPlayMenu = true // Set navigateToPlayMenu to true
        }) {
            Image(systemName: "chevron.left")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}




struct generateRandomNoView: View {
    let shuffle_question_set: Int
    let username: String
    @State private var currentMark : Double = 0
    @StateObject private var timerManager = TimerManager()
    @State private var wrongQArray: [Int] = []
    var body: some View {
        let generatedShuffleQuestionSet = generateRandomIndex() // Use a different name here
        ZStack{
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                NavigationLink(destination: ContentView_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray)) {
                    Text("Start Game")
                }
            }
        }
    }
    
    func generateRandomIndex() -> Int {
        let shuffleQuestionSet = Int.random(in: 0..<21)
        let questionNo = randomarray[shuffleQuestionSet][0]
        return shuffleQuestionSet // Return the generated value
    }
}



struct WelcomeView: View {
    @State private var navigateToRegisterView = false
    @State private var navigateToObjectiveView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background") // Set the desired image as the background
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Button(action: {
                        navigateToObjectiveView = true
                    }) {
                        Image("Logo icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .cornerRadius(20)
                            .shadow(color: .green, radius: 4, x: 0, y: 2)
                    }
                    Text("Welcome to the learning app")
                        .font(.largeTitle)
                        .padding(.bottom, 40)
                    NavigationLink(
                        destination: RegisterView(),
                        isActive: $navigateToRegisterView
                    ) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        navigateToRegisterView = true
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                                .font(Font.system(size: 20))
                            Text("Start")
                                .font(.title)
                        }
                        .padding()
                        .background(
                            ZStack {
                                Capsule()
                                    .stroke(Color.black, lineWidth: 2)
                                    .shadow(color: .green, radius: 4, x: 0, y: 2)
                            }
                        )
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            .background(
                NavigationLink(destination: ObjectiveView(), isActive: $navigateToObjectiveView) {
                    EmptyView()
                }
            )
        }
    }
}



