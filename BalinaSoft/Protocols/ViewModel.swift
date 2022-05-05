//
//  ViewModel.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import SwiftUI

protocol ViewModel {
    var tapeOfImages: [NetworkImage] { get set }
    
    var currentPage: Int { get set }
    var startPagination: Bool { get set }
    var endPagination: Bool { get set }
    
    var selectedImage: UIImage? { get set }
    var selectedFieldId: Int { get set }
    
    var showPicker: Bool { get set }
    var source: Picker.Source { get set}
    
    var showCameraAlert: Bool { get set }
    var cameraError: Picker.CameraErrorType? { get set }
    
    var networkManager: NetworkManager { get }
    
    func getRequest()
    func postRequest()
}
