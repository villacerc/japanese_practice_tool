//
//  ReadingViewController.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-10-22.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import UIKit

class ReadingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var question1: UILabel!
    @IBOutlet var question2: UILabel!
    @IBOutlet var question3: UILabel!
    
    @IBOutlet var answerLabel1: UILabel!
    @IBOutlet var answerLabel2: UILabel!
    @IBOutlet var answerLabel3: UILabel!
    
    @IBOutlet var checkmark1: UIImageView!
    @IBOutlet var checkmark2: UIImageView!
    @IBOutlet var checkmark3: UIImageView!
    
    @IBOutlet var input1: UITextField!
    @IBOutlet var input2: UITextField!
    @IBOutlet var input3: UITextField!
    
    let limitLength = 8
    
    var answer1 = ""
    
    /*let hiragana = [
        /*"a": "あ", "i": "い", "u": "う", "e": "え", "o": "お",*/
        "Ka": "か", "Ki": "き", "Ku": "く", "Ke": "け", "Ko":"こ",
        "Sa" : "さ", /*"Shi": "し",*/ "Su": "す", "Se": "せ", "So": "そ",
        "Ta": "た", /*"Chi": "ち" "Tsu": "つ",*/ "Te": "て", "To": "と",
        "Na": "な", "Ni": "に", "Nu": "ぬ", "Ne": "ね", "No": "の",
        "Ha": "は", "Hi": "ひ", "Fu": "ふ", "He": "へ", "Ho": "ほ",
        "Ma": "ま", "Mi": "み", "Mu": "む", "Me": "め", "Mo": "も",
        "Ya": "や", "Yu": "ゆ", "Yo": "よ",
        "Ra": "ら", "Ri": "り", "Ru": "る", "Re": "れ" , "Ro": "ろ",
        "Wa": "わ", "Wo": "を"]*/
    
    let hiragana = [
        "A": "あ", "I": "い", "U": "う", "E": "え", "O": "お",
        "Ka": "か", "Ki": "き", "Ku": "く", "Ke": "け", "Ko":"こ",
        "Sa" : "さ", "Shi": "し", "Su": "す", "Se": "せ", "So": "そ",
        "Ta": "た", "Chi": "ち", "Tsu": "つ", "Te": "て", "To": "と",
        "Na": "な", "Ni": "に", "Nu": "ぬ", "Ne": "ね", "No": "の",
        "Ha": "は", "Hi": "ひ", "Fu": "ふ", "He": "へ", "Ho": "ほ",
        "Ma": "ま", "Mi": "み", "Mu": "む", "Me": "め", "Mo": "も",
        "Ya": "や", "Yu": "ゆ", "Yo": "よ",
        "Ra": "ら", "Ri": "り", "Ru": "る", "Re": "れ" , "Ro": "ろ",
        "Wa": "わ", "Wo": "を"]
    
    /*let hiragana = ["A": "あ", "I": "い", "U": "う", "E": "え", "O": "お", "Shi": "し", "Chi": "ち", "Tsu": "つ"]*/
    
    var hiragana2 =    [
                       "ka", "ki", "ku", "ke", "ko",
                       "sa", "su", "se", "so",
                       "ta", "te", "to",
                       "na", "ni", "nu", "ne", "no",
                       "ha", "hi", "fu", "he", "ho",
                       "ma", "mi", "mu", "me", "mo",
                       "ra", "ri", "ru", "re", "ro",
                       "ya", "yu", "yo",
                       "wa", "wo"]
    
    let hiragana1 = ["a", "i", "u", "e", "o"]
    let hiragana3 = ["shi", "chi", "tsu"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input1.delegate = self
        input2.delegate = self
        input3.delegate = self
        //answerLabel1.text = ""
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
        //loadLabels()
        loadLabels(question: question1, answer: answerLabel1)
        loadLabels(question: question2, answer: answerLabel2)
        loadLabels(question: question3, answer: answerLabel3)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func loadLabels() {
        
        var count = 0
        var word1 = ""
        
        
        while count < 4 {
            //get a random number between 0 and 4
            let random = Int(arc4random_uniform(UInt32(hiragana.count)))
            
            word1 += Array(hiragana.values)[random]
            answerLabel1.text? += Array(hiragana.keys)[random]
            count += 1
        }
        
        //wordLabel1.text = word1
        
    }
    
    func loadLabels(question: UILabel, answer: UILabel){
        
        question.text = ""
        answer.text = ""
        var count = 0
        
        while count < 4 {
            //get a random number between 0 and 4
            let random = Int(arc4random_uniform(UInt32(hiragana.count)))
            
            question.text? += Array(hiragana.values)[random]
            answer.text? += Array(hiragana.keys)[random]
            count += 1
        }
    }
    
    func calculateResults(userInput: UITextField, answer: UILabel, checkmark: UIImageView) {
        answer.isHidden = false
        
        guard var checkInput = userInput.text?.lowercased() else { return }
        
        
        let myAnswer = answer.text! as NSString
        
        if checkInput.characters.count < myAnswer.length {
            
            let sum = myAnswer.length - checkInput.characters.count
            
            checkInput += String(repeating: " ", count: sum)
        }
        
        let myInput = checkInput as NSString
        
        
        if myInput.lowercased == myAnswer.lowercased {
            
            answer.textColor = UIColor.black
            checkmark.isHidden = false
            
        } else {
            
            answer.textColor = UIColor.red
            
            let myMutableString = NSMutableAttributedString(string: answer.text!)
            
            //var count = 0.0
            var count = 0
            var location = 0
            var length = 0
            var iterator = 0
            var found = false
            var newAnswer = ""
            var newInput = ""
            
            /*if myAnswer.length <= myInput.length {
                iterator = myAnswer.length
            } else {
                iterator = myInput.length
            }*/
           
            
            while count < myAnswer.length {
                
                
                if found == false {
                    for string in hiragana1 {
                        let answer = myAnswer.substring(with: NSRange(location: location, length: 1)).lowercased()
                        if answer == string {
                            newAnswer = answer
                            count += 1
                            length = 1
                            found = true
                            break
                        }
                    }
                }
                if found == false {
                    for string in hiragana2 {
                        let answer = myAnswer.substring(with: NSRange(location: location, length: 2)).lowercased()
                        if answer == string {
                            newAnswer = answer
                            count += 2
                            length = 2
                            found = true
                            break
                        }
                        
                    }
                }
                
                if found == false {
                    for string in hiragana3 {
                        let answer = myAnswer.substring(with: NSRange(location: location, length: 3)).lowercased()
                        if answer == string {
                            newAnswer = answer
                            count += 3
                            length = 3
                            found = true
                            break
                        }
                    }
                    
                }
                
                /*if myInput.length >= count {
                newInput = myInput.substring(with: NSRange(location: location, length: length)).lowercased()
                }*/
                
                newInput = myInput.substring(with: NSRange(location: location, length: length)).lowercased()
                
                if newInput == newAnswer {
                    myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange(location: location, length: length ))
                }
                location += length
                found = false
                
                /* while count < Double(checkInput.characters.count/2) - 0.5{
                 
                 /*for string in hiragana2 {
                 if myAnswer.contains(string)
                 }
                 for string in hiragana3 {
                 if myAnswer.contains(string)
                 }*/
                 
                 
                 let input = myInput.substring(with: NSRange(location: location, length: 2)).lowercased()
                 let answer = myAnswer.substring(with: NSRange(location: location, length: 2)).lowercased()
                 
                 if input == answer {
                 myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange(location: location,length:2))
                 }
                 
                 count += 1
                 location += 2
                 }
                 checkmark.isHidden = true
                 answer.attributedText = myMutableString
                 */
                
            }
            checkmark.isHidden = true
            answer.attributedText = myMutableString
        }
    }
    
    
    @IBAction func showAnswer(_ sender: AnyObject) {
        
        calculateResults(userInput: input1, answer: answerLabel1, checkmark: checkmark1)
        calculateResults(userInput: input2, answer: answerLabel2, checkmark: checkmark2)
        calculateResults(userInput: input3, answer: answerLabel3, checkmark: checkmark3)
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == input2 {
            animateViewMoving(up: true, moveValue: 30)
        }
        if textField == input3 {
            animateViewMoving(up: true, moveValue: 175)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == input2 {
            animateViewMoving(up: false, moveValue: 30)
        }
        if textField == input3 {
            animateViewMoving(up: false, moveValue: 175)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        //guard let text = textField.text else { return true }
        
        let newLength = (textField.text?.characters.count)! + string.characters.count - range.length
        
        if string.rangeOfCharacter(from: NSCharacterSet.letters) != nil || string == "" && range.length > 0 || textField == input1 || textField == input2 || textField == input3  {
            
            return newLength <= 12
        }
        else {
            return false
        }
    }
    
    
    @IBAction func nextButton(_ sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReadingViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController!.viewControllers.remove( at: navigationController!.viewControllers.count - 2 )
        
        
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
