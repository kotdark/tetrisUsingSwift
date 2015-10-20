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

let PointsPerLine = 10
let LevelThreshold = 1000

protocol SwiftrisDelegate {
    // Invoked when the current round of Swiftris ends
    func gameDidEnd(swiftTeris: SwiftTetris)
    
    // Invoked immediately after a new game has begun
    func gameDidBegin(swiftTeris: SwiftTetris)
    
    // Invoked when the falling shape has become part of the game board
    func gameShapeDidLand(swiftTeris: SwiftTetris)
    
    // Invoked when the falling shape has changed its location
    func gameShapeDidMove(swiftTeris: SwiftTetris)
    
    // Invoked when the falling shape has changed its location after being dropped
    func gameShapeDidDrop(swiftTeris: SwiftTetris)
    
    // Invoked when the game has reached a new level
    func gameDidLevelUp(swiftTeris: SwiftTetris)
}

class SwiftTetris {
    var blockArray: Array2D<Block>
    var nextShape: Shape?
    var fallingShape: Shape?
    
    var delegate:SwiftrisDelegate?
    
    var score:Int
    var level:Int
    
    init() {
        score = 0
        level = 1
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: numColumns, rows: numRows)
    }
    
    func beginGame() {
        if nextShape == nil {
            nextShape = Shape.random(previewColumn, startingRow: previewRow)
        }
        delegate?.gameDidBegin(self)
    }
    
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?){
        fallingShape = nextShape
        nextShape = Shape.random(previewColumn, startingRow: previewRow)
        fallingShape?.moveTo(startingColumn, row: startingRow)
        return (fallingShape, nextShape)
    }
    
    func detectIllegalPlacement() -> Bool {
        if let shape = fallingShape {
            for block in shape.blocks {
                if block.column < 0 || block.column >= numColumns
                    || block.row < 0 || block.row >= numRows {
                        return true
                } else if blockArray[block.column, block.row] != nil {
                    return true
                }
            }
        }
        return false
    }
    
    func settleShape() {
        if let shape = fallingShape {
            for block in shape.blocks {
                blockArray[block.column, block.row] = block
            }
            fallingShape = nil
            delegate?.gameShapeDidLand(self)
        }
    }
    
    
    func detectTouch() -> Bool {
        if let shape = fallingShape {
            for bottomBlock in shape.bottomBlocks {
                if bottomBlock.row == numRows - 1 ||
                    blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
                        return true
                }
            }
        }
        return false
    }
    
    func endGame() {
        score = 0
        level = 1
        delegate?.gameDidEnd(self)
    }
    
    func removeCompletedLines() -> (linesRemoved: Array<Array<Block>>, fallenBlocks: Array<Array<Block>>) {
        var removedLines = Array<Array<Block>>()
        for var row = numRows - 1; row > 0; row-- {
            var rowOfBlocks = Array<Block>()
            
            for column in 0..<numColumns {
                if let block = blockArray[column, row] {
                    rowOfBlocks.append(block)
                }
            }
            if rowOfBlocks.count == numColumns {
                removedLines.append(rowOfBlocks)
                for block in rowOfBlocks {
                    blockArray[block.column, block.row] = nil
                }
            }
        }
        
        
        if removedLines.count == 0 {
            return ([], [])
        }
        
        let pointsEarned = removedLines.count * PointsPerLine * level
        score += pointsEarned
        if score >= level * LevelThreshold {
            level += 1
            delegate?.gameDidLevelUp(self)
        }
        
        var fallenBlocks = Array<Array<Block>>()
        for column in 0..<numColumns {
            var fallenBlocksArray = Array<Block>()
            for var row = removedLines[0][0].row - 1; row > 0; row-- {
                if let block = blockArray[column, row] {
                    var newRow = row
                    while (newRow < numRows - 1 && blockArray[column, newRow + 1] == nil) {
                        newRow++
                    }
                    block.row = newRow
                    blockArray[column, row] = nil
                    blockArray[column, newRow] = block
                    fallenBlocksArray.append(block)
                }
            }
            if fallenBlocksArray.count > 0 {
                fallenBlocks.append(fallenBlocksArray)
            }
        }
        return (removedLines, fallenBlocks)
    }
    
    func dropShape() {
        if let shape = fallingShape {
            while detectIllegalPlacement() == false {
                shape.lowerShapeByOneRow()
            }
            shape.raiseShapeByOneRow()
            delegate?.gameShapeDidDrop(self)
        }
    }
    
    func letShapeFall() {
        if let shape = fallingShape {
            shape.lowerShapeByOneRow()
            if detectIllegalPlacement() {
                shape.raiseShapeByOneRow()
                if detectIllegalPlacement() {
                    endGame()
                } else {
                    settleShape()
                }
            } else {
                delegate?.gameShapeDidMove(self)
                if detectTouch() {
                    settleShape()
                }
            }
        }
    }
    
    func rotateShape() {
        if let shape = fallingShape {
            shape.rotateClockwise()
            if detectIllegalPlacement() {
                shape.rotateCounterClockwise()
            } else {
                delegate?.gameShapeDidMove(self)
            }
        }
    }
    
    func moveShapeLeft() {
        if let shape = fallingShape {
            shape.shiftLeftByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftRightByOneColumn()
                return
            }
            delegate?.gameShapeDidMove(self)
        }
    }
    
    func moveShapeRight() {
        if let shape = fallingShape {
            shape.shiftRightByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftLeftByOneColumn()
                return
            }
            delegate?.gameShapeDidMove(self)
        }
    }
    
    func removeAllBlocks() -> Array<Array<Block>> {
        var allBlocks = Array<Array<Block>>()
        for row in 0..<numRows {
            var rowOfBlocks = Array<Block>()
            for column in 0..<numColumns {
                if let block = blockArray[column, row] {
                    rowOfBlocks.append(block)
                    blockArray[column, row] = nil
                }
            }
            allBlocks.append(rowOfBlocks)
        }
        return allBlocks
    }
}