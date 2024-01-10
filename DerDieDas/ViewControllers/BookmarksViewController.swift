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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupViews()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addViews(){
        view.addSubview(tableView)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
        tableView.register(ArtikelTableViewCell.self, forCellReuseIdentifier: "artikelTableViewCell")
    }


}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artikelTableViewCell") as! ArtikelTableViewCell
        
        return cell
    }
    
    
}
