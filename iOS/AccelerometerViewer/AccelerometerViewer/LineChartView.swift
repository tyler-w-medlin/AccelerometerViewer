import SwiftUI

struct LineChartView: View {
  // The data array that contains the accelerometer data as tuples of (x, y, z)
  let data: [(Double, Double, Double)]
  
  // The frame size of the view
  let frame: CGSize
  
  // The computed properties that return the scaled values of x, y and z for each sample
  var scaledXValues: [CGFloat] {
    data.map { CGFloat($0.0 / Constants.maxValue) * frame.height / 2 + frame.height / 2 }
  }
  
  var scaledYValues: [CGFloat] {
    data.map { CGFloat($0.1 / Constants.maxValue) * frame.height / 2 + frame.height / 2 }
  }
  
  var scaledZValues: [CGFloat] {
    data.map { CGFloat($0.2 / Constants.maxValue) * frame.height / 2 + frame.height / 2 }
  }
  
  // The computed properties that return the path for each line
  var xPath: Path {
    Path { path in
      // Check if the data array is not empty
      guard !data.isEmpty else {
        return
      }
      
      // Move to the first point
      path.move(to: CGPoint(x: 0, y: scaledXValues[0]))
      
      // Add a line to each subsequent point
      for i in 1..<data.count {
        path.addLine(to: CGPoint(x: CGFloat(i) * frame.width / CGFloat(data.count - 1), y: scaledXValues[i]))
      }
    }
  }
  
  var yPath: Path {
    Path { path in
      // Check if the data array is not empty
      guard !data.isEmpty else {
        return
      }
      
      // Move to the first point
      path.move(to: CGPoint(x: 0, y: scaledYValues[0]))
      
      // Add a line to each subsequent point
      for i in 1..<data.count {
        path.addLine(to: CGPoint(x: CGFloat(i) * frame.width / CGFloat(data.count - 1), y: scaledYValues[i]))
      }
    }
  }
  
  var zPath: Path {
    Path { path in
      // Check if the data array is not empty
      guard !data.isEmpty else {
        return
      }
      
      // Move to the first point
      path.move(to: CGPoint(x: 0, y: scaledZValues[0]))
      
      // Add a line to each subsequent point
      for i in 1..<data.count {
        path.addLine(to: CGPoint(x: CGFloat(i) * frame.width / CGFloat(data.count - 1), y: scaledZValues[i]))
      }
    }
  }
  
  // The view body
  var body: some View {
    GeometryReader { geometry in
      // Store the frame size in a local variable
      let frame = geometry.size
      
      // Draw the x, y and z lines using the paths and colors from the constants file
      xPath.stroke(Constants.xColor, lineWidth: Constants.lineWidth)
      yPath.stroke(Constants.yColor, lineWidth: Constants.lineWidth)
      zPath.stroke(Constants.zColor, lineWidth: Constants.lineWidth)
      
      // Draw a horizontal line at the middle of the view to indicate zero value
      Path { path in
        path.move(to: CGPoint(x: 0, y: frame.height / 2))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height / 2))
      }
      .stroke(Color.gray, lineWidth: Constants.lineWidth)
    }
    
    // Add some padding to the view
    .padding()
    
    // Add some alignment to the view to center it vertically
    .frame(alignment: .center)
    
    // Add some title to the view using a text view and a font from the constants file
    Text("Line Chart")
      .font(Constants.titleFont)
    
    // Stack the views vertically using a VStack
    VStack {
      
    }
    
      // Add some padding to the view
      .padding()
      
      // Add some labels to the lines using text views and colors from the constants file
      HStack {
        Text("X")
          .foregroundColor(Constants.xColor)
        Spacer()
        Text("Y")
          .foregroundColor(Constants.yColor)
        Spacer()
        Text("Z")
          .foregroundColor(Constants.zColor)
      }
      .padding(.horizontal)
    }
  }
