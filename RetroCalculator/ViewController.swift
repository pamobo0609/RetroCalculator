//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Liquid Workforce on 5/25/17.
//  Copyright © 2017 Liquid Workforce. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var lblOutput: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    
    var currOperation = Operation.Empty
    
    var leftValueStr = ""
    
    var rightValueStr = ""
    
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Path for the button sound
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        lblOutput.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender : AnyObject) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender : AnyObject) {
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onAddPressed(sender : AnyObject) {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onSubstractPressed(sender : AnyObject) {
        processOperation(operation: Operation.Substract)
    }
    
    @IBAction func onEqualsPressed(sender : AnyObject) {
        processOperation(operation: currOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
 
    func processOperation(operation : Operation) {
        playSound()
        
        if Operation.Empty != currOperation {
            if "" != runningNumber {
                
                rightValueStr = runningNumber
                runningNumber = ""
                
                switch currOperation {
                case Operation.Add:
                    result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
                    break
                    
                case Operation.Divide:
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
                    break
                    
                case Operation.Multiply:
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
                    break
                    
                case Operation.Substract:
                    result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                    break
                    
                default:
                    break
                }
                leftValueStr = result
                lblOutput.text = result
            }
            
            currOperation = operation
            
        } else {
            leftValueStr = runningNumber
            runningNumber = ""
            currOperation = operation
        }
    }
    
}
