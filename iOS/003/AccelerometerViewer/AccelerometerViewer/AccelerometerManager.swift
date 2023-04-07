import Foundation
import CoreMotion

class AccelerometerManager: ObservableObject {
    @Published var accelerometerData = AccelerometerData()
    private let motionManager = CMMotionManager()
    private let updateInterval = 0.1 // 10Hz

    func startUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = updateInterval
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] (data, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    let x = data.acceleration.x * 9.81
                    let y = data.acceleration.y * 9.81
                    let z = data.acceleration.z * 9.81
                    self?.accelerometerData.updateData(x: x, y: y, z: z)
                    self?.objectWillChange.send() // Notify subscribers of changes
                }
            }
        } else {
            print("Accelerometer not available.")
        }
    }

    func stopUpdates() {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
    }
}
