//
//  ImageConverter.swift
//  Image Sequencer
//
//  Created by Dominik Gail on 04.05.23.
//

import CoreImage

class Image {
    
    private var width: Int
    private var height: Int
    private var rawData: Data
    
    init(rawData: Data, width: Int, height: Int) {
        self.rawData = rawData
        self.width = width
        self.height = height
    }
    
    func jpegRepresentation() -> Data {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let ciImage = CIImage(bitmapData: rawData,
                              bytesPerRow: 4 * width,
                              size: CGSize(width: width, height: height),
                              format: .BGRA8,
                              colorSpace: colorSpace)
        
        return CIContext().jpegRepresentation(of: ciImage, colorSpace: colorSpace, options: [kCGImageDestinationLossyCompressionQuality as CIImageRepresentationOption: 0.8]) ?? Data()
    }
    
}
