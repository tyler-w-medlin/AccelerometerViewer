import Foundation
import CoreMotion

class AccelerometerData: ObservableObject {
    // create a motion manager instance
    let motionManager = CMMotionManager()
    
    // create properties to store accelerometer data
    @Published var x = 0.0
    @Published var y = 0.0
    @Published var z = 0.0
    
    @Published var maxX = 0.0
    @Published var minX = 0.0
    @Published var maxY = 0.0
    @Published var minY = 0.0
    @Published var maxZ = 0.0
    @Published var minZ = 0.0
    
    @Published var xValues = [Double]()
    @Published var yValues = [Double]()
    @Published var zValues = [Double]()
    
    // create a method to start reading accelerometer data at 10Hz
    func startUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1 // seconds
            motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                guard let data = data else { return }
                // convert acceleration values from g to m/s^2
                let g = 9.81 // m/s^2
                self.x = data.acceleration.x * g
                self.y = data.acceleration.y * g
                self.z = data.acceleration.z * g
                
                // update maximum and minimum values
                self.maxX = max(self.maxX, self.x)
                self.minX = min(self.minX, self.x)
                self.maxY = max(self.maxY, self.y)
                self.minY = min(self.minY, self.y)
                self.maxZ = max(self.maxZ, self.z)
                self.minZ = min(self.minZ, self.z)
                
                // append the current values to the arrays
                self.xValues.append(self.x)
                self.yValues.append(self.y)
                self.zValues.append(self.z)
                
                // keep only the last 10 seconds of data
                let limit = 100 // 10 seconds * 10 Hz
                if self.xValues.count > limit {
                    self.xValues.removeFirst()
                    self.yValues.removeFirst()
                    self.zValues.removeFirst()
                }
            }
        }
    }
    
    // create a method to stop reading accelerometer data
    func stopUpdates() {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
    }
}
