//
//  CompareChart.swift
//  AI_learning.swift
//
//  Created by Ryan Hui on 8/11/2023.
//

import Foundation
import SwiftUI
import Charts

var total_sample_no_time_limit = 1000
var total_sample_time_limit_easy = 1000
var total_sample_time_limit_hard = 1000
var Compare_no_time_limit = [50,30,120,200,260,120,220]
var Compare_time_limit_easy = [120, 230, 360, 290]
var Compare_time_limit_hard = [140, 350, 320, 190]
var Compare_no_time_limit_mark = ["0", "0.5", "1", "1.5", "2", "2.5", "3"]
var Compare_time_limit_easy_mark = ["0","1","2","3"]
var Compare_time_limit_hard_mark = ["0","1","2","3"]
struct ChartDataTuple: Identifiable {
    let id = UUID()
    let date: String
    let mark: Double
}
struct ResultView: View {
    @State private var navigateToPlayMenu = false
    @Binding var currentMark: Double
    @Binding var gameplay: String
    @State private var percentile: Double = 0
    let username: String
    var Normalized_no_time_limit: [Double] = Compare_no_time_limit.map { Double($0) / Double(total_sample_no_time_limit) }
    var Normalized_time_limit_easy: [Double] = Compare_time_limit_easy.map { Double($0) / Double(total_sample_time_limit_easy) }
    var Normalized_time_limit_hard: [Double] = Compare_time_limit_hard.map { Double($0) / Double(total_sample_time_limit_hard) }
    private var formattedMark: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: roundedMark)) ?? ""
    }
    private var roundedMark: Double {
        return (currentMark * 10).rounded() / 10
    }
    private var emoji: String {
        if currentMark == 3 {
            return "👍👍"
        } else if currentMark >= 2 && currentMark < 3 {
            return "👍"
        } else {
            return "😢"
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack( spacing: 10){
                        HStack{
                            Text("Result :")
                                .font(.headline)
                                .padding(.leading, 200)
                            Spacer()
                            Text("\(formattedMark)")
                                .padding(.trailing, 100)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text("Comment :")
                                .font(.headline)
                                .padding(.leading, 200)
                            Spacer()
                            Text("\(emoji)")
                                .padding(.trailing, 100)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text("Gameplay :")
                                .font(.headline)
                                .padding(.leading, 200)
                            Spacer()
                            Text("\(gameplay)")
                                .padding(.trailing, 100)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text("You beat :")
                                .font(.headline)
                                .padding(.leading, 200)
                            Spacer()
                            Text("\(String(format: "%.1f", percentile))% opponents")
                                .padding(.trailing, 100)
                                .foregroundColor(.secondary)
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.yellow)
                            .frame(width: 515, height: 140)
                            .padding(.leading, 117)
                    )
                    //                            Text("Number of no time limit samples =\(total_sample_no_time_limit)")
                    //                            Text("Number of time limit easy samples =\(total_sample_time_limit_easy)")
                    //                        Text("Number of time limit hard samples =\(total_sample_time_limit_hard)")
                    //                        Text("Compare_no_time_limit = \(String(describing: Compare_no_time_limit))")
                    //                        Text("Compare_time_limit_easy = \(String(describing: Compare_time_limit_easy))")
                    //                        Text("Compare_time_limit_hard = \(String(describing: Compare_time_limit_hard))")
                    .padding(.top, -150)
                    VStack(spacing: 35){
                        VStack{
                            Text("Opponents' performance in \(gameplay)")
                            Chart(chartData) { tuple in
                                LineMark(
                                    x: .value("X values", tuple.date),
                                    y: .value("Y values", tuple.mark)
                                )
                                .foregroundStyle(Color.blue.gradient)
                            }
                            .chartXAxis {
                                AxisMarks() { _ in
                                    AxisGridLine()
                                    AxisValueLabel()
                                        .foregroundStyle(.red)
                                        .font(.system(size: 20))
                                }
                            }
                            .chartYAxis {
                                AxisMarks() { _ in
                                    AxisGridLine()
                                    AxisValueLabel()
                                        .foregroundStyle(.red)
                                        .font(.system(size: 20))
                                }
                            }
                            .frame(width: 550, height: 200)
                        }
                        .onAppear {
                            if gameplay == "time limit easy" {
                                total_sample_time_limit_easy += 1
                            } else if gameplay == "no time limit" {
                                total_sample_no_time_limit += 1
                            } else if gameplay == "time limit heart attack" {
                                total_sample_time_limit_hard += 1
                            }
                            updateCompareNoTimeLimit()
                            calculatePercentile(formattedMark: formattedMark, gameplay: gameplay)
                        }
                        NavigationLink(destination: PlayMenu(shuffle_question_set: 0, username: username), isActive: $navigateToPlayMenu) {
                            EmptyView()
                        }
                        Button("Menu") {
                            print("Navigating to PlayMenu")
                            navigateToPlayMenu = true
                        }
                        .padding(.bottom, -100)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationViewStyle(StackNavigationViewStyle())
        .animation(.default)
        .navigationTitle("Result")
    }
    private var chartData: [ChartDataTuple] {
        if gameplay == "time limit easy" {
            return zip(Compare_time_limit_easy_mark, Normalized_time_limit_easy).map { (x, y) in
            ChartDataTuple(date: String(x), mark: Double(y))
            }
        } else if gameplay == "no time limit" {
            return zip(Compare_no_time_limit_mark, Normalized_no_time_limit).map { (x, y) in
            ChartDataTuple(date: String(x), mark: Double(y))
            }
        } else if gameplay == "time limit heart attack" {
            return zip(Compare_time_limit_hard_mark, Normalized_time_limit_hard).map { (x, y) in
                ChartDataTuple(date: String(x), mark: Double(y))
            }
        } else {
            return []
        }
    }
    private func calculatePercentile(formattedMark: String, gameplay: String) -> Double {
        var total = 0.0
        var total_sample = 0.0
        var compareArray: [Int] = []
        var compareMarkArray: [String] = []
        if gameplay == "time limit easy" {
            compareArray = Compare_time_limit_easy
            compareMarkArray = Compare_time_limit_easy_mark
            total_sample = Double(total_sample_time_limit_easy)
        } else if gameplay == "no time limit" {
            compareArray = Compare_no_time_limit
            compareMarkArray = Compare_no_time_limit_mark
            total_sample = Double(total_sample_no_time_limit)
        } else if gameplay == "time limit heart attack" {
            compareArray = Compare_time_limit_hard
            compareMarkArray = Compare_time_limit_hard_mark
            total_sample = Double(total_sample_time_limit_hard)
        }
        for (index, mark) in compareMarkArray.enumerated() {
            if let markDouble = Double(mark), let formattedMarkDouble = Double(formattedMark), markDouble >= formattedMarkDouble {
                total += Double(compareArray[index])
            }
        }
        print("percentile =\(1-(total / total_sample))")
        let result = (1 - (total / total_sample)) * 100
        let roundedResult = round(result * 10) / 10
        percentile = roundedResult
        return percentile
    }

    private func updateCompareNoTimeLimit() {
        if gameplay == "time_limit_easy"{
            for (index, mark) in Compare_time_limit_easy_mark.enumerated() {
                if mark == formattedMark {
                    Compare_time_limit_easy[index] += 1
                }
            }
        }
        if gameplay == "no time limit"{
            for (index, mark) in Compare_no_time_limit_mark.enumerated() {
                if mark == formattedMark {
                    Compare_no_time_limit[index] += 1
                }
            }
        }
        if gameplay == "time limit heart attack"{
            for (index, mark) in Compare_time_limit_hard_mark.enumerated() {
                if mark == formattedMark {
                    Compare_time_limit_hard[index] += 1
                }
            }
        }
    }
}
