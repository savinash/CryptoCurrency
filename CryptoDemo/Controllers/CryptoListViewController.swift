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
    private var cryptoListVM : CryptoListViewModel!
    let refreshControl = UIRefreshControl()
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting delegate to cryptoListViewModel
        cryptoListVM = CryptoListViewModel()
        cryptoListVM.delegate = self
        // Adding refresh controller to tableview
        refreshControl.attributedTitle = NSAttributedString(string: Constants.CommonStrings.refeshControllerMessage)
        self.refreshControl.addTarget(self, action: #selector(refreshCryptoListData(_ :)), for: UIControl.Event.valueChanged)
        cryptoTableView.addSubview(refreshControl)
        // Checking the network connectivity
        Reachability.isConnectedToNetwork() ? cryptoListVM.performUpdate() : displayAlert(message: Constants.AlertValues.reachabilityMessage, title: Constants.AlertValues.reachabilityTitle)
        
        activityIndicator = LoadMoreActivityIndicator(scrollView: cryptoTableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Setting the large text style for navigation bar title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Selector method for refreshing the crypto currancy list. Used for refresh controller
    @objc private func refreshCryptoListData(_ sender: Any) {
        // Resetting load more count
        cryptoListVM.resetLoadMoreCount()
        // Checking network connectivity and calling the setup method
        Reachability.isConnectedToNetwork() ? cryptoListVM.performUpdate() : displayAlert(message: Constants.AlertValues.reachabilityMessage, title: Constants.AlertValues.reachabilityTitle)
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
        cryptoDetailsVC.bitcoin = self.cryptoListVM.bitcoins[selectedRow!]
    }
    
    func loadMore(){
        cryptoListVM.performUpdate()
    }
}

/*
 Extension to handle tableView methods
 */
extension CryptoListViewController : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListVM == nil ? 0 : self.cryptoListVM.bitcoins.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CommonStrings.cryptoCellIdentifier, for: indexPath) as? CryptoTableViewCell else {
            fatalError(Constants.CommonStrings.cellNotFoundError)
        }
        let cryptoVM = self.cryptoListVM.bitcoins[indexPath.row]
        cell.configureCell(cellData: cryptoVM)
        if indexPath.row == self.cryptoListVM.bitcoins.count - 1 {
//                self.loadMore()
            }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.CommonStrings.identifierString, sender: tableView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            activityIndicator.start {
                DispatchQueue.global(qos: .utility).async {
                    sleep(3)
                    self.loadMore()
                    DispatchQueue.main.async { [weak self] in
                        self?.activityIndicator.stop()
                    }
                }
            }
        }
}

// Extension for delegate methods of CryptoListViewModelProtocol - response success/failure
extension CryptoListViewController : CryptoListViewModelProtocol {
    func onReceiveResposeSuccess() {
        self.refreshControl.endRefreshing() // End refreshing
        self.cryptoTableView.reloadData()
    }
    
    func onReceiveResponseFailure(error: NSError?) {
        self.refreshControl.endRefreshing()
        self.displayAlert(message: Constants.AlertValues.appErrorMessage, title: Constants.AlertValues.appErrorTitle)
    }
}

