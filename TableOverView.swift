//
//  File.swift
//  AI_learning.swift
//
//  Created by Ryan Hui on 1/11/2023.
//
import SwiftUI


struct TextRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}


