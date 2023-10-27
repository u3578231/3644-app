
//  ObjectiveView.swift
//  grammar
//
//  Created by Ryan Hui on 25/8/2023.
//

import SwiftUI

struct ObjectiveView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Image("Logo icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding(.top,-140)
                        .scaleEffect(1)
                    VStack{
                        Text("Sparklers aim to provide a user-friendly interface for the general public to broaden their knowledge base")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ObjectiveView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectiveView()
    }
}

