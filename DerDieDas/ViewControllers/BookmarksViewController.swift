//
//  BookmarksViewController.swift
//  DerDieDas
//
//  Created by Şule Kaptan on 10.01.2024.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var bookmarks: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupViews()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Load bookmarks from UserDefaults
        if let savedBookmarks = UserDefaults.standard.stringArray(forKey: "bookmarks") {
            bookmarks = savedBookmarks
        }
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor) 
        ])
        
        tableView.register(ArtikelTableViewCell.self, forCellReuseIdentifier: "artikelTableViewCell")
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artikelTableViewCell", for: indexPath) as! ArtikelTableViewCell
        
        // Set the cell content with the bookmarked word
        let bookmarkText = bookmarks[indexPath.row]
        cell.setArtikelText(bookmarkText)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookmarks.remove(at: indexPath.row)
            UserDefaults.standard.set(bookmarks, forKey: "bookmarks")
            self.tableView.reloadData()
        }
    }
}

