//
//  NetworkManager.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import SwiftUI
import Alamofire

class NetworkManager {
    static let networkManager = NetworkManager()
    private init() { /* Singleton */ }
    
    let basicURL = "https://junior.balinasoft.com"
    
    func postRequest(typeId: Int, name: String, photo: UIImage?) {
        guard let photo = photo else {
            print("image is nil")
            return
        }
        
        AF
            .upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(Data(name.utf8), withName: "name")
                    multipartFormData.append(photo.pngData()!, withName: "photo", fileName: "testIMG.png", mimeType: "image/png")
                    multipartFormData.append(Data(typeId.description.utf8), withName: "typeId")
                },
                to: "https://junior.balinasoft.com/api/v2/photo")
            .uploadProgress { progress in
                print(progress)
            }
            .cURLDescription { description in
                print(description)
            }
            .response { response in
                debugPrint(response)
            }
    }
}
