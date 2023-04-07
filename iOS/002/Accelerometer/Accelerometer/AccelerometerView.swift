import SwiftUI
import CoreMotion

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
            LineChart(data: [data.xValues, data.yValues, data.zValues], colors: [.red, .green, .blue])
        }
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
