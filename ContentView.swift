//content view time limit
//  ContentView.swift
//  grammar
//
//  Created by Ryan Hui on 22/7/2023.
//


import SwiftUI
let question_no = [1, 2, 3]
let randomarray = [[5,7,9],[2,3,5], [6,9,10],[0, 1, 3], [5,2,1], [10,3,4], [1, 3, 2], [2,3,4], [7,3,8],[5,3,4], [0, 2, 1], [4,3,5], [3, 2, 0], [9,1,0],[4,1,5], [10,6,4],[2, 0, 1], [7,8,1],[3,4,1],[8,9,10], [1,4,5], [6,7,8],[2, 1, 3], [10,2,6],[1,2,3], [3,5,4], [7,2,0], [3,2,1], [8,4,9],[5,3,1],[4,1,2], [3,1,4], [9,10,2],[2,5,1], [5,9,2],[3,6,9]]
let questions = ["Which of the following is a subfield of AI that focuses on enabling computers to understand and process human language?", "What is the process of teaching a machine learning model with labeled data called?", "Which technique is commonly used for training deep learning models?", "What is the primary goal of artificial intelligence (AI)?", "Which algorithm is commonly used for clustering data points in unsupervised machine learning?", "What is the concept of teaching an AI model to perform a task by providing feedback on its performance called?", "Which is a kind of uninformed search in artificial intelligence?", "What is the difference between temporal difference learning and Q-learning?", "Which is correct about a state space graph and search tree?", "What is time complexity of Depth-First-Search? where E = no. of edges, N = no. of nodes", "Which of the following is not an optimization technique to avoid overfitting?"]
let optionA = ["A: Computer vision", "A: Unsupervised learning", "A: Reinforcement learning", "A: Automating repetitive tasks", "A: K-means", "A: Active learning", "A: Breadth-First-Search", "A: TDL is model-free while Q-learning is model-based", "A: State space graph and search tree are both complete", "A: O(N^2)", "A: ReLU"]
let optionB = ["B: Natural language processing (NLP)", "B: Reinforcement learning", "B: Naive Bayes", "B: Simulating human intelligence", "B: Random Forest", "B: Semi-supervised learning", "B: Local search", "B: TDL is belongs to reinforcement learning while Q-learning belongs to unsupervised learning", "B: State space graph shows all possible transitions while search tree shows the possible routes to reach a goal", "B: O(E^2)", "B: Adagrad"]
let optionC = ["C: Robotics", "C: Supervised learning", "C: Convolutional neural networks", "C: Enhancing decision-making", "C: Support Vector Machines (SVM)", "C: Transfer learning", "C: A-star search", "C: TDL uses actual observed reward plus future estimated action value of next state while Q-learning keep tracks of maximum maximum estimated action value of next state", "C: Both help find the way to a goal state", "C: O(NE)", "C: Adam"]
let optionD = ["D: Genetic algorithms", "D: Transfer learning", "D: Decision trees", "D: Improving data security", "D: Gradient Boosting", "D: Reinforcement learning", "D: Greedy search", "D: TDL converges to a solution while Q-learning does not", "D: Search tree uses an array to store the possible solutions", "D: O(N+E)", "D: Rprop"]
let correctans = ["B: Natural language processing (NLP)", "C: Supervised learning", "C: Convolutional neural networks", "B: Simulating human intelligence", "A: K-means", "D: Reinforcement learning","A: Breadth-First-Search", "C: TDL uses actual observed reward plus future estimated action value of next state while Q-learning keep tracks of maximum maximum estimated action value of next state","B: State space graph shows all possible transitions while search tree shows the possible routes to reach a goal", "D: O(N+E)", "A: ReLU"]
let tips = ["Both robotics and genetic algorithms are not subfields of AI", "Unsupervised learning means providing no guidance to system to analyze the data", "Neural networks contain convolutional and pooling layers for extracting features", "AI aims to possess human brain thinking ability", "Random Forest, Support Vector Machines (SVM), Gradient Boosting are related to classification", "Reinforcement learning learns by having agents as environment sensingand feedbacks as return", "Depth-First-Search and Breadth-First-Search are both uninformed searches", "Q-learning has a maximizing component but TDL does not", "State space graph analyzes the possible states in a problem domain while search tree searches the solution from initial state to goal state", "DFS will visit all the edges and nodes once in the worst case", "ReLU is an activation function to control neural network output"]
let dictionary_word = ["Supervised learning", "Unsupervised learning", "Reinforcement learning", "Artificial intelligence", "Convolutional layers"]
let dictionary_purpose = ["model learns from labeled training data to make predictions or classify new, unseen data", "explore and extract insights from the data, uncover hidden patterns", "maximize a cumulative reward signal over a sequence of actions taken by the agent in a dynamic environment", "create intelligent systems that can perceive, reason, learn, and make decisions or predictions", "extract spatial hierarchies of features from input data"]
let dictionary_how_does_it_work = ["1. the training data is collected or generated\n2. the data is split into two sets: the training set used to train the model and the test set\n3. fine-tuning hyperparameters\n4. Factors affecting performance: Balancing and cleaniness of data, diversity of data\n5. Overfitting occurs if the model trains for a long epoch or is too powerful.\n6. Underfitting occurs if the model trains for a short period of time or is not powerful enough", "1. analyzing the input data and finding inherent patterns or similarities OR reduce the number of input features while preserving important information \n2. iteratively updating model parameters or optimizing certain criteria to minimize the differences or maximize the similarities between data points\n3. Common clustering algorithms are K-means clustering, principal component analysis\n4. Some association rule learning algorithms are Apriori algorithm and ECLAT algorithm\n5. Usually unsupervised learning still starts with supervised learning to learn prediction of class labels, boundary boxes, and then continue without training data for unsupervised learning tasks", "1. interacts with the environment by taking actions and receiving feedback in the form of rewards or penalties based on its actions.\n2. learns by updating its policy based on the rewards received and the observed consequences of its actions\n3. RL algorithms can be broadly categorized as model-free and model-based. Model-free algorithms do not build an explicit model of the environment, or more rigorously, the MDP. They are closer to trial-and-error algorithms that run experiments with the environment using actions and derive the optimal policy from it directly.\n4. Policy-based approaches suffer from a high variance which manifests as instabilities during the training process. Value-based approaches, though more stable, are not suitable to model continuous action spaces.", "1. training AI model to extract patterns by neural network, Transformer models, stable diffusion models\n2. fine-tuning models' parameters to avoid overfitting and achieve highest precision and recall\n3. develop human-like functionalies by adopting the model to suit different purposes, e.g. regression, segmentation tasks\n4. Subfields of AI: Machine Learning and Neural Network\n5. Technology of AI required: GPUs for training datasets, memory for storing datasets, huge and diverse datasets for gression, classification tasks, APIs to call libraries for training data ", "1. application of convolutional filters or kernels to the input data\n2. shift filters across the input to capture patterns\n3. feature map generated, which is the response of a particular filter\n4. Different from pooling layers, convolution layers reduce the dimensionality of features, while pooling layers upscale the features\n5. Concepts of stride, padding are applied to convolutional filters\n6. More convolutional filters help extract fine-grained details at the risk of overfitting\n7. Convolutional layers have to be followed by pooling layers to gather fine-scale and large-scale feature maps"]
let dictionary_example = ["1. classifying spam and non-spam emails\n 2.sentiment analysis", "1. Anomaly detection\n 2. group customers based on their purchasing behavior", "1. autonomous driving agent.\n2. chess games", "1. Face detection\n2. voice assistants\n3. recommendation systems", "1. Detection of edges in image\n2. identify certain sequence pattern in genome"]
var dictionaryArray: [[String: String]] = []
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
    @State private var navigateToDictionary = false
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
                    .padding(.top, 350)
                    .offset(y: -30)
                    .disabled(showCorrectMessage || showWrongMessage)
                    NavigationLink(destination: Question2View_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark).environmentObject(timerManager)) {
                        Text("Next question")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .isDetailLink(false)
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
                        .padding(100)
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Question 1")
                .navigationBarItems(trailing:
                    Menu {
                        Button(action: {
                            handleMenuItemSelection(0) // PlayMenu
                        }) {
                            Label("PlayMenu", systemImage: "play")
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
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
                        else if alertMessage == "You will lose your progress if you go to Dictionary"{
                            navigateToDictionary = true
                        }
                    })
                )
            }
            .overlay(
                Group {
                    if showCorrectMessage {
                        Text("You are correct")
                            .padding(.top, -400)
                            .font(.system(size:25))
                            .foregroundColor(.green)
                    } else if showWrongMessage {
                        Text("You are wrong")
                            .padding(.top, -400)
                            .font(.system(size:25))
                            .foregroundColor(.red)
                    } else {
                        EmptyView()
                    }
                }
            )
        }
    func findquestionIndex() -> Int {
        let question_no = randomarray[generatedShuffleQuestionSet][0]
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
        case 2: // Dictionary
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to Dictionary"
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
    @State private var navigateToDictionary = false
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
                Image("background")
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
                        if timerManager.timeRemaining > 0 {
                            selectedq1Answer = answer
                            checkAnswerAndIncrementMark()
                        }
                    }
                    .padding(.top, 350)
                    .offset(y: -30)
                    .disabled(showCorrectMessage || showWrongMessage)
                    NavigationLink(destination: Question3View_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray, q1_mark: q1_mark,q2_mark: q2_mark).environmentObject(timerManager)) {
                        Text("Next question")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        }
                        .isDetailLink(false)
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
                        .padding(100)
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Question 2")
                .navigationBarItems(trailing:
                    Menu {
                        Button(action: {
                            handleMenuItemSelection(0) // PlayMenu
                        }) {
                            Label("PlayMenu", systemImage: "play")
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
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
                        else if alertMessage == "You will lose your progress if you go to Dictionary"{
                            navigateToDictionary = true
                        }
                                    
                    })
                )
            }
            .overlay(
                Group {
                    if showCorrectMessage {
                        Text("You are correct")
                            .font(.system(size:25))
                            .foregroundColor(.green)
                            .padding(.top, -400)
                    } else if showWrongMessage {
                        Text("You are wrong")
                            .font(.system(size:25))
                            .foregroundColor(.red)
                            .padding(.top, -400)
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
        case 2: // Dictionary
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to Dictionary"
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
    @State private var navigateToDictionary = false
    @Binding private var wrongQArray : [Int]
    @State private var gameplay = "time limit easy"
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
                userArray[userIndex].playermodeArray.append("time limit easy")
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
            Image("background")
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
                .padding(.top, 350)
                .offset(y: -30)
                .disabled(showCorrectMessage || showWrongMessage)
                Button(action: {
                    generateCurrentDateTime(q1_mark: q1_mark, q2_mark: q2_mark, q3_mark: q3_mark, currentMark: $currentMark)
                    self.showResultView = true
                }) {
                    Text("See Result")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
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
                    .padding(100)
                
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            .fullScreenCover(isPresented: $showResultView) {
                ResultView(currentMark: $currentMark, gameplay: $gameplay,username: username).environmentObject(timerManager)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Question 3")
            .navigationBarItems(trailing:
                Menu {
                    Button(action: {
                        handleMenuItemSelection(0) // PlayMenu
                    }) {
                        Label("PlayMenu", systemImage: "play")
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
                
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
                    else if alertMessage == "You will lose your progress if you go to Dictionary"{
                        navigateToDictionary = true
                    }
                                
                })
            )
        }
        .overlay(
            Group {
                if showCorrectMessage {
                    Text("You are correct")
                        .font(.system(size:25))
                        .foregroundColor(.green)
                        .padding(.top, -400)
                } else if showWrongMessage {
                    Text("You are wrong")
                        .font(.system(size:25))
                        .foregroundColor(.red)
                        .padding(.top, -400)
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
        case 2: // Dictionary
            showAlert = true
            print("showAlert =", showAlert)
            timerManager.stopTimer()
            alertMessage = "You will lose your progress if you go to Dictionary"
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
                }
                .frame(width: 330, height: 150) // Specify the frame size for OptionA
                
                VStack {
                    OptionB(ansB: ansB)
                        .background(selectedAnswer == ansB ? Color.green : Color.white)
                        .onTapGesture {
                            selectedAnswer = ansB
                            answerSelected?(ansB)
                        }
                }
                .frame(width: 330, height: 150) // Specify the frame size for OptionB
            }
            .padding(.vertical, 10)
            
            HStack {
                VStack {
                    OptionC(ansC: ansC)
                        .background(selectedAnswer == ansC ? Color.green : Color.white)
                        .onTapGesture {
                            selectedAnswer = ansC
                            answerSelected?(ansC)
                        }
                }
                .frame(width: 330, height: 150) // Specify the frame size for OptionC
                
                VStack {
                    OptionD(ansD: ansD)
                        .background(selectedAnswer == ansD ? Color.green : Color.white)
                        .onTapGesture {
                            selectedAnswer = ansD
                            answerSelected?(ansD)
                        }
                }
                .frame(width: 330, height: 150) // Specify the frame size for OptionD
            }
            .padding(.vertical, 10)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
struct OverviewView: View {
    @State private var isShowingPlayMenu = false
    @EnvironmentObject var timer: TimerManager
    @EnvironmentObject var timer1: TimerManager_heart_attack
    @State private var selectedTab = 0
    let username: String
    @Environment(\.presentationMode) var presentationMode // Add this line

    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Name: \(username)")
                    .font(.title)
                    .padding(.top, 210)
                
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
                            NavigationLink(destination: ReflectionView(username: username, userIndex: userIndex, index: index)) {
                                HStack {
                                    Text(userArray[userIndex].dateArray[index])
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(userArray[userIndex].playermodeArray[index])
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(String(format: "%.1f", userArray[userIndex].MarkArray[index]))")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }                    
                        }
                    }
                }
                .padding(.top, 150)
                .scrollContentBackground(.hidden)
            }
            VStack {
                if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
                    let markArray = userArray[userIndex].MarkArray.map { String($0) }
                    let marks = markArray.compactMap { Double($0) }
                    let averageMark = marks.reduce(0, +) / Double(marks.count)
                    if (!markArray.isEmpty){
                        if averageMark <= 1.5 {
                            Text("You need improvement")
                                .modifier(BlueShadowTextModifier())
                        } else if averageMark > 1.5 && averageMark < 2.5 {
                            Text("You got a good grasp of AI")
                                .modifier(BlueShadowTextModifier())
                        } else if averageMark >= 2.5 && averageMark < 3 {
                            Text("You are superb!")
                                .modifier(BlueShadowTextModifier())
                        }
                    }
                }
            }
            .font(.headline)
            .padding()
            .cornerRadius(10)
            .padding()
            .offset(y: -350)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarBackButtonHidden(false)
        .navigationTitle("Overview")
    }
}

struct BlueShadowTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 4, x: 0, y: 2)
            )
            .foregroundColor(.blue)
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
            VStack(spacing: 40) {
                Text("This gameplay has 3 questions in total, each question carries 1 mark, and you have 10 seconds to answer each question")
                    .font(.system(size:20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .frame(width: 600, height: 150)
                NavigationLink(destination: ContentView_time_limit(generatedShuffleQuestionSet: generatedShuffleQuestionSet, currentMark: $currentMark, username: username, wrongQArray: $wrongQArray)) {
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
            .navigationTitle("Time Limit Easy")
        }
    }
    
    func generateRandomIndex() -> Int {
        let shuffleQuestionSet = Int.random(in: 0..<34)
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
                .isDetailLink(false)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


