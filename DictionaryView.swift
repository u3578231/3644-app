
//  DictionaryView.swift
//  grammar
//
//  Created by Ryan Hui on 23/8/2023.
//

import SwiftUI

struct DictionaryView: View {
    @State private var searchText = ""
    @Binding var navigateToPlayMenu: Bool
    //@State private var navigateToDictionary = false
    let username: String
    let websiteURL = "https://www.tutorialspoint.com/artificial_intelligence/index.htm"

    var filteredWords: [String] {
            if searchText.isEmpty {
                return dictionaryWordFromJSON()
            } else {
                return dictionaryWordFromJSON().filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
    private func dictionaryWordFromJSON() -> [String] {
            do {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent("dictionary.json")
                let jsonData = try Data(contentsOf: fileURL)
                
                let decoder = JSONDecoder()
                let dictionaryArray = try decoder.decode([[String: String]].self, from: jsonData)
                
                return dictionaryArray.compactMap { $0["word"] }
            } catch {
                print("Error in reading JSON file: \(error)")
                return []
            }
        }
    private func createJSONFile() {
        var dictionaryArray: [[String: String]] = []

        for index in 0..<dictionary_word.count {
            let dictionary: [String: String] = [
                "word": dictionary_word[index],
                "purpose": dictionary_purpose[index],
                "how_does_it_work": dictionary_how_does_it_work[index],
                "example": dictionary_example[index]
            ]
            dictionaryArray.append(dictionary)
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionaryArray, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent("dictionary.json")
                try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
                print("JSON file created successfully.")
            }
        } catch {
            print("Error in creating JSON file: \(error)")
        }
    }
    var body: some View {
            ZStack{
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        TextField("Search", text: $searchText)
                            .padding(.horizontal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.top,70)
                        List(filteredWords, id: \.self) { word in
                           NavigationLink(
                               destination: DictionaryWordView(word: word, navigateToPlayMenu: $navigateToPlayMenu, username: username)
                           ) {
                               Text(word)
                           }
                       }
                        Link(destination: URL(string: websiteURL)!) {
                            VStack{
                                Text("For more vocabularies,")
                                Text("Please visit the website")
                            }
                        }
                        .font(.headline)
                        .padding(.bottom, 350)
                        .frame(width:270, height: 140)
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.top, 290)
                }
                NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: backButton
                )
                .navigationTitle("Dictionary")
            }
            .onAppear {
                       createJSONFile()
                   }
    }
    private var backButton: some View {
        Button(action: {
            navigateToPlayMenu = true
        }) {
            Image(systemName: "chevron.left")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}

struct LargeTitleNavBarTitle: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.largeTitle) // Change the font size here
    }
}

struct DictionaryWordView: View {
    let word: String
    @Binding var navigateToPlayMenu: Bool
    let username: String
    @State private var wordData: DictionaryData?
    struct DictionaryData: Codable {
        let purpose: String
        let howDoesItWork: String
        let example: String
    }
    var body: some View {
        ZStack{
            VStack(spacing: -60) {
                Text("Definition of \(word)")
                    .font(.headline)
                GeometryReader { geometry in
                    ScrollView(.horizontal) {
                        HStack {
                            GenerateImageView(word: word)
                        }
                    }
                    .frame(height: geometry.size.height * 0.3)
                }
                .overlay(
                    Group {
                        if let data = wordData {
                            VStack(spacing: 20) {
                                SectionBox(title: "Purpose", content: data.purpose)
                                    .frame(maxWidth: .infinity)
                                SectionBox(title: "How does it work?", content: data.howDoesItWork)
                                    .frame(maxWidth: .infinity)
                                SectionBox(title: "Example", content: data.example)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .top)
                            .padding(.bottom, -50)
                            .opacity(0.9)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.top, -140)
                )
            }
        }
        NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
            EmptyView()
        }
        .onAppear {
            fetchWordData()
        }
    }
    private func fetchWordData() {
            do {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent("dictionary.json")
                let jsonData = try Data(contentsOf: fileURL)
                
                let decoder = JSONDecoder()
                let dictionaryArray = try decoder.decode([[String: String]].self, from: jsonData)
                
                if let index = dictionaryArray.firstIndex(where: { $0["word"] == word }) {
                    let data = dictionaryArray[index]
                    let dictionaryData = DictionaryData(purpose: data["purpose"] ?? "",
                                                        howDoesItWork: data["how_does_it_work"] ?? "",
                                                        example: data["example"] ?? "")
                    wordData = dictionaryData
                }
            } catch {
                print("Error in reading JSON file: \(error)")
            }
        }
}

struct SectionBox: View {
    let title: String
    let content: String
    var body: some View {
        VStack(alignment: .center, spacing: 8) { // Align the content in the center
            Spacer().frame(height: 6)
            Text(title)
                .font(.headline)
                .padding(.bottom,-10)
                .foregroundColor(.blue)
            Text(content)
                .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
struct GenerateImageView: View {
    var word: String
    @State private var isPresented: Bool = false
    @State private var selectedImage: String = ""

    var imageName1: String {
        return word.lowercased() + " 1"
    }

    var imageName2: String {
        return word.lowercased() + " 2"
    }

    var body: some View {
        HStack {
            Image(imageName1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding()
                .onTapGesture {
                    selectedImage = imageName1
                    print(selectedImage)
                    isPresented.toggle()
                }

            Image(imageName2)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding()
                .onTapGesture {
                    selectedImage = imageName2
                    print(selectedImage)
                    isPresented.toggle()
                }
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            print(selectedImage)
        }) {
            FullScreenImageView(imageName: $selectedImage, isPresented: $isPresented)
        }
    }
}

struct FullScreenImageView: View {
    @Binding var imageName: String
    @Binding var isPresented: Bool
    @State private var zoomScale: CGFloat = 1.0
    @State private var previousZoomScale: CGFloat = 1.0
    var body: some View {
        ScrollView(.init()) {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(zoomScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                zoomScale = previousZoomScale * value.magnitude
                            }
                            .onEnded { value in
                                previousZoomScale = zoomScale
                            }
                    )
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onTapGesture {
            isPresented = false
        }
        .onAppear {
            print("Image name =", imageName)
        }
    }
}

