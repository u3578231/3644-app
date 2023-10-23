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
        ZStack{
            Image("background") // Set the desired image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(username + " mark history")
                    .font(.title)
                Spacer()
                if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
                    let dateArray = userArray[userIndex].dateArray.map { String($0) }
                    let markArray = userArray[userIndex].MarkArray.map { String($0) }
                    
                    let chartData = Array(zip(dateArray, markArray)).map { ChartData(date: $0.0, mark: Double($0.1) ?? 0) }
                    ScrollView(.horizontal) {
                        VStack {
                            Text("Mark History")
                                .font(.title2)
                                .padding()
                            Chart(chartData) { tuple in
                                LineMark(
                                    x: .value("X values", tuple.date),
                                    y: .value("Y values", tuple.mark)
                                )
                            }
                            .frame(width: CGFloat(dateArray.count) * 200, height: 400)
                            
                        }
                    }
                }
                Spacer()
                Text("For more details, look at overview")
                    .padding(.bottom, 50)
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
