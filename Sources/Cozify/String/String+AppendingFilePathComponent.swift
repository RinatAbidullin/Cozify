//
//  String+AppendingFilePathComponent.swift
//  
//
//  Created by Rinat Abidullin on 03.08.2022.
//

import Foundation

public extension String {
    /// Returns a new string made by appending to the receiver a given string.
    ///
    /// - Parameter filePathComponent: The path component to append to the receiver.
    /// - Returns: A new string made by appending `filePathComponent` to the receiver, preceded if necessary
    /// by a path separator.
    ///
    /// The following table illustrates the effect of this method on a variety of different paths, assuming that `filePathComponent`
    /// is supplied as “scratch.tiff”:
    ///
    /// | Receiver’s String Value      | Resulting String  |
    /// |------|--------|
    /// | ""  | scratch.tiff |
    /// | "/" | /scratch.tiff |
    /// | "tmp" | "tmp/scratch.tiff" |
    /// | "tmp/" | "tmp/scratch.tiff" |
    /// | "/tmp" | "/tmp/scratch.tiff" |
    /// | "/tmp/" | "/tmp/scratch.tiff" |
    ///
    /// Note that this method only works with file paths (not, for example, string representations of URLs).
    func appending(filePathComponent: String) -> String {
        var filePathComponent = filePathComponent
        
        if let firstCharOfPathComponent = filePathComponent.first, firstCharOfPathComponent == "/" {
            filePathComponent = String(filePathComponent.dropFirst())
        }
        
        if self.isEmpty {
            return filePathComponent
        } else if self.last == "/" {
            return self + filePathComponent
        } else {
            return self + "/" + filePathComponent
        }
    }
}
