//
//  MainView.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if !viewModel.tapeOfImages.isEmpty, let images = viewModel.tapeOfImages {
                    ScrollView {
                        ForEach(images) { element in
                            NetworkImageView(networkImage: element)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 3, y: 3)
                                .shadow(color: .white.opacity(0.5), radius: 4, x: -3, y: -3)
                                .onTapGesture {
                                    viewModel.selectedFieldId = element.id
                                    viewModel.showPhotoPicker()
                                }
                                .onAppear() {
                                    if images.last?.id == element.id {
                                        viewModel.startPagination = true
                                    }
                                }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        
                        if viewModel.startPagination && !viewModel.endPagination {
                            ProgressView()
                                .offset(y: -15)
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        viewModel.updateImages()
                                    }
                                }
                        }
                    }
                    .background(Color.gray.opacity(0.3).ignoresSafeArea())
                } else {
                    ProgressView()
                }
            }
            .onChange(of: viewModel.selectedImage) { _ in
                viewModel.postRequest()
            }
            .sheet(isPresented: $viewModel.showPicker) {
                ImagePicker(
                    sourceType: viewModel.source == .photoLibrary ? .photoLibrary : .camera,
                    selectedImage: $viewModel.selectedImage)
            }
            .alert(
                viewModel.cameraError?.message ?? "error",
                isPresented: $viewModel.showCameraAlert,
                actions: {
                    Button(role: .cancel, action: {
                        viewModel.source = .photoLibrary
                        viewModel.showPhotoPicker()
                    }, label: {
                        Text("open gallery")
                    })
                    Button(role: .destructive, action: {}, label: {
                        Text("ok")
                    })
                })
            .navigationTitle("Main")
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
