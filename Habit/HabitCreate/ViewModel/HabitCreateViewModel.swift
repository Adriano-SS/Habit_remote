//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by Adriano on 21/12/23.
//

import Foundation
import SwiftUI
import Combine
import PhotosUI

class HabitCreateViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    @Published var name: String = ""
    @Published var label: String = ""
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = nil
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {
        
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }

    func save() {
        self.uiState = .loading
        
        cancellable = interactor.save(habitCreateRequest: HabitCreateRequest(imageData: imageData, name: self.name, label: self.label))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: {
                self.uiState = .success
                self.habitPublisher?.send(true)
            })
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else {
            return
        }
        Task { @MainActor in
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let selectedImage = UIImage(data: data) {
                    
                    let widthImage: CGFloat = 420.0
                    let canvasImage = CGSize(width: widthImage, height: CGFloat(ceil(
                        widthImage / selectedImage.size.width * selectedImage.size.height)))
                    
                    let imgResized = UIGraphicsImageRenderer(size: canvasImage, format: selectedImage.imageRendererFormat).image { _ in
                        selectedImage.draw(in: CGRect(origin: .zero, size: canvasImage))
                    }
                    
                    self.image = Image(uiImage: imgResized)
                    self.imageData = imgResized.jpegData(compressionQuality: 0.2)
                    return
                }
            }
        }
    }
}
