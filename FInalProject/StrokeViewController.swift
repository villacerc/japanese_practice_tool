//
//  StrokeViewController.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-10-15.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class StrokeViewController: UIViewController {
    
    @IBOutlet var tempImageView: UIImageView!
    
    @IBOutlet var hiraganaImage: UIImageView!
    @IBOutlet var hiraganaGif: UIImageView!
    
    @IBOutlet var savedImage1: UIImageView!
    @IBOutlet var savedImage2: UIImageView!
    
    @IBOutlet var romajiLabel: UILabel!
    
    @IBOutlet var nextButton: UIButton!
    
    var lastPoint = CGPoint.zero
    var brushWidth: CGFloat = 1.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    @IBOutlet var clearButton: UIButton!
    
    
    var hiragana =    ["a", "i", "u", "e", "o",
                       "ka", "ki", "ku", "ke", "ko",
                       "sa", "shi", "su", "se", "so",
                       "ta", "chi", "tsu", "te", "to",
                       "na", "ni", "nu", "ne", "no",
                       "ha", "hi", "fu", "he", "ho",
                       "ma", "mi", "mu", "me", "mo",
                       "ra", "ri", "ru", "re", "ro",
                       "ya", "yu", "yo",
                       "wa", "wo", "n"]
    
    var syllabary = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButton.layer.cornerRadius = 5
        clearButton.layer.borderWidth = 1.5
        clearButton.layer.borderColor = UIColor.black.cgColor
        
        nextButton.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 1.5
        nextButton.layer.borderColor = UIColor.black.cgColor
        
        
        let randNum = RandomNumber.generateNumber()
        syllabary = hiragana[randNum]
        print("\(randNum)")
        
        
        let gif = UIImage.gifWithName("/gifs/\(syllabary)")
        
        hiraganaGif.image = gif
        hiraganaImage.image = UIImage(named: syllabary)
        
        // Do any additional setup after loading the view.
        
    }

    
    @IBAction func showRomajiButton(_ sender: AnyObject) {
        romajiLabel.isHidden = false
        romajiLabel.text = syllabary
        
    }
    
    @IBAction func clearButton(_ sender: AnyObject) {
        if tempImageView.image != nil {
        savedImage2.image = savedImage1.image
        savedImage1.image = tempImageView.image
        tempImageView.image = nil
        }
    }
    
    @IBAction func nextButton(_ sender: AnyObject) {
        
        if !RandomNumber.isEmpty(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StrokeViewController")
        self.navigationController?.pushViewController(vc, animated: true)

        navigationController!.viewControllers.remove( at: navigationController!.viewControllers.count - 2 )
        } else {
            nextButton.isHidden = true
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        swiped = false
        if let touch = touches.first {
        
            lastPoint = touch.location(in: tempImageView)
        }
        
    }
    
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height))
        
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(8)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        
        context?.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: tempImageView)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if swiped == false {
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
