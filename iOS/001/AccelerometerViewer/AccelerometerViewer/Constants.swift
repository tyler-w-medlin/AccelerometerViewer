import SwiftUI

struct Constants {
  // The colors for the x, y and z axes
  static let xColor = Color.red
  static let yColor = Color.green
  static let zColor = Color.blue
  
  // The line width for the charts
  static let lineWidth: CGFloat = 2
  
  // The bar spacing for the bar chart
  static let barSpacing: CGFloat = 10
  
  // The title font for the charts
  static let titleFont = Font.title.bold()
  
  // The maximum value for the accelerometer data in m/s^2
  static let maxValue: Double = 20
  
  // The frequency of reading the accelerometer data in Hz
  static let frequency: Double = 10
  
  // The capacity of the data array in terms of number of samples
  static let capacity: Int = Int(frequency * 10)
}
