//
//  SoundPlayer.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/22/26.
//

import AVFAudio

class SoundPlayer {
    var audioPlayer: AVAudioPlayer?
    
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "chime", withExtension: "mp3") else {
            print("Error playing sounds file 'chime.mp3'")
            return }
        
        do {
            audioPlayer =  try AVAudioPlayer(contentsOf: soundURL)
            
            audioPlayer?.prepareToPlay()
            
            if audioPlayer?.play() == false {
                print("Playback failed")}
        } catch {
            print("Error init audio player: \(error.localizedDescription)")
            audioPlayer = nil
        }
        
    }
}

