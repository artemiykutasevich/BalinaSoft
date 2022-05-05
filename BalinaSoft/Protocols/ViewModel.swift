//
//  ViewModel.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import Foundation

protocol ViewModel {
    var tapeOfImages: [NetworkImage] { get set }
    
    var currentPage: Int { get set }
    var startPagination: Bool { get set }
    var endPagination: Bool { get set }
}
