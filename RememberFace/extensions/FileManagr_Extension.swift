//
//  FileManagr_Extensiom.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 16/01/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
