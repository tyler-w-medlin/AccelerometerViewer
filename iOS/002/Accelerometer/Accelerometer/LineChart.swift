import SwiftUI

// define a custom LineChart view using SwiftUI components
struct LineChart: View {
    // define a type alias for a data set
    typealias DataSet = (values: [Double], color: Color)
    
    // define a property to store the data sets
    let dataSets: [DataSet]
    
    // define a property to store the maximum value of all data sets
    var maxValue: Double {
        dataSets.flatMap { $0.values }.max() ?? 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            // use a ZStack to overlay the lines
            ZStack(alignment: .leading) {
                // loop through each data set using a constant range
                ForEach(0..<dataSets.count, id: \.self) { index in
                    // get the data set at the current index
                    let dataSet = dataSets[index]
                    // create a line shape for each data set
                    LineShape(dataSet: dataSet, maxValue: maxValue)
                        .stroke(dataSet.color, lineWidth: 2) // use the color and width specified in the data set
                        .frame(width: geometry.size.width, height: geometry.size.height) // use the available size of the geometry reader
                        .offset(x: CGFloat(index) * 2, y: 0) // offset each line by 2 points to create a gap between them
                }
            }
        }
    }
}

// define a custom LineShape using SwiftUI Shape protocol
struct LineShape: Shape {
    // define a property to store the data set
    let dataSet: LineChart.DataSet
    
    // define a property to store the maximum value of all data sets
    let maxValue: Double
    
    // define a method to create a path based on the data set and the size of the shape
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // check if the data set is not empty
        guard !dataSet.values.isEmpty else { return path }
        
        // calculate the horizontal and vertical spacing between each point
        let xSpacing = rect.width / CGFloat(dataSet.values.count - 1)
        let ySpacing = rect.height / CGFloat(maxValue)
        
        // move to the first point
        let firstPoint = CGPoint(x: 0, y: rect.height - CGFloat(dataSet.values[0]) * ySpacing)
        path.move(to: firstPoint)
        
        // loop through the remaining points and add a line to each one
        for index in 1..<dataSet.values.count {
            let point = CGPoint(x: CGFloat(index) * xSpacing, y: rect.height - CGFloat(dataSet.values[index]) * ySpacing)
            path.addLine(to: point)
        }
        
        return path
    }
}
