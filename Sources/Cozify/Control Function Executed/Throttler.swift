//
//  Throttler.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import Foundation

public class Throttler {
    var currentWorkItem: DispatchWorkItem?
    var lastFire: TimeInterval = 0
    
    public init() {}
   
    public func throttle(
        delay: DispatchTimeInterval,
        queue: DispatchQueue = .main,
        action: @escaping (() -> Void)
    ) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            guard self.currentWorkItem == nil else { return }
            self.currentWorkItem = DispatchWorkItem {
                action()
                self.lastFire = Date().timeIntervalSinceReferenceDate
                self.currentWorkItem = nil
            }
            let delayAsTimeInterval = delay.toTimeInterval() ?? 0
            delayAsTimeInterval.hasPassed(since: self.lastFire)
            ? queue.async(execute: self.currentWorkItem!)
            : queue.asyncAfter(
                deadline: .now() + delayAsTimeInterval,
                execute: self.currentWorkItem!
            )
        }
    }
}
