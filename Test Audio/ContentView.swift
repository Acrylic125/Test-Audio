//
//  ContentView.swift
//  Test Audio
//

import SwiftUI
import AVKit
import Observation

class SpeechSynthesizer: ObservableObject { // NSObject, AVSpeechSynthesizerDelegate {
//    @State private var speechSynthesizer: AVSpeechSynthesizer?
    private let showModalDispatchQueue = DispatchQueue(label: "ShowModalDispatchQueue2", qos: .userInitiated, attributes: .concurrent)
    let speechSynthesizer = AVSpeechSynthesizer()

//    override init() {
//        super.init()
//        speechSynthesizer.delegate = self
//    }

    public func speak(text: String) {
        DispatchQueue.global(qos: .default).async {
            if AVAudioSession.sharedInstance().category != .playback {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                } catch {
                    print(error)
                }
            }
            let speechUtterance = AVSpeechUtterance(string: text)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode())

            self.speechSynthesizer.speak(speechUtterance)
//            DispatchQueue.main.async {
//            }
        }
    }
}

struct ContentView: View {
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    @State private var test = 0.0
    
    var body: some View {
        VStack {
            Button("Test Audio") {
                self.speechSynthesizer.speak(text: "Hello World!")
            }
            Slider(
                value: $test,
                in: 0...100,
                step: 0.1
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
