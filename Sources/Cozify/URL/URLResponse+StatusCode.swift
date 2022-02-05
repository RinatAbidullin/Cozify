//
//  URLResponse+StatusCode.swift
//  
//
//  Created by Rinat Abidullin on 06.02.2022.
//

import Foundation

public extension URLResponse {
    var statusCode: Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
