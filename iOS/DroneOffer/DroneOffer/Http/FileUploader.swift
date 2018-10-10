//
//  FileUploader.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import UIKit

class FileUploader {
    
    class func post(url: String, fileDataName: String, fileData: Data, params: [String: String], completion: @escaping ((Bool) -> ())) {
        
        var body = Data()
        
        for (key, value) in params {
            if let data = "--boundary\r\nContent-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)\r\n".data(using: .utf8) {
                body.append(data)
            }
        }
        if let data = ("--boundary\r\nContent-Disposition: form-data; name=\"" + fileDataName + "\"; filename=\"" + fileDataName + "\"\r\nContent-Type: image/png\r\n\r\n").data(using: .utf8) {
            body.append(data)
        }
        body.append(fileData)
        
        if let data = "\r\n\r\n--boundary--\r\n\r\n".data(using: .utf8) {
            body.append(data)
        }
        
        let additionalHeader = ["Content-Type": "multipart/form-data; boundary=boundary"]
        
        HttpManager.request(url: url, method: "POST", body: body, additionalHeader: additionalHeader) { (result, data) in
            if result, let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any> {
                        if json["result"] as? String == "0" {
                            completion(true)
                            return
                        }
                    }
                } catch {}
            }
            completion(false)
        }
    }
}
