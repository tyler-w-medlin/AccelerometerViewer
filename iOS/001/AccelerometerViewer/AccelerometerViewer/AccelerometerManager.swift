import CoreMotion

class AccelerometerManager {
  // The motion manager that provides the accelerometer data
  let motionManager = CMMotionManager()
  
  // The model that stores the accelerometer data
  let model: AccelerometerModel
  
  // The frequency of reading the accelerometer data in Hz
  let frequency: Double
  
  // The initializer that takes the model and the frequency as parameters
  init(model: AccelerometerModel, frequency: Double) {
    self.model = model
    self.frequency = frequency
  }
  
    // The method that starts the accelerometer updates
    func startUpdates() {
        // Check if the accelerometer is available
        guard motionManager.isAccelerometerAvailable else {
          print("Accelerometer is not available")
          return
        }
        
        // Set the accelerometer update interval to match the frequency
        motionManager.accelerometerUpdateInterval = 1 / frequency
        
        // Start the accelerometer updates using a handler closure
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in // Use a capture list to avoid strong reference cycles
          // Check if there is an error
          if let error = error {
            print("Error: \(error.localizedDescription)")
            return
          }
          
          // Check if there is data
          if let data = data {
            // Update the model with the data using self explicitly
            self?.model.update(x: data.acceleration.x * 9.81,
                         y: data.acceleration.y * 9.81,
                         z: data.acceleration.z * 9.81)
          }
        }
      }
    
    // The method that stops the accelerometer updates
    func stopUpdates() {
      // Check if the accelerometer is active
      guard motionManager.isAccelerometerActive else {
        print("Accelerometer is not active")
        return
      }
      
      // Stop the accelerometer updates
      motionManager.stopAccelerometerUpdates()
    }
}
