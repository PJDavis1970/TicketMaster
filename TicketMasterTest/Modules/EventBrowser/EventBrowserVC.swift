//
//  EventBrowserVC.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit
import Reachability

//declare this property where it won't go out of scope relative to your listener


class EventBrowserVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var model = EventBrowserViewModel.shared
    let reachability = try! Reachability()
    
    var debounceTimer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EventBrowserTVCell.nib, forCellReuseIdentifier: EventBrowserTVCell.identifier)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func setupUI() {
        
        searchBar.searchTextField.font = UIFont(name: "HelveticaNeue", size: 16)
        
        loadEvents(refresh: true)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        var update = false
        switch reachability.connection {
        case .wifi, .cellular:
            title = "Online Mode"
            update = model.updateOfflineMode(status: false)
        case .unavailable:
            title = "Offline Mode"
            update = model.updateOfflineMode(status: true)
        case .none:
            print("Network not reachable")
        }
        if update {
            loadEvents(refresh: true)
        }
    }
    
    func loadEvents(refresh: Bool) {
        model.updateEvents(refresh: refresh, finished: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, failed: { error in
            DispatchQueue.main.async {

            }
        })
    }
}

extension EventBrowserVC: UISearchBarDelegate {
        
    @objc func updateSearchResults(_ timer: Timer) {
        guard var searchText = timer.userInfo as? String else { return }
        model.searchString = searchText
        if searchText == "" {
            model.searchString = nil
        }
        loadEvents(refresh: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        debounceTimer.invalidate()
        let subString = searchBar.text!
        debounceTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateSearchResults(_:)), userInfo: subString, repeats: false)
    }
}

extension EventBrowserVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.eventData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EventBrowserTVCell.identifier, for: indexPath) as! EventBrowserTVCell
        if indexPath.row >= model.eventData.count { return cell }

        cell.setupUI(event: model.eventData[indexPath.row])
        if model.eventData.count > 1 && model.offlineMode == false {
            let lastElement = model.eventData.count - 1
            if indexPath.row == lastElement {
                loadEvents(refresh: false)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let infoVC = EventBrowserInfoVC()
        infoVC.event = model.eventData[indexPath.row]
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
