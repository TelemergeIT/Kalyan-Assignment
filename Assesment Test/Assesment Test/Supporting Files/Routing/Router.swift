//
//  Router.swift
//  FAAST
//
//  Created by Kalyan Thakur on 24/04/20.
//  Copyright © 2020 FAAST. All rights reserved.
//

import Foundation
protocol Router {
    associatedtype RoutingViewController
    var viewController: RoutingViewController! { get }
}
