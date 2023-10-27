
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
            return dictionary_word
        } else {
            return dictionary_word.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
            ZStack{
                Image("background") // Set the desired image as the background
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
                        .padding(.vertical, 100)
                        .frame(width:270, height: 140)
                    }
                    .scrollContentBackground(.hidden)
                }
                NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: backButton,
                    trailing: LargeTitleNavBarTitle(text: "Dictionary")
                )
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
    var body: some View {
        ZStack{
            VStack {
                Text("Definition of \(word)")
                    .font(.headline)
                
                GeometryReader { geometry in
                    ScrollView(.horizontal) {
                        HStack {
                            GenerateImageView(word: word)
                        }
                    }
                    .frame(height: geometry.size.height * 0.3) // Adjust the height as desired
                }
                .overlay(
                    Group { // Use Group as a container for the conditional overlay
                        if let index = dictionary_word.firstIndex(of: word) {
                            VStack(spacing: 12) { // Adjust the spacing between texts as desired
                                SectionBox(title: "Purpose", content: dictionary_purpose[index])
                                    .frame(maxWidth: .infinity) // Adjust the frame size of Purpose section
                                SectionBox(title: "How does it work?", content: dictionary_how_does_it_work[index])
                                    .frame(maxWidth: .infinity) // Adjust the frame size of How does it work? section
                                SectionBox(title: "Example", content: dictionary_example[index])
                                    .frame(maxWidth: .infinity) // Adjust the frame size of Example section
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .top) // Align the overlay content to the top
                            .background(Color.white) // Optional: Add a background color to the overlay content
                            .padding(.bottom, -50) // Add spacing between the overlay and the images
                            .opacity(0.9)
                        }
                    }
                        .scrollContentBackground(.hidden)
                )
            }
        }
        NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
            EmptyView()
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
            RoundedRectangle(cornerRadius: 8)
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

