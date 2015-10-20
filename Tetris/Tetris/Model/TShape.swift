//
//  TShape.swift
//  Tetris
//
//  Created by TranDuy on 10/21/15.
//  Copyright © 2015 KDStudio. All rights reserved.
//

class TShape: Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(1, 0), (0, 1), (1, 1), (2, 1)],
            Orientation.Ninety:     [(2, 1), (1, 0), (1, 1), (1, 2)],
            Orientation.OneEighty:  [(1, 2), (0, 1), (1, 1), (2, 1)],
            Orientation.TwoSeventy: [(0, 1), (1, 0), (1, 1), (1, 2)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[secondBlockIndex], blocks[thirdBlockIndex], blocks[fourthBlockIndex]],
            Orientation.Ninety:     [blocks[firstBlockIndex], blocks[fourthBlockIndex]],
            Orientation.OneEighty:  [blocks[firstBlockIndex], blocks[secondBlockIndex], blocks[fourthBlockIndex]],
            Orientation.TwoSeventy: [blocks[firstBlockIndex], blocks[fourthBlockIndex]]
        ]
    }
}