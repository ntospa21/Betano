//
//  CountdownTimer.swift
//  Betano
//
//  Created by Pantos, Thomas on 2/5/23.
//

import SwiftUI

struct CountdownTimerView: View {
    let targetTimestamp: TimeInterval
    @State private var timeRemaining: TimeInterval = 0
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let date = Date(timeIntervalSince1970: targetTimestamp)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .full
        
        return VStack {
            
            if timeRemaining == 0 {
                Text("Out of time")
            } else {
                Text(formatter.string(from: timeRemaining)!)
           .fixedSize(horizontal: false, vertical: true)
                


            }
           
            
            
        }
        .onReceive(timer) { _ in
            let now = Date().timeIntervalSince1970
            timeRemaining = max(0, targetTimestamp - now)
        }
        .onAppear {
            let now = Date().timeIntervalSince1970
            timeRemaining = max(0, targetTimestamp - now)
        }
    }
}

struct Timer2: View {
    let targetTimestamp: TimeInterval = 1656844800 // June 3, 2022 at 12:00 AM UTC
    var body: some View {
        CountdownTimerView(targetTimestamp: targetTimestamp)
            .frame(width: 50, height: 50)
    }
}
