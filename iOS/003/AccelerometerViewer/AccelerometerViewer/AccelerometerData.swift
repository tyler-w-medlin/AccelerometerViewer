import Foundation

class AccelerometerData: ObservableObject {
    @Published var graphData: [GraphDataPoint] = []

    private let maxDataPoints: Int = 100 // 10 seconds of data at 10Hz

    var x: Double {
        graphData.last?.x ?? 0
    }

    var y: Double {
        graphData.last?.y ?? 0
    }

    var z: Double {
        graphData.last?.z ?? 0
    }

    var maxX: Double {
        graphData.map { $0.x }.max() ?? 0
    }

    var maxY: Double {
        graphData.map { $0.y }.max() ?? 0
    }

    var maxZ: Double {
        graphData.map { $0.z }.max() ?? 0
    }

    var minX: Double {
        graphData.map { $0.x }.min() ?? 0
    }

    var minY: Double {
        graphData.map { $0.y }.min() ?? 0
    }

    var minZ: Double {
        graphData.map { $0.z }.min() ?? 0
    }

    func updateData(x: Double, y: Double, z: Double) {
        let dataPoint = GraphDataPoint(x: x, y: y, z: z)
        graphData.append(dataPoint)

        if graphData.count > maxDataPoints {
            graphData.removeFirst()
        }
    }

    func resetData() {
        graphData.removeAll()
    }
}
