import SwiftUI

struct LineGraph: View {
    let graphData: [GraphDataPoint]
    let graphStyle = GraphStyle()

    var body: some View {
        GeometryReader { geometry in
            let graphWidth = geometry.size.width
            let graphHeight = geometry.size.height
            let xStep = graphWidth / CGFloat(graphData.count - 1)
            let yRange = graphStyle.yMax - graphStyle.yMin
            let yStep = graphHeight / CGFloat(yRange)

            Path { path in
                for i in 0..<graphData.count {
                    let xPosition = CGFloat(i) * xStep
                    let yPosition = CGFloat(graphData[i].x - graphStyle.yMin) * yStep
                    let point = CGPoint(x: xPosition, y: graphHeight - yPosition)
                    if i == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }
            }
            .stroke(graphStyle.xColor, lineWidth: graphStyle.lineWidth)

            Path { path in
                for i in 0..<graphData.count {
                    let xPosition = CGFloat(i) * xStep
                    let yPosition = CGFloat(graphData[i].y - graphStyle.yMin) * yStep
                    let point = CGPoint(x: xPosition, y: graphHeight - yPosition)
                    if i == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }
            }
            .stroke(graphStyle.yColor, lineWidth: graphStyle.lineWidth)

            Path { path in
                for i in 0..<graphData.count {
                    let xPosition = CGFloat(i) * xStep
                    let yPosition = CGFloat(graphData[i].z - graphStyle.yMin) * yStep
                    let point = CGPoint(x: xPosition, y: graphHeight - yPosition)
                    if i == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }
            }
            .stroke(graphStyle.zColor, lineWidth: graphStyle.lineWidth)
        }
    }
}
