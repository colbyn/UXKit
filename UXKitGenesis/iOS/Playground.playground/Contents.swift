import UIKit
import Foundation

//var greeting = "Hello, playground"
//print("Hello World")

//var objectMap: Dictionary<ObjectIdentifier, AnyObject> = [:]
//
//

let padding = UIEdgeInsets(top: 2, left: 15, bottom: 5, right: 10)

let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))

let result1 = rect.inset(by: padding)
print(result1)
print((result1.minX, result1.minY), (result1.width, result1.height))
print((result1.minX, result1.minY), (result1.maxX, result1.maxY))


extension CGRect {
    public func insetBy(
        origin: 
        by insets: UIEdgeInsets
    ) -> CGRect {
        let minX = self.minX + insets.left
        let minY = self.minY + insets.top
        let maxX = self.maxX - insets.right
        let maxY = self.maxY - insets.bottom
        let width = maxX - minX
        let height = maxY - minY
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
}

print(String.init(repeating: "-", count: 80))

let result2 = rect.devInset(by: padding)
print(result2)
print((result2.minX, result2.minY), (result2.width, result2.height))
print((result2.minX, result2.minY), (result2.maxX, result2.maxY))
