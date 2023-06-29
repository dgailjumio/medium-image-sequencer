//
//  ImageCopy.swift
//  Image Sequencer
//
//  Created by Dominik Gail on 04.05.23.
//

import CoreMedia

class ImageCopy {
    
    static func copy(buffer pixelBuffer: CVPixelBuffer, destrided: Bool = true) -> Data {
        let pixelFormat = CVPixelBufferGetPixelFormatType(pixelBuffer)
        guard pixelFormat == kCVPixelFormatType_32BGRA else { return Data() }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly) }
        guard let baseAddr = CVPixelBufferGetBaseAddress(pixelBuffer) else { return Data() }
        
        var data = Data()
        let bytesPerPixel = 4
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let copiedWidth = destrided ? width * bytesPerPixel : bytesPerRow
        
        var uintBaseAddr = baseAddr.assumingMemoryBound(to: UInt8.self)
        for _ in 1...height {
            data.append(uintBaseAddr, count: copiedWidth)
            uintBaseAddr = uintBaseAddr.advanced(by: bytesPerRow)
        }
        
        return data
    }
    
}
