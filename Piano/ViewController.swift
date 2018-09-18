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
    var numberOfNotesPlayedBackAlready = 0
    
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
        let tappedLocation = sender.location(in: grayView)
        for noteLabel in labelArray {
            if noteLabel.frame.contains(tappedLocation) {
                playSound(fileName: noteLabel.tag)
            }
        }
        
        if recordingInProgress == true {
            for noteLabel in labelArray {
                if noteLabel.frame.contains(tappedLocation) {
                    noteNumber += 1
                    appendToPattern(noteNumber: noteLabel.tag)
                }
            }
        }
    }
    
    @IBAction func onPlayButtonTapped(_ sender: Any) {
        displayPattern()
    }

    func displayPattern() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(playThePattern), userInfo: nil, repeats: true)
    }
    
    @objc func playThePattern() {
        // there's more notes left in the array that you haven't played, keep playing
        if pattern.count > numberOfNotesPlayedBackAlready {
            // Play the next note in the pattern
            playSound(fileName: pattern[numberOfNotesPlayedBackAlready])
            // Increase the notesPlayed counter variable so we can re-evaluate next time
            numberOfNotesPlayedBackAlready = numberOfNotesPlayedBackAlready + 1
        } else {
            // There's no more notes left to play in the pattern so shut it all down
            timer.invalidate()
            // reset the counter
            numberOfNotesPlayedBackAlready = 0
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
                print("Can't find file")
            }
        }
    }
    
    func appendToPattern(noteNumber: Int) { //appends to pattern array
        pattern.append(noteNumber)
    }

}

