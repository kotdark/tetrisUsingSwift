//
//  ZShape.swift
//  Tetris
//
//  Created by TranDuy on 10/21/15.
//  Copyright © 2015 KDStudio. All rights reserved.
//

class ZShape:Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(1, 0), (1, 1), (0, 1), (0, 2)],
            Orientation.Ninety:     [(-1,0), (0, 0), (0, 1), (1, 1)],
            Orientation.OneEighty:  [(1, 0), (1, 1), (0, 1), (0, 2)],
            Orientation.TwoSeventy: [(-1,0), (0, 0), (0, 1), (1, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[secondBlockIndex], blocks[fourthBlockIndex]],
            Orientation.Ninety:     [blocks[firstBlockIndex], blocks[thirdBlockIndex], blocks[fourthBlockIndex]],
            Orientation.OneEighty:  [blocks[secondBlockIndex], blocks[fourthBlockIndex]],
            Orientation.TwoSeventy: [blocks[firstBlockIndex], blocks[thirdBlockIndex], blocks[fourthBlockIndex]]
        ]
    }
}