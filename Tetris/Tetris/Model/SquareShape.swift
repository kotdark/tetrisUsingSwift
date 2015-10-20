//
//  SquareShape.swift
//  Tetris
//
//  Created by TranDuy on 10/21/15.
//  Copyright © 2015 KDStudio. All rights reserved.
//

class SquareShape: Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.OneEighty: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.Ninety: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.TwoSeventy: [(0, 0), (1, 0), (0, 1), (1, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[thirdBlockIndex], blocks[fourthBlockIndex]],
            Orientation.OneEighty:  [blocks[thirdBlockIndex], blocks[fourthBlockIndex]],
            Orientation.Ninety:     [blocks[thirdBlockIndex], blocks[fourthBlockIndex]],
            Orientation.TwoSeventy: [blocks[thirdBlockIndex], blocks[fourthBlockIndex]]
        ]
    }
}