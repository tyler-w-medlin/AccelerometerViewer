import SwiftUI
import CoreMotion

struct ContentView: View {
  // The model that stores the accelerometer data
  @ObservedObject var model = AccelerometerModel(capacity: Constants.capacity) // Pass the capacity argument from the constants file
  
  // Declare the accelerometer manager as a state variable
  @State var accelerometerManager: AccelerometerManager?
  
  // The view body
  var body: some View {
    VStack {
      // The text views that display the instantaneous, maximum and minimum values
      HStack {
        Text("X: \(model.x, specifier: "%.2f") m/s^2")
        Text("Max: \(model.maxX, specifier: "%.2f") m/s^2")
        Text("Min: \(model.minX, specifier: "%.2f") m/s^2")
      }
      .foregroundColor(.red)
      
      HStack {
        Text("Y: \(model.y, specifier: "%.2f") m/s^2")
        Text("Max: \(model.maxY, specifier: "%.2f") m/s^2")
        Text("Min: \(model.minY, specifier: "%.2f") m/s^2")
      }
      .foregroundColor(.green)
      
      HStack {
        Text("Z: \(model.z, specifier: "%.2f") m/s^2")
        Text("Max: \(model.maxZ, specifier: "%.2f") m/s^2")
        Text("Min: \(model.minZ, specifier: "%.2f") m/s^2")
      }
      .foregroundColor(.blue)
      
      // The line chart view that plots the stored data
      LineChartView(data: model.data, frame: CGSize(width: 300, height: 300)) // Pass the frame argument with a fixed size
        .frame(height: 300)
      
      // The bar chart view that shows the instantaneous values
      BarChartView(x: model.x, y: model.y, z: model.z, frame: CGSize(width: 300, height: 200)) // Pass the frame argument with a fixed size
        .frame(height: 200)
    }
    .padding()
    // Initialize the accelerometer manager in the onAppear modifier of the view and pass it the model
    .onAppear {
      accelerometerManager = AccelerometerManager(model: model, frequency: Constants.frequency)
      accelerometerManager?.startUpdates()
    }
    
    // Stop the accelerometer updates in the onDisappear modifier of the view
    .onDisappear {
      accelerometerManager?.stopUpdates()
    }
  }
}
