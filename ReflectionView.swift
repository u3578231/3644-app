
//  ReflectionView.swift
//  grammar
//
//  Created by Ryan Hui on 2/9/2023.
//

import SwiftUI

struct ReflectionView: View {
    let username: String
    let userIndex: Int
    let index: Int
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Review")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding()
                
                ScrollView {
                    VStack {
                        ForEach(userArray[userIndex].wrong_q_2D_array[index].indices, id: \.self) { questionIndex in
                            VStack {
                                Section(header: Text("Wrong Question \(questionIndex + 1)")) {
                                    VStack {
                                        let element = userArray[userIndex].wrong_q_2D_array[index][questionIndex]
                                        VStack {
                                            Text(questions[element])
                                            Text(correctans[element])
                                        }
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 20)
                                        .border(Color.black, width: 2)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 110)
            }
            
            .onAppear {
                let wrong_questions = userArray[userIndex].wrong_q_2D_array[index]
                print(wrong_questions)
            }
        }
    }
}


struct ReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
