import SwiftUI

class AccelerometerModel: ObservableObject {
  // The array that stores the accelerometer data as tuples of (x, y, z)
  @Published var data: [(Double, Double, Double)] = []
  
  // The instantaneous values of x, y and z
  @Published var x: Double = 0
  @Published var y: Double = 0
  @Published var z: Double = 0
  
  // The maximum and minimum values of x, y and z
  @Published var maxX: Double = 0
  @Published var maxY: Double = 0
  @Published var maxZ: Double = 0
  @Published var minX: Double = 0
  @Published var minY: Double = 0
  @Published var minZ: Double = 0
  
  // The capacity of the data array in terms of number of samples
  let capacity: Int
  
  // The initializer that takes the capacity as a parameter
  init(capacity: Int) {
    self.capacity = capacity
  }
  
  // The method that updates the model with new x, y and z values
  func update(x: Double, y: Double, z: Double) {
    // Append the new values to the data array
    data.append((x, y, z))
    
    // Remove the oldest values if the data array exceeds the capacity
    if data.count > capacity {
      data.removeFirst()
    }
    
    // Update the instantaneous values
    self.x = x
    self.y = y
    self.z = z
    
    // Update the maximum and minimum values by iterating over the data array
    maxX = data.map { $0.0 }.max() ?? 0
    maxY = data.map { $0.1 }.max() ?? 0
    maxZ = data.map { $0.2 }.max() ?? 0
    minX = data.map { $0.0 }.min() ?? 0
    minY = data.map { $0.1 }.min() ?? 0
    minZ = data.map { $0.2 }.min() ?? 0
  }
}
