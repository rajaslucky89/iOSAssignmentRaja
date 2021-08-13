//
//  Throttler.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import Foundation

class Throttler: NSObject {
    var callback: (() -> ())
    var delay: Double
    weak var timer: Timer?
    
    init(delay: Double, callback: @escaping (() -> ())) {
        self.delay = delay
        self.callback = callback
    }
    
    func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Throttler.back), userInfo: nil, repeats: false)
        timer = nextTimer
    }
    
    @objc func back() {
        self.callback()
    }
}
