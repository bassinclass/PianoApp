//
//  ViewController.swift
//  Piano
//
//  Created by Fleischauer, Joseph on 9/3/18.
//  Copyright © 2018 Fleischauer, Joseph. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var dLabel: UILabel!
    @IBOutlet weak var eLabel: UILabel!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    
    var labelArray = [UILabel]()
    var sound: AVAudioPlayer?
    var timer = Timer()
    var pattern: [Int] = []
    var noteNumber = 0
    var recordingInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendLabel()
    }
    
    @IBAction func onStartButtonTapped(_ sender: Any) {
        if recordingInProgress == false {
            recordingInProgress = true
        } else {
            let recordingInProgressAlert = UIAlertController(title: "Recording Already in progrss", message: "You've already started recording", preferredStyle: .alert)
            recordingInProgressAlert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(recordingInProgressAlert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func onStopButtonTapped(_ sender: Any) {
        if recordingInProgress == true {
            recordingInProgress = false
        } else {
            let recordingInProgressAlert = UIAlertController(title: "No Recording in progrss", message: "There's no recording to stop", preferredStyle: .alert)
            recordingInProgressAlert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(recordingInProgressAlert, animated: true, completion: nil)
        }
        
    }
   
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        if recordingInProgress == true {
            let tappedLocation = sender.location(in: grayView)
            for noteLabel in labelArray {
                playSound(fileName: noteLabel.tag)
                if noteLabel.frame.contains(tappedLocation) {
                    noteNumber += 1 //added a number on to note.
                    print("You tapped the \(String(describing: noteLabel.text)) note")
                    appendToPattern(noteNumber: noteLabel.tag)
                    print(pattern)
                }
            }
        }
    }
    
    @IBAction func onPlayButtonTapped(_ sender: Any) {
        displayPattern()
    }

    func displayPattern() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(playThePattern), userInfo: nil, repeats: false)
    }
    
    @objc func playThePattern() {
            if pattern.count < noteNumber {
                playSound(fileName: pattern[noteNumber])
                noteNumber += 1
            }else {
                timer.invalidate()
                print(pattern.count)
                print(noteNumber)
            }
    }
    
    func appendLabel() {
        labelArray.append(aLabel)
        labelArray.append(bLabel)
        labelArray.append(cLabel)
        labelArray.append(dLabel)
        labelArray.append(eLabel)
        labelArray.append(fLabel)
        labelArray.append(gLabel)
    }
    
    func playSound(fileName: Int){
        if let path = Bundle.main.path(forResource: String(fileName), ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                self.sound = try AVAudioPlayer(contentsOf: url)
                self.sound?.play()
            }
            catch {
//                print("Can't find file")
            }
        }
    }
    
    func appendToPattern(noteNumber: Int) { //appends to pattern array
        pattern.append(noteNumber)
    }
    
    

}

//    func playPianoSound(sender: Any) { // this function needs to recognize a tap before it can get the sound.
//        if labelArray[0].frame.contains((sender as! UITapGestureRecognizer).location(in: grayView)){
//            getSound(fileName: "piano-a")
//        }
//        else  if labelArray[1].frame.contains((sender as AnyObject).location(in: grayView)){
//            getSound(fileName: "piano-b")
//        }
//        else  if labelArray[2].frame.contains((sender as AnyObject).location(in: grayView)){
//            getSound(fileName: "piano-c")
//        }
//        else  if labelArray[3].frame.contains((sender as AnyObject).location(in: grayView)){
//            getSound(fileName: "piano-d")
//        }
//        else  if labelArray[4].frame.contains((sender as AnyObject).location(in: grayView)){
//            getSound(fileName: "piano-e")
//        }
//        else  if labelArray[5].frame.contains((sender as AnyObject).location(in: grayView)){
//            getSound(fileName: "piano-f")
//        }
//        else  if labelArray[6].frame.contains((sender as AnyObject).location(in: grayView)){
//            getSound(fileName: "piano-g")
//        }
//    }


//    func playRecordedPianoSound(){
//
//        for element in pattern{
//            if element == 1 {
//                getSound(fileName: "piano-a")
//            }
//            else  if element == 2{
//                getSound(fileName: "piano-b")
//            }
//            else if element == 3{
//                getSound(fileName: "piano-c")
//            }
//            else if element == 4{
//                getSound(fileName: "piano-d")
//            }
//            else if element == 5 {
//                getSound(fileName: "piano-e")
//            }
//            else  if element == 6{
//                getSound(fileName: "piano-f")
//            }
//            else if element == 7 {
//                getSound(fileName: "piano-g")
//            }
//        }
//
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(ViewController.soundController)), userInfo: nil, repeats: false)
//    }



