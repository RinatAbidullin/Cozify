//
//  FirstlyThrottler.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import Foundation

public class FirstlyThrottler {
    var lastFire: TimeInterval = 0
    
    public init() {}
   
    public func throttleFirst(
        delay: DispatchTimeInterval,
        queue: DispatchQueue = .main,
        action: @escaping (() -> Void)
    ) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            let delayAsTimeInterval = delay.toTimeInterval() ?? 0
            if delayAsTimeInterval.hasPassed(since: self.lastFire) {
                queue.async {
                    action()
                }
                self.lastFire = Date().timeIntervalSinceReferenceDate
            }
        }
    }
}
