import SwiftUI

struct AccelerometerView: View {
    // create an instance of the model class
    @StateObject var data = AccelerometerData()
    
    var body: some View {
        VStack {
            // display instantaneous xyz data
            Text("X: \(data.x)")
            Text("Y: \(data.y)")
            Text("Z: \(data.z)")
            
            // display maximum and minimum xyz values
            Text("Max X: \(data.maxX)")
            Text("Min X: \(data.minX)")
            Text("Max Y: \(data.maxY)")
            Text("Min Y: \(data.minY)")
            Text("Max Z: \(data.maxZ)")
            Text("Min Z: \(data.minZ)")
            
            // display line chart with stored data
            LineChart(dataSets: [
                (values: data.xValues.map { $0 }, color: .red), // use Double as y value and red as color
                (values: data.yValues.map { $0 }, color: .green), // use Double as y value and green as color
                (values: data.zValues.map { $0 }, color: .blue) // use Double as y value and blue as color
            ])
            .frame(height: 300) // set a fixed height for the chart
        }
        .padding() // add some padding around the view
        .onAppear {
            // start reading accelerometer data when the view appears
            data.startUpdates()
        }
        .onDisappear {
            // stop reading accelerometer data when the view disappears
            data.stopUpdates()
        }
    }
}
