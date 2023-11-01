//chart view
import SwiftUI
import Charts
struct ChartView: View {
    let username: String
    
    struct ChartData: Identifiable {
        var id = UUID()
        var date: String
        var mark: Double
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(username + " mark history")
                        .font(.title)
                    Text("For more details, look at the overview")
                    Spacer()
                    if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
                        let dateArray = userArray[userIndex].dateArray.map { formatDate($0) }
                        let markArray = userArray[userIndex].MarkArray.map { String($0) }
                        let chartData = Array(zip(dateArray, markArray)).map { ChartData(date: $0.0, mark: Double($0.1) ?? 0) }
                        let yValues = chartData.map { $0.mark }
                        let mean = yValues.reduce(0, +) / Double(yValues.count)
                        let squaredDeviations = yValues.map { pow($0 - mean, 2) }
                        let sumOfSquaredDeviations = squaredDeviations.reduce(0, +)
                        let standardDeviation = sqrt(sumOfSquaredDeviations / Double(yValues.count))
                        if dateArray.isEmpty {
                            Text("No graph available!")
                                .foregroundColor(.red)
                                .font(.title2)
                                .padding()
                        } else {
                            VStack(alignment: .leading){
                                Text("Number of times game modes played: \(userArray[userIndex].dateArray.count)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading) // Expand the frame to fill the available width
                                    .padding(.vertical, 20)
                                    .padding(.leading, 16)
                                Text("Mean: \(mean)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading) // Expand the frame to fill the available width
                                    .padding(.vertical, 20)
                                    .padding(.leading, 16)
                                Text("Standard deviation: \(standardDeviation)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading) // Expand the frame to fill the available width
                                    .padding(.vertical, 20)
                                    .padding(.leading, 16)
                            }
                            .padding(.top, -250)
                            ScrollView(.horizontal){
                                VStack {
                                    Text("Mark History")
                                        .font(.title2)
                                        .bold()
                                    Chart(chartData) { tuple in
                                        LineMark(
                                            x: .value("X values", tuple.date),
                                            y: .value("Y values", tuple.mark)
                                        )
                                        .foregroundStyle(Color.blue.gradient)
                                    }
                                    .chartYAxis{
                                        AxisMarks(position: .trailing, values: [0, 1, 2, 3, 4]) { _ in
                                            AxisGridLine()
                                            AxisValueLabel()
                                                .foregroundStyle(.red)
                                                .font(.system(size: 20))
                                        }
                                    }
                                    .chartXAxis{
                                        AxisMarks(){ _ in
                                            AxisGridLine()
                                            AxisValueLabel()
                                                .foregroundStyle(.red)
                                                .font(.system(size: 12))
                                        }
                                    }
                                    .frame(width: CGFloat(5 * dateArray.count - 4) * 28, height: 300)
                                }
                            }
                            .padding(.bottom, 200)
                        }
                    } else {
                        Text("No graph available!")
                            .foregroundColor(.red)
                            .font(.title2)
                            .padding()
                    }
                    Spacer()
                    Spacer()
                    
                }
            }
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MM-dd HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    private func calculateChartWidth(geometry: GeometryProxy, dataCount: Int) -> CGFloat {
        let availableWidth = geometry.size.width
        let minimumSeparation: CGFloat = 10
        
        let totalSeparation = CGFloat(dataCount - 1) * minimumSeparation
        let chartWidth = availableWidth - totalSeparation
        
        return chartWidth
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
