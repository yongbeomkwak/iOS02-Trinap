//
//  DefaultEditPortfolioPictureUseCase.swift
//  Trinap
//
//  Created by kimchansoo on 2022/11/17.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import RxSwift

final class DefaultEditPortfolioPictureUseCase: EditPortfolioPictureUseCase {
    
    // MARK: Properties
    private let photographerRepository: PhotographerRepository
    
    init(photographerRepository: PhotographerRepository) {
        self.photographerRepository = photographerRepository
    }
    
    // MARK: Methods
    func deletePortfolioPictures(photographer: Photographer, indices: [Int]) -> Observable<Void> {
        let photos = photographer.pictures
            .enumerated()
            .filter { index, _ in
                if indices.contains(index) { return false }
                return true
            }
            .map { $1 }
        
        let updated = Photographer(
            photographerId: photographer.photographerId,
            photographerUserId: photographer.photographerUserId,
            location: photographer.location,
            introduction: photographer.introduction,
            tags: photographer.tags,
            pictures: photos,
            pricePerHalfHour: photographer.pricePerHalfHour,
            possibleDate: photographer.possibleDate
        )
        
        return photographerRepository
            .updatePhotograhperInformation(with: updated)
    }
}
