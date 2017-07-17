//
//  Hiragana.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-10-30.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import SpriteKit

enum HiraganaType: Int, CustomStringConvertible {
    case ka, ki, ku, ke, ko
    
    var spriteName: String {
        let spriteNames = ["か", "き", "き", "け", "こ"]
        
        return spriteNames[rawValue]
    }
    
    var description: String {
        return spriteName
    }
}

class Hiragana: CustomStringConvertible{
    var column: Int
    var row: Int
    let hiraganaType: HiraganaType
    var sprite: SKSpriteNode?
    
    
    init(column: Int, row: Int, hiraganaType: HiraganaType)
    {
        self.column = column
        self.row = row
        self.hiraganaType = hiraganaType
    }
    
    var description: String {
        return "type:\(hiraganaType) square:(\(column), \(row))"
    }
}

func random() -> HiraganaType {
    return HiraganaType(rawValue: Int(arc4random_uniform(5)))!
}

