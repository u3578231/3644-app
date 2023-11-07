
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
                    .padding(.top, 200)
                
                VStack(spacing: 10){
                    HStack() {
                        Text("Date of gamemode played")
                            .font(.headline)
                            .padding(.leading, 200)
                        Spacer()
                        Text("\(userArray[userIndex].dateArray[index])")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.trailing, 84)
                    }
                    HStack {
                        Text("Gamemode")
                            .font(.headline)
                            .padding(.leading, 200)
                        Spacer()
                        Text("\(userArray[userIndex].playermodeArray[index])")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.trailing, 84)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.yellow)
                        .frame(width: 540, height: 109)
                        .padding(.leading, 117)
                )
                ScrollView {
                    VStack {
                        ForEach(userArray[userIndex].wrong_q_2D_array[index].indices, id: \.self) { questionIndex in
                            VStack (spacing: 1){
                                Section(header: Text("Wrong Question \(questionIndex + 1)")
                                    .foregroundColor(.red)
                                    .bold())  {
                                    VStack {
                                        let element = userArray[userIndex].wrong_q_2D_array[index][questionIndex]
                                        VStack {
                                            Text("Question:")
                                                .font(.headline)
                                                .foregroundColor(.green)
                                            Text(questions[element])
                                            Text("Correct ans:")
                                                .font(.headline)
                                                .foregroundColor(.green)
                                            Text(correctans[element])
                                        }
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 12)
                                        .border(Color.black, width: 2)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                    }
                                    .frame(width: 700, height: 200)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 100)
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
