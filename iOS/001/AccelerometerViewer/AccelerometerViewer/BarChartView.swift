import SwiftUI

struct BarChartView: View {
  // The instantaneous values of x, y and z
  let x: Double
  let y: Double
  let z: Double
  
  // The frame size of the view
  let frame: CGSize
  
  // The computed properties that return the scaled heights of the bars for x, y and z
  var scaledXHeight: CGFloat {
    CGFloat(x / Constants.maxValue) * frame.height / 2
  }
  
  var scaledYHeight: CGFloat {
    CGFloat(y / Constants.maxValue) * frame.height / 2
  }
  
  var scaledZHeight: CGFloat {
    CGFloat(z / Constants.maxValue) * frame.height / 2
  }
  
  // The view body
    var body: some View {
        GeometryReader { geometry in
            // Store the frame size in a local variable
            let frame = geometry.size
            
            // Draw the bars for x, y and z using rectangles and colors from the constants file
            Rectangle()
                .fill(Constants.xColor)
                .frame(width: frame.width / 3 - Constants.barSpacing,
                       height: abs(scaledXHeight))
                .offset(x: -frame.width / 3 + Constants.barSpacing / 2,
                        y: scaledXHeight > 0 ? -frame.height / 2 + scaledXHeight / 2 : -frame.height / 2 + abs(scaledXHeight) / 2)
            
            Rectangle()
                .fill(Constants.yColor)
                .frame(width: frame.width / 3 - Constants.barSpacing,
                       height: abs(scaledYHeight))
                .offset(x: Constants.barSpacing / 2,
                        y: scaledYHeight > 0 ? -frame.height / 2 + scaledYHeight / 2 : -frame.height / 2 + abs(scaledYHeight) / 2)
            
            Rectangle()
                .fill(Constants.zColor)
                .frame(width: frame.width / 3 - Constants.barSpacing,
                       height: abs(scaledZHeight))
                .offset(x: frame.width / 3 + Constants.barSpacing / 2,
                        y: scaledZHeight > 0 ? -frame.height / 2 + scaledZHeight / 2 : -frame.height / 2 + abs(scaledZHeight) / 2)
            
            // Draw a horizontal line at the middle of the view to indicate zero value
            Path { path in
                path.move(to: CGPoint(x: 0, y: frame.height / 2))
                path.addLine(to: CGPoint(x: frame.width, y: frame.height / 2))
            }
            .stroke(Color.gray, lineWidth: Constants.lineWidth)
        }
        
        // Add some padding to the view
        .padding()
        
        // Add some labels to the bars using text views and colors from the constants file
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
        
        // Add some labels to the values using text views and colors from the constants file
        HStack {
            Text("\(x, specifier: "%.2f") m/s^2")
                .foregroundColor(Constants.xColor)
            Spacer()
            Text("\(y, specifier: "%.2f") m/s^2")
                .foregroundColor(Constants.yColor)
            Spacer()
            Text("\(z, specifier: "%.2f") m/s^2")
                .foregroundColor(Constants.zColor)
        }
        .padding(.horizontal)
        
        // Add some labels to the maximum and minimum values using text views and colors from the constants file
        HStack {
            Text("Max: \(Constants.maxValue) m/s^2")
                .foregroundColor(Color.gray)
            Spacer()
            Text("Min: \(-Constants.maxValue) m/s^2")
                .foregroundColor(Color.gray)
        }
        .padding(.horizontal)
        
        // Add some labels to the zero value using text views and colors from the constants file
        HStack {
            Spacer()
            Text("0 m/s^2")
                .foregroundColor(Color.gray)
            Spacer()
        }
        .padding(.horizontal)
        
        // Stack the views vertically using a VStack
        VStack {
            
        }
        
        // Add some padding to the view
        .padding()
        
        // Add some title to the view using a text view and a font from the constants file
        Text("Bar Chart")
          .font(Constants.titleFont)
      }
    }
