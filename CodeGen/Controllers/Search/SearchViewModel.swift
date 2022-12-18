//
//  SearchViewModel.swift
//  CodeGen
//
//  Created by Matt Thomas on 18/12/2022.
//

import Foundation

protocol SearchViewModel {
    var delegate: SeachResultsDelegate? { get set }
    func performSearch(searchTerm: String)
}

protocol SeachResultsDelegate {
    func publishResults(results: String)
}

final class SearchViewModelImpl: SearchViewModel {
    
    var delegate: SeachResultsDelegate?
    private let requester = Requester()
    
    func performSearch(searchTerm: String) {
        requester.sendRequest(query: searchTerm, completion: { [weak self] result in
            switch result {
            case .success(let text):
                self?.delegate?.publishResults(results: text)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}
