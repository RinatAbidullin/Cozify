//
//  Debouncer.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import Foundation

public class Debouncer {
    var currentWorkItem: DispatchWorkItem?
    
    public init() {}

    public func debounce(
        delay: DispatchTimeInterval,
        queue: DispatchQueue = .main,
        action: @escaping (() -> Void)
    ) -> () -> Void {
        return {  [weak self] in
            guard let self = self else { return }
            self.currentWorkItem?.cancel()
            self.currentWorkItem = DispatchWorkItem { action() }
            queue.asyncAfter(deadline: .now() + delay, execute: self.currentWorkItem!)
        }
    }
}
