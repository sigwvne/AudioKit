//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## Multi-tap Delay
//: ### A multi-tap delay is a delay line where multiple 'taps' or outputs are taken from a delay buffer at different points, and the taps are then summed with the original. Multi-tap delays are great for creating rhythmic delay patterns, but they can also be used to create sound fields of such density that they start to take on some of the qualities we'd more usually associate with reverb. - Geoff Smith, Sound on Sound
import XCPlayground
import AudioKit

let audiokit = AKManager.sharedInstance

let bundle = NSBundle.mainBundle()
let file = bundle.pathForResource("drumloop", ofType: "wav")

var player = AKAudioPlayer(file!)
player.looping = true

//: ### In AudioKit, you can create a multitap easily through creating a function that mixes together several delays and gains.
func multitapDelay(source: AKNode, times: [Double], gains: [Double]) -> AKMixer {
    let mix = AKMixer(player)
    zip(times, gains).forEach { (time, gain) -> () in
        let delay = AKDelay(source, time: time, feedback: 0.0, dryWetMix: 100)
        mix.connect(AKGain(delay, gain: gain))
    }
    return mix
}

audiokit.audioOutput = multitapDelay(player, times: [0.1, 0.2, 0.4], gains: [0.5, 2.0, 0.5])

audiokit.start()
player.play()

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)