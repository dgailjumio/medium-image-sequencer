//
//  ImageStore.swift
//  Image Sequencer
//
//  Created by Dominik Gail on 04.05.23.
//

import Foundation

class ImageStore {
    
    private var store = [Image]()
    private var storeLock = NSLock()
    
    func store(image: Image) {
        storeLock.lock()
        defer { storeLock.unlock() }
        
        store.append(image)
    }
    
    func writeImages(completion: (()->())? = nil) {
        let imageWriter = ImageWriter()
        let time = Date().timeIntervalSince1970
        store.enumerated().forEach { index, image in
            imageWriter.writeImageToDisk(image: image.jpegRepresentation(), imageName: "IMAGE_\(time)_\(index)")
        }

        store.removeAll()
        completion?()
    }
    
    func size() -> Int {
        return store.count
    }
    
}
