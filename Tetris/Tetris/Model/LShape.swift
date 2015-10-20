//
//  LShape.swift
//  Tetris
//
//  Created by TranDuy on 10/21/15.
//  Copyright © 2015 KDStudio. All rights reserved.
//

class LShape: Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [ (0, 0), (0, 1),  (0, 2),  (1, 2)],
            Orientation.Ninety:     [ (1, 1), (0, 1),  (-1,1), (-1, 2)],
            Orientation.OneEighty:  [ (0, 2), (0, 1),  (0, 0),  (-1,0)],
            Orientation.TwoSeventy: [ (-1,1), (0, 1),  (1, 1),   (1,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[thirdBlockIndex], blocks[fourthBlockIndex]],
            Orientation.Ninety:     [blocks[firstBlockIndex], blocks[secondBlockIndex], blocks[fourthBlockIndex]],
            Orientation.OneEighty:  [blocks[firstBlockIndex], blocks[fourthBlockIndex]],
            Orientation.TwoSeventy: [blocks[firstBlockIndex], blocks[secondBlockIndex], blocks[thirdBlockIndex]]
        ]
    }
}