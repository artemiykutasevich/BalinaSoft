//
//  MainViewModel.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import SwiftUI

class MainViewModel: ViewModel, ObservableObject {
    @Published var tapeOfImages = [NetworkImage]()
    
    @Published var currentPage: Int = 0
    @Published var startPagination: Bool = false
    @Published var endPagination: Bool = false
    
    @Published var selectedImage: UIImage?
    @Published var selectedFieldId: Int = 0
    
    @Published var showPicker = false
    @Published var source: Picker.Source = .camera
    
    @Published var showCameraAlert = false
    @Published var cameraError: Picker.CameraErrorType?
    
    let networkManager = NetworkManager.networkManager
    
    init() {
        getRequest()
    }
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
    
    func updateImages() {
        currentPage += 1
        getRequest()
    }
    
    func getRequest() {
        networkManager.getRequest(
            for: currentPage,
            completion: { response in
                switch response {
                case .success(let good):
                    self.tapeOfImages.append(contentsOf: good.tapeOfImages)
                    self.endPagination = good.page >= good.totalPages
                    self.startPagination = false
                case .failure(_):
                    print("Страница не обновилась")
                }
            })
    }
    
    func postRequest() {
        networkManager.postRequest(
            typeId: selectedFieldId,
            name: "Kutasevich Artem",
            photo: selectedImage)
    }
}
