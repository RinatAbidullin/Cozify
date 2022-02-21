//
//  DispatchTimeInterval+ToTimeInterval.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import Foundation

public extension DispatchTimeInterval {
    func toTimeInterval() -> TimeInterval? {
        var result: TimeInterval?

        switch self {
        case .seconds(let value):
            result = TimeInterval(value)
        case .milliseconds(let value):
            result = TimeInterval(value) * 0.001
        case .microseconds(let value):
            result = TimeInterval(value) * 0.000001
        case .nanoseconds(let value):
            result = TimeInterval(value) * 0.000000001
        case .never:
            result = nil
        @unknown default:
            result = nil
        }

        return result
    }
}
