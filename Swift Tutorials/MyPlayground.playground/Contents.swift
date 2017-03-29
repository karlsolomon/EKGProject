//: Playground - noun: a place where people can play

import UIKit

//: Variables
var mutableString = "Hello, playground"
var mutableString2 : String = "Like TypeCasting, but not"
let immutableString = "Immutable"

let 😎 = "Cool Guy"
let coolGuy: Character = "😎"

let integer: Int = -1
let unsignedInt: UInt = 1_234_567_890 // underscore separate long numbers
let double = 1.123
let float: Float = 1.123456
Double(integer) * Double(float) * double
let pi = Double.pi
pi.rounded(.up)
let binaryTen = 0b1010
let octalTen = 0o12
let hexadecimalTen = 0xA
let twelveMil = 1.2e7
let thisIsABool = true
let alsoABool: Bool = false
let toupleRGB = (0,128,255)

typealias Code = UInt8
let whiteRGB = (Code.max, Code.max, Code.max)
let blackRGB = (Code.min, Code.min, Code.min)

var wordsOfWisdom: String
wordsOfWisdom = "Let it be"

var one,two,three: Int

one = 1
two = 2
three = 3

//: Strings
var optionalString: String?
optionalString = ""
optionalString?.isEmpty
optionalString == nil
optionalString = "Luck favors the prepared"
print(optionalString!)
let definitelyAString = optionalString!

let letterA: Character = "\u{61}" //unicode 61
let letterAWithAcuteCircled: Character = "\u{61}\u{301}\u{20DD}" //http://unicode-table.com

let quote = "version 1"
var newQuote = quote
newQuote = "version 2"
print(quote)    // unchanged

let shape = "circle"
let radius = 5.0
let area = pi*radius*radius
print("The area of a \(shape) with a radius of \(radius) is \(area)")

quote.characters.count
newQuote.isEmpty
"lower".uppercased()
"upper".lowercased()

optionalString?.hasPrefix("Luck")
quote.hasSuffix("1")
newQuote.append("Lel")
String(repeating: "💩", count: 5)


import Foundation
let verse1 = "eat eat eat apples bananas"
let verse2 = verse1.replacingOccurrences(of: "eat", with: "ate")
    .replacingOccurrences(of: "ap", with: "ay-")
    .replacingOccurrences(of: "bananas", with: "B.A.N.A.N.A.S")
print(verse1, verse2, separator: "\n")

//: Collections
//Arrays
var threeStooges = ["Moe", "Larry", "Curly"] //zero-indexed
var inningScores: [Int]
inningScores = []
var testScores = [Double]()
var quizScores: Array<Double> = []
var counters = Array(repeating: 0, count: 5)
var averageScores = [Float](repeating: 0.0, count:5)
var optionalArray: [Int]?
var arrayOfOptionals: [Int?] = [nil, 1, nil, 2]
var optionalArrayOfOptionals: [Int?]?
var arryOfAny: [Any] = [1,2.0, three, "four"]

threeStooges.count
threeStooges.contains("Moe")
let larry = threeStooges[1]
threeStooges[1] = "Jerome (\"Curly\")"
let moe = threeStooges.first!
let threeStoogesSorted = threeStooges.sorted()

threeStooges.sort()
threeStooges.append("Shemp")
threeStooges.append(contentsOf: ["Joe"])
threeStooges.insert("Abbott", at: 0)
let notAStooge = threeStooges.removeFirst()
let curlyJoe = threeStooges.removeLast()
let shemp = threeStooges.remove(at: 3)


//Dictionaries
var stockPrices = ["AAPL": 114.92, "GOOG": 768.88]
var birthYears: [String:Int] = [:]
var raceResults = Dictionary<Int, String>()
raceResults[1] = "Dylan Sikaddour"
raceResults[2] = "Kyle Goncalves"
let oldValue = raceResults.updateValue("Karl Solomon", forKey: 1)
let removedValue = raceResults.removeValue(forKey: 2)

//Sets
var teachers = Set<String>()
var staff: Set<String> = []
var students: Set = [1,2,3,4,1]
students.contains(1)
let indexof1 = students.index(of: 1)
students[indexof1!]
students.insert(90)

//Math
pow(2,8)
let y = 9.0
y.squareRoot()


//: Control Flow
//For
let numbers = [1,2,3]
for i in numbers {
    // for iter = 0..numbers.length
}
for var i in numbers {
    //foreach i in numbers
}
let scores = ["Scott": 80, "Lori":90]
for (player,score) in scores {}
for char in "SWIFT".characters {}
for i in 1...3 {}
for i in 2...10 where i % 2 == 0 {
    print(i)
}
for i in stride(from: 2, to: 10, by: 2) {}
for i in stride(from: 2, through: 10, by: 2){}

//While
while arc4random_uniform(10) + 1 < 10 {
    print(".", terminator:"")
}
repeat{
} while arc4random_uniform(10) + 1 < 10 // do-while

//If
let testScore = arc4random_uniform(50) + 51
if testScore > 90 {
    print("Great Job!")
} else {
    print("Could do better")
}
if #available(iOS 10, *) {
    // do ios10 junk
} else {
    //earlier API
}

//Optional Binding
var firstName: String? = "Betty"
var lastName: String? = "Gardner"
if let firstName = firstName {
    print("Hello, \(firstName)")
} else {
    print("Welcome, guest!")
}
if let firstName = firstName, var lastName = lastName {
    lastName = lastName.uppercased()
    print("Hello, my name is \(firstName) \(lastName)")
}

//Guard Statements
let riders: [(name: String, heightInches: Int)]
riders = [
    ("Charlotte", 46),
    ("Laura", 50),
    ("Minnie", 42),
]
for rider in riders {
    guard rider.heightInches >= 44 else {
        print("\(rider.name) is NOT tall enough")
        continue
    }
    print("\(rider.name) is tall enough")
}
func updateSignFor(lifeGuardOnDuty: String?) {
    guard let lifeGuard = lifeGuardOnDuty else {
        print("No lifeguard on duty. Swim @ your own risk")
        return
    }
    print("Lifeguard on duty: \(lifeGuard)")
}

updateSignFor(lifeGuardOnDuty: nil)
updateSignFor(lifeGuardOnDuty: "Tiny Rick")


//: Functions

func printThis(_ hidden: String, name internalName: String) {
    print(hidden , internalName)
}
printThis("Hello", name: "Karl")

func add(_ a: Int, _ b: Int) -> Int {
    return a+b
}
print(add(4,6))

func add(_ ints: Int...) -> Int {   // variable inputs
    return ints.reduce(0, +)
}
print(add(2,4,6,8))

func apply(extraCredit: Double, score outScore: inout Double) {
    outScore += extraCredit
}
var myScore = 76.0
apply(extraCredit: 4, score: &myScore)
print(myScore)

//Overload methods
func processInput(input: String){}
func processInput(int: Int){}
func processInput(input: Int){}
func processInput(input: Int) -> String {
    return "\(input)"
}

//Overload Operator
func ~=(integer: Int, double: Double) -> Bool {
    return integer == Int(double)
}

func ~=(integer: Int, string: String) -> Bool {
    return "\(integer)" == string
}

//Custom Operators
infix operator <==> : ComparisonPrecedence
prefix operator ++
postfix operator ++
prefix operator --
postfix operator --

precedencegroup ExponentPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left

}
infix operator ** : ExponentPrecedence
infix operator -><- : DefaultPrecedence

func <==>(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
let pointA = CGPoint(x: 5, y: 5)
let pointB = CGPoint(x: 5, y: 6)
pointA <==> pointB

func **(base: Int, exponent: Int) -> Int {
    var result = 1
    var exp = exponent
    while(exp > 0) {
        result *= base
        exp -= 1
    }
    return result
}
2**9

// Error Handling
public func simulatedErrorDidOccur() -> Bool {
    return arc4random_uniform(2) == 1
}
let errorA = simulatedErrorDidOccur()
let errorB = simulatedErrorDidOccur()

enum E: Error {
    case a
    case b(function: String, line: Int)
}

func performAction() throws {
    guard errorA == false else {
        print("ErrorB")
        throw E.a
    }
    guard errorB == false else {
        print("ErrorB")
        throw E.b(function: #function, line: #line)
    }
    print("No Error")
}
do {
    try performAction()
    print("No Error Occured")
} catch E.a {
    print("Error A encountered")
} catch let E.b(function, line) {
    print("Error B encountered at func: \(function), line: \(line)")
}

// Closures
let names = ["Scott", "Lori", "Charlotte", "Betty", "Stella", "Isabella", "Lilith"]
let namesBeginningWithS = names.filter({ (name: String) -> Bool in // in = body of enclosure is next
    return name.lowercased().characters.first! == "s"
})
let namesIncludingAnE = names.filter({
    return $0.lowercased().characters.contains("e")
})

names.sorted(by: >)
print(names)
let nestedArray = [[1,2,3], [4,5,6], [7,8,9]]
let flattenedArray = nestedArray.flatMap{ $0 }
print(flattenedArray)

let randomName: String = {
    let randomIndex = Int(arc4random_uniform(UInt32 (names.count)))
    return names[randomIndex]
}()

let helloSayer = { print("Hello world!")}
helloSayer()
let randomNameGetter: () -> String = {
    let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
    return names[randomIndex]
}
randomNameGetter()
func execute(_ closure: @autoclosure () -> Void) {
    closure()
}
execute(print("Hello, again"))

func simulateServerResponse(_ closure: @escaping () -> String) {
    let delay = DispatchTime.now() + .seconds(5)
    DispatchQueue.main.asyncAfter(deadline: delay) {
        print(closure())
    }
    print(randomNameGetter())
}

let printAfterDelay = {
    let delay = DispatchTime.now() + .seconds(5)
    DispatchQueue.main.asyncAfter(deadline: delay) {
        print("Printed After Delay")
    }
}

func execute(_ closure: () -> Void) {
    printAfterDelay()
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//execute(printAfterDelay)
simulateServerResponse(randomNameGetter)





