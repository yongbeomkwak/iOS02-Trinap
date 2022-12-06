//
//  DefaultCancelReservationRequestUseCase.swift
//  Trinap
//
//  Created by 김세영 on 2022/12/04.
//  Copyright © 2022 Trinap. All rights reserved.
//

import RxSwift

final class DefaultCancelReservationRequestUseCase: CancelReservationRequestUseCase {
    
    // MARK: - Properties
    private let repository: ReservationRepository
    
    // MARK: - Initializers
    init(repository: ReservationRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    func execute(reservation: Reservation) -> Observable<Reservation> {
        return repository.updateReservationStatus(reservationId: reservation.reservationId, status: .cancel)
            .map { _ in
                var mutableReservation = reservation
                
                mutableReservation.status = .cancel
                return mutableReservation
            }
    }
}
