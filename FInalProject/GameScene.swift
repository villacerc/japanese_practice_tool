//
//  GameScene.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-10-08.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var label: SKLabelNode!
    
    let startPointLabel = (x: -15, y: -43)
    let startPointBox = (x: -255, y: 108)
    
    let labelName = "movable"
    var tile: SKLabelNode!
    var touchedLabel: SKLabelNode!
    
    var selectedLabel: SKLabelNode?
    var draggedLabel: SKLabelNode?
    
    var selectedBox: SKSpriteNode?
    var draggedToBox: SKSpriteNode?
    
    var selectedHelper: UILabel?
    
    var previousLocation: CGPoint?
    
    var labels = [SKLabelNode]()
    var boxes = [SKSpriteNode]()
    
    var swiped = false
    
    
    /*var hiraganaBox =  [["a":"あ", "i":"い", "u":"え", "e":"う", "o":"お"],
     ["ka":"か", "ki":"き", "ku":"く", "ke":"け", "ko":"こ"]]*/
    
    var hiraganaBox = [["a", "i", "u", "e", "o"],
                       ["ka", "ki", "ku", "ke", "ko"],
                       ["sa", "shi", "su", "se", "so"],
                       ["ta", "chi", "tsu", "te", "to"],
                       ["na", "ni", "nu", "ne", "no"],
                       ["ha", "hi", "fu", "he", "ho"],
                       ["ma", "mi", "mu", "me", "mo"],
                       ["ra", "ri", "ru", "re", "ro"],
                       ["ya", "yu", "yo"],
                       ["wa", "wo", "n"]]
    
    
    var hiragana = [["あ", "い", "う", "え", "お"],
                    ["か", "き", "く", "け", "こ"],
                    ["さ", "し", "す", "せ", "そ"],
                    ["た", "ち", "つ", "て", "と"],
                    ["な", "に", "ぬ", "ね", "の"],
                    ["は", "ひ", "ふ", "へ", "ほ"],
                    ["ま", "み", "む", "め", "も"],
                    ["ら", "り", "る", "れ", "ろ"],
                    ["や", "ゆ", "よ"],
                    ["わ", "を", "ん"]]
    
    
    let padding = (width:58, height: 36)
    let paddingLabel = (width:57, height: 36)
    
    let tileSize = (width:40, height: 30)
    
    
    override func didMove(to view: SKView) {
        
        placeAllBoxes()
        displayDragLabels()
        displaySelectionHelper()
        
    }
    
    func placeBox(_ name: String, withPosition: CGPoint){
        
        let box = SKSpriteNode()
        
        box.name = name
        box.size = CGSize(width: 30, height: 30)
        box.color = .yellow
        
        box.position = withPosition
        
        boxes.append(box)
        addChild(box)
        
    }
    
    func placeBoxLabel(_ name: String, withPosition: CGPoint){
        
        //selectedHelper = UILabel(frame: CGRect(x:0 , y: 0, width: 42, height: 21))
        
        let label = UILabel(frame: CGRect(x: withPosition.x , y: -withPosition.y, width: 42, height: 21))
        
        label.textColor = .black
        label.font = selectedHelper?.font.withSize(20)
        label.textAlignment = .center
        //label.center = withPosition
        label.text = name
        
        self.view?.addSubview(label)
        
    }
    
    func placeAllBoxes(){
        
        for i in 0..<hiraganaBox.count{
            let row = hiraganaBox[i]
            let row2 = hiragana[i]
            
            for j in 0..<row.count{
                let name = row[j]
                let text = row2[j]
                
                let positionBox = CGPoint(x: (i*padding.width) + startPointBox.x, y: -(j*padding.height) + startPointBox.y)
                
                let positionLabel = CGPoint(x: (i*paddingLabel.width) + startPointLabel.x, y: -(j*paddingLabel.height) + startPointLabel.y)
                
                createDragLabel(name, text: text)
                placeBox(text, withPosition: positionBox)
                placeBoxLabel(name, withPosition: positionLabel)
            }
        }
    }
    
    func createDragLabel(_ name: String, text: String){
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        
        label.fontColor = UIColor.blue
        label.fontSize = 25
        label.text = text
        label.name = labelName
        
        labels.append(label)
        
    }
    
    func displaySelectionHelper(){
        
        selectedHelper = UILabel(frame: CGRect(x: 288 , y: 6, width: 42, height: 21))
        
        selectedHelper?.textColor = .black
        selectedHelper?.font = selectedHelper?.font.withSize(25)
        selectedHelper?.textAlignment = .center
        
        selectedHelper?.text = ""
        
        self.view?.addSubview(selectedHelper!)
        
    }
    
    func displayDragLabels(){
        
        var nums = [Int](0...labels.count - 1)
        
        //first 6 tiles
        var x = 0
        var y = 0
        var count = 0
        let startPoint = (x:183, y:-14)
        
        //rest of tiles
        var x2 = 0
        var y2 = 0
        let startPoint2 = (x:-255, y:-82)
        
        //start loop for eaach label
        while nums.count != 0 {
            let randNum = Int(arc4random_uniform(UInt32(nums.count)))
            label = labels[nums.remove(at: randNum)]
            count += 1
            
            //load first 6 tiles
            if count <= 6 {
                
                label.position = CGPoint(x: (x*tileSize.width) + startPoint.x,y: -(y*tileSize.height) + startPoint.y)
                addChild(label)
                x += 1
                if x == 3 {
                    x = 0
                    y += 1
                }
            }
            
            //load of rest of tiles
            if count > 6 {
                
                label.position = CGPoint(x: (x2*tileSize.width) + startPoint2.x,y: -(y2*tileSize.height) + startPoint2.y)
                addChild(label)
                x2 += 1
                if x2 == 15 {
                    x2 = 0
                    y2 += 1
                }
                
            }
            
        }
    }

    func selectNode(_ touchLocation: CGPoint){
        let touchedNode = self.atPoint(touchLocation)
        
        if touchedNode is SKSpriteNode {
            selectedBox = touchedNode as? SKSpriteNode
            
        }
        
        if touchedNode is SKLabelNode {
            selectedLabel = touchedNode as? SKLabelNode
            draggedLabel = touchedNode as? SKLabelNode
            selectedHelper?.text = selectedLabel?.text
        } else {
            draggedLabel = nil
            //selectedHelper?.text = ""
        }
        
    }
    
    func panForTranslation(_ translation: CGPoint) {
        
        guard let position = draggedLabel?.position else { return }
        guard let name = draggedLabel?.name else { return }
        
        
        if  name == labelName {
            draggedLabel?.position = CGPoint(x: (position.x) + translation.x, y: (position.y) + translation.y)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        
        for touch in touches {
            let positionInScene = touch.location(in: self)
            
            selectNode(positionInScene)
            previousLocation = selectedLabel?.position
            
        }
        
    }
    
    //use touchesMoved for the drag motion of the sprite
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        for touch in touches {
            
            //detect where the touch is happening
            let positionInScene = touch.location(in: self)
            let previousPosition = touch.previousLocation(in: self)
            
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
            
            for box in boxes {
                if box.name == draggedLabel?.text {
                    draggedToBox = box
                }
            }
            
            panForTranslation(translation)
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if swiped {
            for touch in touches {
                let touchedLocation = touch.location(in: self)
                if draggedToBox != nil {
                    if (draggedToBox?.frame.contains((touchedLocation)))! {
                        draggedLabel?.position = (draggedToBox?.position)!
                        draggedLabel?.position.y += -12
                        
                        draggedToBox = nil
                        draggedLabel = nil
                        selectedHelper?.text = ""
                        swiped = false
                    }  else {
                        draggedLabel?.position = previousLocation!
                        
                        draggedLabel = nil
                        draggedToBox = nil
                        //selectedHelper?.text = ""
                        swiped = false
                    }
                    
                }
                
                
            }
        } else {
            swiped = false
            
            guard let label = selectedLabel else {return}
            guard let box = selectedBox else {return}
            
            if box.name == label.text{
                selectedLabel?.position = (selectedBox?.position)!
                selectedLabel?.position.y += -12
                
                selectedBox = nil
                selectedLabel = nil
                selectedHelper?.text = ""
            } else {
                
                selectedBox = nil
                selectedLabel = nil
                selectedHelper?.text = ""
            }
            
        }
    }
}
