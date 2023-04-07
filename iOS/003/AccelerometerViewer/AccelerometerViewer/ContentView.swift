import SwiftUI

struct ContentView: View {
    @StateObject private var accelerometerManager = AccelerometerManager()
    private let graphStyle = GraphStyle()

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                LineGraph(graphData: accelerometerManager.accelerometerData.graphData)
                    .padding(.horizontal)
                Spacer()
            }

            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("X:")
                            .foregroundColor(graphStyle.xColor)
                        Text("Y:")
                            .foregroundColor(graphStyle.yColor)
                        Text("Z:")
                            .foregroundColor(graphStyle.zColor)
                    }
                    VStack(alignment: .leading) {
                        Text("\(accelerometerManager.accelerometerData.x, specifier: "%.2f")")
                            .foregroundColor(graphStyle.xColor)
                        Text("\(accelerometerManager.accelerometerData.y, specifier: "%.2f")")
                            .foregroundColor(graphStyle.yColor)
                        Text("\(accelerometerManager.accelerometerData.z, specifier: "%.2f")")
                            .foregroundColor(graphStyle.zColor)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Max X:")
                            .foregroundColor(graphStyle.xColor)
                        Text("Max Y:")
                            .foregroundColor(graphStyle.yColor)
                        Text("Max Z:")
                            .foregroundColor(graphStyle.zColor)
                    }
                    VStack(alignment: .leading) {
                        Text("\(accelerometerManager.accelerometerData.maxX, specifier: "%.2f")")
                            .foregroundColor(graphStyle.xColor)
                        Text("\(accelerometerManager.accelerometerData.maxY, specifier: "%.2f")")
                            .foregroundColor(graphStyle.yColor)
                        Text("\(accelerometerManager.accelerometerData.maxZ, specifier: "%.2f")")
                            .foregroundColor(graphStyle.zColor)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Min X:")
                            .foregroundColor(graphStyle.xColor)
                        Text("Min Y:")
                            .foregroundColor(graphStyle.yColor)
                        Text("Min Z:")
                            .foregroundColor(graphStyle.zColor)
                    }
                    VStack(alignment: .leading) {
                        Text("\(accelerometerManager.accelerometerData.minX, specifier: "%.2f")")
                            .foregroundColor(graphStyle.xColor)
                        Text("\(accelerometerManager.accelerometerData.minY, specifier: "%.2f")")
                            .foregroundColor(graphStyle.yColor)
                        Text("\(accelerometerManager.accelerometerData.minZ, specifier: "%.2f")")
                            .foregroundColor(graphStyle.zColor)
                    }
                }
                .padding()
                .font(.system(size: 14, design: .monospaced)) // Adjust the font size and use a monospaced font

                Text("Units: m/s²") // Add a label for the units
                    .font(.system(size: 12, design: .monospaced))
                    .padding(.bottom)

                Spacer()
            }
        }
        .onAppear {
            accelerometerManager.startUpdates()
        }
        .onDisappear {
            accelerometerManager.stopUpdates()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
