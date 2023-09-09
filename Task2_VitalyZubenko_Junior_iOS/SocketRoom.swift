//
//  SocketRoom.swift
//  Task2_VitalyZubenko_Junior_iOS
//
//  Created by Vitaly Zubenko on 08.09.2023.
//

import UIKit

class SocketRoom: NSObject {
    
    var inStream: InputStream!
    var outStream: OutputStream!
    
    var username = ""
    
    let maxReadLength = 1000
    
    func setNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as CFString, 3000, &readStream, &writeStream)
        
        inStream = readStream!.takeRetainedValue()
        outStream = writeStream!.takeRetainedValue()
    }
}
