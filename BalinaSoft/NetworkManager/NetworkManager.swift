//
//  NetworkManager.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import SwiftUI
import Alamofire

typealias JSONDict = [String : Any]

class NetworkManager {
    static let networkManager = NetworkManager()
    private init() { /* Singleton */ }
    
    let baseURL = "https://junior.balinasoft.com"
    let getRequest = "/api/v2/photo/type"
    let postRequest = "/api/v2/photo"
    
    func getRequest(for pageNumber: Int, completion: @escaping (Result<NetworkResponse, Error>) -> Void) {
        let parameters: JSONDict = ["page" : pageNumber]
        guard let url = URL.url(with: baseURL, requestType: getRequest, queryParams: parameters) else {
            completion(.failure(Error.self as! Error))
            return
        }
        
        AF
            .request(url)
            .response { response in
                switch response.result {
                case .success(let data):
                    let responseResult = try! JSONDecoder().decode(NetworkResponse.self, from: data!)
                    completion(.success(responseResult))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func postRequest(typeId: Int, name: String, photo: UIImage?) {
        guard let photo = photo else {
            print("image is nil")
            return
        }
        
        guard let url = URL.url(with: baseURL, requestType: postRequest, queryParams: nil) else {
            return
        }
        
        AF
            .upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(Data(name.utf8), withName: "name")
                    multipartFormData.append(photo.pngData()!, withName: "photo", fileName: "testIMG.png", mimeType: "image/png")
                    multipartFormData.append(Data(typeId.description.utf8), withName: "typeId")
                },
                to: url)
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
