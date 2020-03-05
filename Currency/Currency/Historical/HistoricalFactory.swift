//
//  HistoricalFactory.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import Service

public final class HistoricalFactory {
    public static func make() -> UIViewController {
        let router = HistoricalRouter()
        let service = HistoricalService(requester: HttpRequest())
        let presenter = HistoricalPresenter(router: router)
        let interactor = HistoricalInteractor(service: service, presenter: presenter)
        let viewController = HistoricalViewController(interactor: interactor)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
