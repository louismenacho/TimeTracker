//
//  EntriesViewController.swift
//  TimeTracker
//
//  Created by Louis Menacho on 4/12/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

class EntriesViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
}

// MARK: - UISearchBarDelegate

extension EntriesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
    }
}


// MARK: - UITableViewDataSource

extension EntriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath)
        return cell
    }
}


// MARK: - UITableViewDelegate

extension EntriesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let titleLabel = UILabel()
        titleLabel.frame = view.bounds
        titleLabel.textColor = #colorLiteral(red: 0.3254901961, green: 0.3529411765, blue: 0.431372549, alpha: 1)
        titleLabel.text = "April 17, 2019"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize, weight: .semibold)
        view.addSubview(titleLabel)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
