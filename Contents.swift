import Foundation
import UIKit
/*
 Closures are mainly used for two reasons:
 1- Completion blocks
 2- Higher order functions
 */

// simple closure with no paramter and no output
let simpleClosure = {
    print("Hello, World!")
}
simpleClosure()

// simple clousre accept one parameter
let simpleClosureWithParam:(String) -> () = { name in
    print(name)
}
simpleClosureWithParam("Hello, World")

// Closure that returns value
let simpleClosureWithReturn:(String) -> (String) = { name in
    
    let greeting = "Hello, World! " + "Program"
    return greeting
}

let result = simpleClosureWithReturn("Hello, World")
print(result)

// Trailing Closure
func someSimpleFunction(msg:String, someClosure:()->()) {
    print(msg)
    someClosure()
}

someSimpleFunction(msg:"Hello Swift Community!")  {
    print("Hello World! from closure")
}
/*
 In the above program, function someSimpleFunction() accepts a closure as a final parameter. So, while calling the function, instead of passing the closure as an argument, we have used trailing closure.
 */
 /**********************************************/
//AutoClosure
 /*
 1- The main advantage of using autoclosure is that you don't need to wrap the expression in curly braces {} when calling closures.
 2- with auto closure we can't use trailing closure
 */
func someSimpleFunctionAutoClosure(someClosure: @autoclosure ()->(), msg:String) {
    print(msg)
    someClosure()
}

someSimpleFunctionAutoClosure(someClosure: (print("Hello World! from closure")), msg:"Hello Swift Community!")
/************************************/
//capture list
struct Calculator {
    var a: Int
    var b: Int

    var sum: Int {
        return a + b
    }
}

var calculator = Calculator(a: 3, b: 5)

let closure = {
    calculator = Calculator(a: 20, b: 10)

    print("The result is \(calculator.sum)")
}

closure() // Prints "The result is 30"


var calculator2 = Calculator(a: 3, b: 5)

let closure2 = { [calculator2] in
    calculator2 = Calculator(a: 20, b: 10) // 'calculator2' is an immutable capture
    print("The result is \(calculator2.sum)")
}
 closure2() // 'calculator2' is an immutable capture

/***************************************************************/
//strong references && weak reference && unowend

class MyClass {
    var p = 0

    func method() {
        let closure = {
            print("P is \(self.p)")
        }

        closure()
    }
    func weakMethod() {
        let closure = { [weak self] in
            guard let strongSelf = self else { return }
            print("P is \(strongSelf.p)")
        }
        closure()
    }
    func unowndMethod() {
        let closure = { [unowned self] in
            print("P is \(self.p)")
        }
        closure()
    }
    /*
     Since we are using a static UIView method and self doesn’t keep any strong reference of UIView.
     */
    func notNeedRemoveStrongReference() {
        UIView.animate(withDuration: 5, animations: {
            self.method()
        })
    }
}

