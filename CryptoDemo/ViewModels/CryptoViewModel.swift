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
}

extension CryptoListViewModel {
    func performUpdate(){
        let url = URL(string: Constants.Urls.criptoURL)
        print(Constants.Urls.criptoURL)
        webServiceManager.getCryptoData(url: url, completionHandler: { bitCoinArray, error in
            DispatchQueue.main.async {
                if let bitCoinArray = bitCoinArray {
                    self.bitcoins = bitCoinArray
                    self.delegate?.onReceiveResposeSuccess()
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

