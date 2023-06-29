//
//  ImageWriter.swift
//  Image Sequencer
//
//  Created by Dominik Gail on 04.05.23.
//

import Foundation

class ImageWriter: FileAccessDelegate {
    
    private var images = [String: Data]()
    private var fileAccess = FileAccess()
    
    init() {
        fileAccess.delegate = self
    }
    
    func writeImageToDisk(image: Data, imageName: String) {
        images[imageName] = image
        fileAccess.createFile(for: imageName)
    }
    
    func createdFile(url: URL, for name: String) {
        try? images[name]?.write(to: url)
        images[name] = nil
    }
    
}
