//
//  SearchBar.swift
//  TimeTracker
//
//  Created by Louis Menacho on 4/12/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

@IBDesignable
class SearchBar: UISearchBar {

    override func awakeFromNib() {
        prepareView()
    }

    override func prepareForInterfaceBuilder() {
        prepareView()
    }
    
    func prepareView() {
        layer.borderWidth = 1
        layer.borderColor = barTintColor?.cgColor
        
        guard let searchField = value(forKey: "searchField") as? UITextField else { return }
        searchField.clipsToBounds = true
        searchField.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        searchField.layer.cornerRadius = 18
    }
}
