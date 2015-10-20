//
//  Array2D.swift
//  Tetris
//
//  Created by TranDuy on 10/20/15.
//  Copyright © 2015 KDStudio. All rights reserved.
//

import Foundation

class Array2D<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows:Int) {
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(count: columns * rows, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * columns) + column]
        }
        set(newValue) {
            array[(row * columns) + column] = newValue
        }
    }
}