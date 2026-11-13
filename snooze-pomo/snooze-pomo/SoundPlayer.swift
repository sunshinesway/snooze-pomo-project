//
//  SoundPlayer.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 9/22/26.
//

import AVFAudio

protocol SoundPlaying { func playSound() }
extension SoundPlayer: SoundPlaying {}

class SoundPlayer {
    var audioPlayer: AVAudioPlayer?
    
    private func getSoundURL(forResource name: String = "soundreality-notification-reception-615689_double") -> URL? {
        guard let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Error locating sound file '\(name).mp3'")
            print("Bundle resource URL: \(Bundle.main.resourceURL?.path ?? "nil")")
            return nil
        }
        print("Found sound file: \(soundURL.path)")
        return soundURL
    }
    func playSound() {
        guard let soundURL = getSoundURL()
                else { return }
        
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

