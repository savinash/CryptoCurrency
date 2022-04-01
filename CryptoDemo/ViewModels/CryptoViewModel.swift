//
//  CryptoViewModel.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation


// Push the code on feature branch
protocol CrytoListViewModelProtocol {
    func onReceiveResposeSuccess()
    func onReceiveResponseFailure(error : NSError?)
}

/*
 ViewModel for CryptoList
 */
struct CryptoListViewModel {
    
    var bitcoins = [Bitcoin]()
    
    var numberOfSections : Int {
        return 1
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.bitcoins.count
    }
    func bitcoinAtIndex(_ index: Int) -> CryptoViewModel {
        let bitcoin = self.bitcoins[index]
        return CryptoViewModel(bitcoin)
    }
    
    
}

/*
 ViewModel for single Cryto item
 */
struct CryptoViewModel {
    private let bitcoin : Bitcoin
    init(_ bitcoin : Bitcoin) {
        self.bitcoin = bitcoin
    }
}

