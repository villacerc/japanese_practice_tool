//
//  Array2D.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-10-30.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import Foundation

struct Array2D<T> {
    let columns: Int
    let rows: Int
    fileprivate var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating: nil, count: rows*columns)
        
    }
    
    subscript(column: Int, row: Int) -> T{
        get {
            return array[row*columns + column]!
        }
        set {
            array[row*columns + column] = newValue
        }
    }
}
