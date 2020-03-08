//
//  HistoricalRouterTests.swift
//  CurrencyTests
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import XCTest
import Service
@testable import Currency

private final class NavigationControllerMock: UINavigationController {
    private(set) var pushViewControllerCallCount = 0
    private(set) var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCallCount += 1
        pushedViewController = viewController
    }
}

final class HistoricalRouterTests: XCTestCase {
    // MARK: - Variables
    private let viewController = UIViewController()
    private lazy var navigationController = NavigationControllerMock(rootViewController: viewController)
    private lazy var router: HistoricalRouting = {
        let router = HistoricalRouter()
        router.viewController = viewController
        return router
    }()
    
    // MARK: - routeDetail
    func testRouteDetail_ShouldCallPushViewControllerAndThePushedControlleNotNil() {
        let criptoCurrency = CriptoCurrency(rates: [.usd: 1.0])
        let currencies = Currencies(rates: [.eur: 2.0])
        let date = Date()
        router.routeDetail(with: criptoCurrency, currencies: currencies, date: date)
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
        XCTAssertNotNil(navigationController.pushedViewController)
    }
}
