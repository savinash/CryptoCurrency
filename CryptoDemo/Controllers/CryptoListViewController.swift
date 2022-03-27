//
//  CryptoListViewController.swift
//  CryptoDemo
//
//  Created by Avinash Kumar on 23/03/22.
//

import Foundation
import UIKit

/*
 Class to display the Crypto currenty lists. It has tableview to disaplay the crypto currency list
 */
class CryptoListViewController: UIViewController {
    
    @IBOutlet weak var cryptoTableView: UITableView!
    private var cryptoList : CryptoListViewModel!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding refresh controller to tableview
        refreshControl.attributedTitle = NSAttributedString(string: Constants.CommonStrings.refeshControllerMessage)
        self.refreshControl.addTarget(self, action: #selector(refreshCryptoListData(_ :)), for: UIControl.Event.valueChanged)
        cryptoTableView.addSubview(refreshControl)
        // Checking the network connectivity
        Reachability.isConnectedToNetwork() ? self.setup() : displayAlert(message: Constants.AlertValues.reachabilityMessage, title: Constants.AlertValues.reachabilityTitle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Setting the large text style for navigation bar title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Selector method for refreshing the crypto currancy list. Used for refresh controller
    @objc private func refreshCryptoListData(_ sender: Any) {
        // Checking network connectivity and calling the setup method
        Reachability.isConnectedToNetwork() ? self.setup() : displayAlert(message: Constants.AlertValues.reachabilityMessage, title: Constants.AlertValues.reachabilityTitle)
    }
    
    // Method to call webservice and fetch the crypto currency list
    private func setup(){
        let url = URL(string: Constants.Urls.criptoURL)
        Webservice().getCryptoData(url: url) { bitCoinArray, error  in
            DispatchQueue.main.async {
                if let bitCoinArray = bitCoinArray {
                    self.cryptoList = CryptoListViewModel(bitcoins: bitCoinArray)
                    self.cryptoTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }else if let error = error {
                    print(error)
                    self.displayAlert(message: Constants.AlertValues.appErrorMessage, title: Constants.AlertValues.appErrorTitle)
                }
            }
        }
    }
    
    // Method to show CryptoDetailsViewController with the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController else{
            fatalError(Constants.CommonStrings.navigationError)
        }
        guard let cryptoDetailsVC = nav.viewControllers.first as? CryptoDetailsViewController else{
            fatalError(Constants.CommonStrings.controllerError)
        }
        let indexPath = self.cryptoTableView.indexPathForSelectedRow
        let selectedRow = indexPath?.row
        // Setting up the bitcoin model property declared in CryptoDetailsViewController
        cryptoDetailsVC.bitcoin = self.cryptoList.bitcoins[selectedRow!]
    }
}

/*
 Extension to handle tableView methods
 */
extension CryptoListViewController : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoList == nil ? 0 : self.cryptoList.bitcoins.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CommonStrings.cryptoCellIdentifier, for: indexPath) as? CryptoTableViewCell else {
            fatalError(Constants.CommonStrings.cellNotFoundError)
        }
        let cryptoVM = self.cryptoList.bitcoins[indexPath.row]
        cell.configureCell(cellData: cryptoVM)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.CommonStrings.identifierString, sender: tableView)
    }
}

