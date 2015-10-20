//
//  GameViewController.swift
//  Tetris
//
//  Created by TranDuy on 10/20/15.
//  Copyright (c) 2015 KDStudio. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {
    var scene: GameScene!
    var swiftTetris: SwiftTetris!
    var panPointReference:CGPoint?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the view
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        swiftTetris = SwiftTetris()
        swiftTetris.delegate = self
        swiftTetris.beginGame()
        
        // Present the scene
        skView.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        swiftTetris.rotateShape()
    }
    
    @IBAction func didPan1(sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            if abs(currentPoint.x - originalPoint.x) > (blockSize * 0.9) {
                if sender.velocityInView(self.view).x > CGFloat(0) {
                    swiftTetris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftTetris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
    
    func didTick() {
        swiftTetris.letShapeFall()
    }
    
    @IBAction func didSwipe1(sender: UISwipeGestureRecognizer) {
        swiftTetris.dropShape()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let swipeRec = gestureRecognizer as? UISwipeGestureRecognizer {
            if let panRec = otherGestureRecognizer as? UIPanGestureRecognizer {
                return true
            }
        } else if let panRec = gestureRecognizer as? UIPanGestureRecognizer {
            if let tapRec = otherGestureRecognizer as? UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    func nextShape() {
        let newShapes = swiftTetris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
            self.scene.movePreviewShape(fallingShape) {
                
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            }
        }
    }
    
    func gameDidBegin(swiftTetris: SwiftTetris) {
        levelLabel.text = "\(swiftTetris.level)"
        scoreLabel.text = "\(swiftTetris.score)"
        scene.tickLengthMillis = tickLengthLevelOne
        
        // The following is false when restarting a new game
        if swiftTetris.nextShape != nil && swiftTetris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftTetris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftTetris: SwiftTetris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
        
        scene.playSound("gameover.mp3")
        scene.animateCollapsingLines(swiftTetris.removeAllBlocks(), fallenBlocks: Array<Array<Block>>()) {
            swiftTetris.beginGame()
        }
    }
    
    func gameDidLevelUp(swiftTetris: SwiftTetris) {
        levelLabel.text = "\(swiftTetris.level)"
        if scene.tickLengthMillis >= 100 {
            scene.tickLengthMillis -= 100
        } else if scene.tickLengthMillis > 50 {
            scene.tickLengthMillis -= 50
        }
        scene.playSound("levelup.mp3")
    }
    
    func gameShapeDidDrop(swiftTetris: SwiftTetris) {
        scene.stopTicking()
        scene.redrawShape(swiftTetris.fallingShape!) {
            swiftTetris.letShapeFall()
        }
        scene.playSound("drop.mp3")
    }
    
    func gameShapeDidLand(swiftTetris: SwiftTetris) {
        scene.stopTicking()
        self.view.userInteractionEnabled = false
        // #1
        let removedLines = swiftTetris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(swiftTetris.score)"
            scene.animateCollapsingLines(removedLines.linesRemoved, fallenBlocks:removedLines.fallenBlocks) {
                // #2
                self.gameShapeDidLand(swiftTetris)
            }
            scene.playSound("bomb.mp3")
        } else {
            nextShape()
        }    }
    
    func gameShapeDidMove(swiftTetris: SwiftTetris) {
        scene.redrawShape(swiftTetris.fallingShape!) {}
    }
}
