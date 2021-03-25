//
//  SearchInteractor.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchInteractorInput
{
    func fetchBlockDataFromJson()
    func loadBlockDataToLocalStorage(units:[UnitsParse])
    func searchTextInLocalDatabase(searchText: String)
}


class SearchInteractor: SearchInteractorInput
{
    var presenter: SearchPresenter?
    var worker = SearchWorker()
    
    func fetchBlockDataFromJson() {
        worker.getBlockDataFromJson { (units) in
            self.presenter?.presentBlockDataFromJson(units: units)
        }
    }
    
    func loadBlockDataToLocalStorage(units: [UnitsParse]) {
        worker.loadBlockDataToLocalStorage(units: units)
    }
    
    func searchTextInLocalDatabase(searchText: String) {
        let units = worker.searchBlockDataToLocalStorage(searchText: searchText) ?? nil
        self.presenter?.presentSearchResult(units: units)
    }
}