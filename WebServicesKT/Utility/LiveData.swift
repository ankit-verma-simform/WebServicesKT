//
//  LiveData.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import Foundation

class LiveData<T> {
    // MARK: - Typealias
    typealias Listener = (T) -> Void
    
    // MARK: - Vars & Lets
    var listener: Listener?
    var value: T {
        didSet {
            self.fire()
        }
    }
    
    // MARK: - Initialization
    init(_ v: T) {
        value = v
    }
    
    // MARK: - Public Functions
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func fire() {
        self.listener?(value)
    }
}
