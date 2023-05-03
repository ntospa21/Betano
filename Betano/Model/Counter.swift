//
//  Counter.swift
//  Betano
//
//  Created by Pantos, Thomas on 2/5/23.
//

import Foundation

class CountdownTimer {
    var timeRemaining: TimeInterval
    var timer: Timer?
    var onTick: ((String) -> Void)?
    var onFinished: (() -> Void)?
    
    init(timeInterval: TimeInterval) {
        self.timeRemaining = timeInterval
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.timeRemaining -= 1.0
            let minutes = Int(self.timeRemaining) / 60 % 60
            let seconds = Int(self.timeRemaining) % 60
            let timeString = String(format: "%02d:%02d", minutes, seconds)
            self.onTick?(timeString)
            
            if self.timeRemaining <= 0 {
                self.timer?.invalidate()
                self.onFinished?()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
}

