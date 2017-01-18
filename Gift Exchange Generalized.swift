//
//  Gift Exchange Generalized.swift
//  
//
//  Created by Ian Thomas on 1/18/17.
//
//

import UIKit

let listOfFamilyMembers =
    ["Grandfather",
     "Mom",
     "Dad",
     "Uncle Iain",
     "Uncle Kristian",
     "Uncle Alec",
     "Molly",
     "Mary",
     "Paul",
     "Robert"]


var giftReceiver = listOfFamilyMembers
var giver1 = listOfFamilyMembers
var giver2 = listOfFamilyMembers

var giftParing = (receiver: "", firstGiver: "", secondGiver: "")


var finalPairings = [giftParing]

func areNamesDifferent (person1: String, person2: String) -> Bool {
    return person1 != person2
}

func getRandomInteger(max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max)))
}

func findAGiver(person: String, giverList: Array<String>) -> String {
    
    var personFound = false
    var possiblePerson = ""
    
    while personFound == false {
        
        let index = getRandomInteger(max: giverList.count)
        possiblePerson = giverList[index]
        
        if areNamesDifferent(person1: person, person2: possiblePerson) {
            personFound = true
        }
    }
    return possiblePerson
}

func findASecondGiver(person: String, secondGiverList: Array<String>, firstGiver: String) -> String {
    
    var secondPersonFound = false
    var secondPossiblePerson = ""
    
    while secondPersonFound == false {
        
        let index = getRandomInteger(max: secondGiverList.count)
        secondPossiblePerson = secondGiverList[index]
        
        if areNamesDifferent(person1: person, person2: secondPossiblePerson)  {
            
            if areNamesDifferent(person1: secondPossiblePerson, person2: firstGiver) {
                secondPersonFound = true
            }
        }
    }
    return secondPossiblePerson
}

func performPairings () {
    
    for person in giftReceiver {
        
        giftParing.receiver = person
        
        
        let firstPerson = findAGiver(person: giftParing.receiver, giverList: giver1)
        // remove the person from the list
        giver1 = giver1.filter{$0 != firstPerson }
        giftParing.firstGiver = firstPerson
        
        
        let secondPerson = findASecondGiver(person: giftParing.receiver, secondGiverList: giver2, firstGiver: giftParing.firstGiver)
        giver2 = giver2.filter{$0 != secondPerson}
        giftParing.secondGiver = secondPerson
        
        
        // add all three names to the list
        finalPairings.append(giftParing)
    }
}



// String formatting methods
func makeLong(theString: String, target: Int) -> String {
    
    let numberOfSpaces = target - theString.characters.count
    
    if numberOfSpaces > 0 {
        
        var theUpdatedString = theString
        var i = numberOfSpaces
        
        while i > 0 {
            theUpdatedString.append(" ")
            i -= 1
        }
        return theUpdatedString
        
    } else {
        return theString
    }
}

func printPairings () {
    
    let titleArray = ["Receiver:", "Giver A:", "Giver B:"]
    
    let allThePrintedWords = titleArray + giftReceiver
    
    if let max = allThePrintedWords.max(by: {$1.characters.count > $0.characters.count}) {
        
        let spacingBuffer = 4
        let longestString = max.characters.count + spacingBuffer
        
        print(makeLong(theString: titleArray[0], target: longestString) + makeLong(theString: titleArray[1], target: longestString) + makeLong(theString: titleArray[2], target: longestString))
        
        
        for pairings in finalPairings {
            if pairings.receiver != "" {
                print (makeLong(theString: pairings.receiver, target: longestString) + makeLong(theString: pairings.firstGiver, target: longestString) + makeLong(theString: pairings.secondGiver, target: longestString) )
            }
        }
    }
    /*
     // the other way of displaying the data
     
     for pairings in finalPairings {
     if pairings.reciever != "" {
     print ("Receiver: " + pairings.reciever + ",  GiverA: " + pairings.firstGiver + ",  GiverB: " + pairings.secondGiver)
     
     }
     }
     */
}


performPairings()
printPairings()


