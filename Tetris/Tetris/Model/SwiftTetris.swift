//
//  SwiftTetris.swift
//  Tetris
//
//  Created by TranDuy on 10/21/15.
//  Copyright © 2015 KDStudio. All rights reserved.
//

let numColumns = 10
let numRows = 20

let startingColumn = 4
let startingRow = 0

let previewColumn = 12
let previewRow = 1


class SwiftTetris {
    var blockArray: Array2D<Block>
    var nextShape: Shape?
    var fallingShape: Shape?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: numColumns, rows: numRows)
    }
    
    func beginGame() {
        if nextShape == nil {
            nextShape = Shape.random(previewColumn, startingRow: previewRow)
        }
    }
    
}