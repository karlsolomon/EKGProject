//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var hello = "Hello,"; var playground = "world"

for i in 0..<64 {
    var point = sin(Double(i) * 100)
}

print(str)

NSLog(str)

print(hello, playground)

print(hello, playground, separator:"_", terminator:"")

print("...")

print("\(hello) viewer!")

print("1 + 1 = \(1+1)")


func printLiteralExpressions() {
    print("Function: \(#function)")
    print("File: \(#file)")
    print("Line: \(#line)")
    print("Column: \(#column)")
}

printLiteralExpressions()

// MARK: This is viewable in the jump bar

//TODO: Do this

// FIXME: FixThis

// MARK: - Add a separator above this

// Single-line comment

func someFunction() {
    /* Multi-line comment
     nested in a function
     */
    
    //https://goo.gl/4AOSi9 for Markup Overview
    
}

//: Single-line delimiter
/*: Text on this line is not displayed in rendered markup
    ##  Header 2
    ### Header 3
    > Block note
 
 
    * **Bold**
    * Item2
    1. Todo
    2. Todo1
 
    ----
 */







struct Car {
    let model: String   //instantiate where ":" is type assignment of car Constructor
    func drive() {
        print("Vroooom!")
    }
}

struct Driver {
    let cars: [Car] // cars is an array of type Car
}

let tesla = Car(model: "S P100D")   // instantiate Class
let jaguar = Car(model: "XE S")
let icon = Car(model: "FJ44")
let scott = Driver(cars: [tesla, jaguar, icon])

scott
    .cars
    .first?
    .drive()




// Data Types
/*
	Value: 
		Structures: Primitive, String, Array, Dictionary, Tuple
		Enum: Optionals (?)
	Reference: 
		Classes:
		Functions/Closures:
 */
