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
        Task {
            do {
                try await fetchImages()
            } catch let error {
                print(error.localizedDescription)
            }
        }
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
        Task {
            do {
                try await fetchImages()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchImages() async throws {
        guard let url = URL(string: "https://junior.balinasoft.com/api/v2/photo/type?page=\(currentPage)") else { return }
        let response = try await URLSession.shared.data(from: url)
        let networkResponse = try JSONDecoder().decode(NetworkResponse.self, from: response.0)
        await MainActor.run(body: {
            tapeOfImages.append(contentsOf: networkResponse.tapeOfImages)
            
            endPagination = networkResponse.page >= networkResponse.totalPages
            startPagination = false
        })
    }
    
    func postRequest() {
        networkManager.postRequest(
            typeId: selectedFieldId,
            name: "Kutasevich Artem",
            photo: selectedImage)
    }
}
