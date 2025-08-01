/*:
## Exercise - Create Functions

 Write a function called `introduceMyself` that prints a brief introduction of yourself. Call the function and observe the printout.
 */
func introduceMyself(){
    print("Myself Ghanshyam Agrawal and I am 20 years old. Currently pursuing my bachelor in computer science")
    
}
introduceMyself()
//:  Write a function called `magicEightBall` that generates a random number and then uses either a switch statement or if-else-if statements to print different responses based on the random number generated. `let randomNum = Int.random(in: 0...4)` will generate a random number from 0 to 4, after which you can print different phrases corresponding to the number generated. Call the function multiple times and observe the different printouts.
import Foundation

func magicEightBall(){
    let random = Int.random(in: 0...4)
    if random == 0 {
        print("Its a 0")
    }
    else if random == 1 {
        print("Its a 1")
    }
    else if random == 2 {
        print("Its a 2")
    }
    else if random == 3 {
        print("Its a 3")
    }
    else {
        print("Its a 4")
    }
    
}
magicEightBall()
/*:
page 1 of 6  |  [Next: App Exercise - A Functioning App](@next)
 */
