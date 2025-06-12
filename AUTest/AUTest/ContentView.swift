import SwiftUI
import Combine
import AudioKit
import AudioKitEX
import SoundpipeAudioKit

struct ContentView: View {
    @State var loadEngine1: Bool = false
    @State var loadEngine2: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                Text("When the button is pressed it will load an engine.\n\nIn iOS 18, When the engine is unloaded while running AudioKitAU will call **deinit**, **deallocateRenderResources**.\n\nIf the engine was not running AudioKitAU will call **deinit**.\n\nIn iOS 26, When the engine is unloaded while running AudioKitAU will call **deallocateRenderResources**, **deinit**, **deallocateRenderResources**.\n\nIf the engine was not running AudioKitAU will call **deinit**, **deallocateRenderResources**.\n\nSet breakpoints to observe.")
                    .padding()
            }
            
            Button() {
                loadEngine1.toggle()
            } label: {
                Text(loadEngine1 ? "Unload Engine" : "Load & Start Engine")
            }
                
            Button() {
                loadEngine2.toggle()
            } label: {
                Text(loadEngine2 ? "Unload Engine" : "Load Engine")
            }
            
            if loadEngine1 {
                AudioEngineView(started: true)
            }
            
            if loadEngine2 {
                AudioEngineView(started: false)
            }
        }.padding()
    }
}

struct AudioEngineView: View {
    let started: Bool
    @StateObject private var audioManager: AudioManager
    
    init(started: Bool) {
        self.started = started
        self._audioManager = StateObject(wrappedValue: AudioManager(shouldStart: started))
    }
    
    var body: some View {
        VStack {
            Text("Audio Engine Loaded")
                .foregroundColor(.green)
                .padding()
            
            Text("Started: \(started ? "Yes" : "No")")
                .foregroundColor(started ? .green : .orange)
                .padding()
        }
    }
}

class AudioManager: ObservableObject {
    private var engine: AudioEngine
    private var osc: Oscillator
    
    init(shouldStart: Bool = false) {
        engine = AudioEngine()
        osc = Oscillator(amplitude: 0.2)
        engine.output = osc
        
        if shouldStart {
            osc.start()
            try? engine.start()
        }
    }
    
//    deinit {
//        engine.stop()
//        osc.stop()
//    }
}

#Preview {
    ContentView()
}
