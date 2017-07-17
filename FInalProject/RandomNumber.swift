//
//  RandomNumber.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-11-14.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import Foundation

class RandomNumber {
    
    var num: Int!
    static var nums = [Int](0...45)
    
    init(){
        
    }
    
    static func generateNumber() -> Int{
        let randNum = Int(arc4random_uniform(UInt32(nums.count)))
        
        if nums.isEmpty {
            
        }
         return nums.remove(at: randNum)
    }
    
    static func isEmpty() -> Bool{
        if nums.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    static func renew()
    {
        if nums.isEmpty {
            nums = [Int](0...45)
        }
    }
}
