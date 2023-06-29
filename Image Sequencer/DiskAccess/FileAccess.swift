//
//  FileAccess.swift
//  Image Sequencer
//
//  Created by Dominik Gail on 04.05.23.
//

import Foundation

protocol FileAccessDelegate {
    func createdFile(url: URL, for name: String)
}

class FileAccess {
    
    var delegate: FileAccessDelegate?
    
    func createFile(for name: String) {
        let url = fileURL(for: name)
        ensureFileExists(at: url)
        delegate?.createdFile(url: url, for: name)
    }
    
    private func fileURL(for imageName: String) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = URL(fileURLWithPath: paths[0].path)
        return url.appendingPathComponent("\(imageName).jpeg")
    }
    
    private func ensureFileExists(at url: URL) {
        let fileExists = FileManager.default.fileExists(atPath: url.path)
        if !fileExists {
            try? "".write(to: url, atomically: true, encoding: .utf8)
        }
    }
    
}
