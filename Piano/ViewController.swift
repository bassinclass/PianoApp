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

   
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var dLabel: UILabel!
    @IBOutlet weak var eLabel: UILabel!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    
    var labelArray = [UILabel]()
    var sound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendLabel()

    }

    
    
    
    @IBAction func onTap(_ sender: Any) {
        playPianoSound(sender)
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
    
    func getSound(fileName: String){
        if let path = Bundle.main.path(forResource: fileName, ofType: "wav") {
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
    
    fileprivate func playPianoSound(_ sender: Any) {
        if labelArray[0].frame.contains((sender as AnyObject).location(in: view)){
            getSound(fileName: "piano-a")
        }
        else  if labelArray[1].frame.contains((sender as AnyObject).location(in: view)){
            getSound(fileName: "piano-b")
        }
        else  if labelArray[2].frame.contains((sender as AnyObject).location(in: view)){
            getSound(fileName: "piano-c")
        }
        else  if labelArray[3].frame.contains((sender as AnyObject).location(in: view)){
            getSound(fileName: "piano-d")
        }
        else  if labelArray[4].frame.contains((sender as AnyObject).location(in: view)){
            getSound(fileName: "piano-e")
        }
        else  if labelArray[5].frame.contains((sender as AnyObject).location(in: view)){
            getSound(fileName: "piano-f")
        }
        else  if labelArray[6].frame.contains((sender as AnyObject).location(in: view)){
            getSound(fileName: "piano-g")
        }
    }

    



}
