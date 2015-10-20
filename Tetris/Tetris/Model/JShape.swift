//
//  JShape.swift
//  Tetris
//
//  Created by TranDuy on 10/21/15.
//  Copyright © 2015 KDStudio. All rights reserved.
//

class JShape:Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(1, 0), (1, 1),  (1, 2),  (0, 2)],
            Orientation.Ninety:     [(2, 1), (1, 1),  (0, 1),  (0, 0)],
            Orientation.OneEighty:  [(0, 2), (0, 1),  (0, 0),  (1, 0)],
            Orientation.TwoSeventy: [(0, 0), (1, 0),  (2, 0),  (2, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[thirdBlockIndex], blocks[fourthBlockIndex]],
            Orientation.Ninety:     [blocks[firstBlockIndex], blocks[secondBlockIndex], blocks[thirdBlockIndex]],
            Orientation.OneEighty:  [blocks[firstBlockIndex], blocks[fourthBlockIndex]],
            Orientation.TwoSeventy: [blocks[firstBlockIndex], blocks[secondBlockIndex], blocks[fourthBlockIndex]]
        ]
    }
}