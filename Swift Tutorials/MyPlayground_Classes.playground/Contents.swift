//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Vehicle {
    static var count = 0
    var passengerCapacity = 4
    let zeroTo60: Float // literal
    var color: UIColor
    init(passengerCapacity: Int, zeroTo60: Float, color: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)) {
        self.passengerCapacity = passengerCapacity
        self.zeroTo60 = zeroTo60
        self.color = color
        Vehicle.count += 1
    }
    convenience init(zeroTo60: Float) {
        self.init(passengerCapacity: 4, zeroTo60: zeroTo60)
    }
    convenience init() {
        self.init(zeroTo60: 6.0)
    }
    deinit {
        Vehicle.count -= 1
    }
    
    func start() {
        fatalError("Abstract")
    }
    static func printCount() {
        print("\(count)")
    }
    
    
}

class ElectricVehicle : Vehicle, CustomStringConvertible {
    let rangePerCharge: Int
    init (passengers: Int, zeroTo60: Float, rangePerCharge: Int) {
        self.rangePerCharge = rangePerCharge
        super.init(passengerCapacity: passengers, zeroTo60: zeroTo60)
    }
    convenience init() {
        self.init(passengers: 4, zeroTo60: 6.0, rangePerCharge: 215)
    }
    override func start() {
        print("silence")
    }
    public var description: String {
        return "\(ElectricVehicle.self):\n\tPassengers: \(passengerCapacity)\n\t0 to 60: \(zeroTo60) seconds\n\tRange: \(rangePerCharge) miles"
    }
}


let teslaModelS = ElectricVehicle(passengers: 4, zeroTo60: 2.5, rangePerCharge: 315)
var teslaModel3: ElectricVehicle? = ElectricVehicle()
teslaModel3 = nil
ElectricVehicle.count
let p100d = teslaModelS
p100d.color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
teslaModelS.color
teslaModelS.start()
print(teslaModelS)
Vehicle.printCount()

// Enumerations
enum Direction {
    case up
    case down
    case left
    case right
}
let direction: Direction = .up
var direction2 = Direction.up

enum Proverb : String {
    case fortune = "Fortune"
    case late = "Late"
    case practice = "Practice"
}

enum ClockPosition : Double {
    case one = 1
    case oneThirty = 1.5
    case two = 2, three, four, five, six, seven, eight, nine, ten, eleven, twelve
}
print(ClockPosition.six.rawValue)

struct Coordinate3D : Hashable {
    let x: Int
    let y: Int
    let z: Int
    var label: String
    
    init(x:Int, y:Int, z:Int, label: String? = "(unlabeled)") {
        self.x = x
        self.y = y
        self.z = z
        self.label = label!
    }
    
    var hashValue: Int {
        return "\(label)-\(x)-\(y)-\(z)".hashValue
    }
    
    static func ==(left: Coordinate3D, right: Coordinate3D) -> Bool {
        return (left.x, left.y, left.z, left.label) == (right.x, right.y, right.z, right.label)
    }
}
let origin = Coordinate3D(x: 0, y: 0, z: 0, label: "Origin")
var destination = Coordinate3D(x: 10, y: 10, z: 10, label: "Destination")
let setOfCoordinate3Ds : Set = [origin, destination]
origin == destination