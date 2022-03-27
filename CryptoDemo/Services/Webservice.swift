//
//  Webservice.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation
import UIKit

/*
 Class for calling web service and getting list of crypto rates
 */
class Webservice : NSObject {
    
    var session: URLSession?
    // Method to get crypto rates with URL which returns array of Bitcoin model
    func getCryptoData( url : URL?, completionHandler: @escaping ( _ data : [Bitcoin]?, _ error : NSError? ) -> Void) {
        guard let url = url else {
            return
        }
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        session?.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do { // decoded using Bitcoin
                    let bitcoins = try JSONDecoder().decode([Bitcoin].self, from: data)
                    completionHandler(bitcoins, nil)
                } catch let error as NSError{ // Returning data as nil and error in case of error occured 
                    completionHandler(nil, error)
                }
            }
        }.resume()
    }
}

// NSURLSession delegate method
extension Webservice: URLSessionDelegate{
    // Method to receive the download the certificate and comparing with local bundle certificate
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil);
            return
        }
        
        let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)
        
        // SSL Policies for domain name check
        let policy = NSMutableArray()
        policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
        
        //evaluate server certifiacte
        let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
        
        //Local and Remote certificate Data
        let remoteCertificateData:NSData =  SecCertificateCopyData(certificate!)
        let pathToCertificate = Bundle.main.path(forResource: "api.coingecko.com", ofType: "cer")
        let localCertificateData:NSData = NSData(contentsOfFile: pathToCertificate!)!
        //Compare certificates
        if(isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData as Data)){
            let credential:URLCredential =  URLCredential(trust:serverTrust)
            print("Certificate pinning is successfully completed")
            completionHandler(URLSession.AuthChallengeDisposition.useCredential,credential)
        }
        else {
            DispatchQueue.main.async {
                print("Certificate matching error...")
            }
            completionHandler(.cancelAuthenticationChallenge,nil)
        }
    }
}
