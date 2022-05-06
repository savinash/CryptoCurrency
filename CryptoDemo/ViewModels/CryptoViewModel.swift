//
//  CryptoViewModel.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation


// Protocol for response status
protocol CryptoListViewModelProtocol {
    func onReceiveResposeSuccess()
    func onReceiveResponseFailure(error : NSError?)
}

/*
 ViewModel for CryptoList
 */
class CryptoListViewModel : NSObject {
    
    let itemsPerBatch = 1
    var offset = 0
    var reachedEndOfItems = false
    var refresh : Bool = false
    
    var bitcoins = [Bitcoin]()
    var delegate : CryptoListViewModelProtocol? = nil
    var webServiceManager = Webservice()

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
    func getResultCountForURL(pageNumber : Int) -> String {
        return "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=10&page=\(pageNumber)&sparkline=false"
    }
    func resetLoadMoreCount(){
        offset = 0
        refresh = true
    }
}

extension CryptoListViewModel {
    
    func performUpdate(){
        
        // don't bother doing another db query if already have everything
            guard !self.reachedEndOfItems else {
                return
            }
        
        let start = self.offset
        let end = self.offset + self.itemsPerBatch
        
        print("Start \(start)")
        print("End \(end)")
        
        let url = URL(string: self.getResultCountForURL(pageNumber: end))
        print(self.getResultCountForURL(pageNumber: end))
        webServiceManager.getCryptoData(url: url, completionHandler: { bitCoinArray, error in
            DispatchQueue.main.async {
                if let bitCoinArray = bitCoinArray {
                    if self.refresh {
                        self.bitcoins = bitCoinArray
                        self.refresh = false
                    }else{
                        self.bitcoins.append(contentsOf: bitCoinArray)
                    }
                    
                    self.delegate?.onReceiveResposeSuccess()
                    self.offset += self.itemsPerBatch
                }else if let error = error {
                    self.delegate?.onReceiveResponseFailure(error: error)
                }
            }
        })
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

