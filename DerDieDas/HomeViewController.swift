//
//  ViewController.swift
//  DerDieDas
//
//  Created by Şule Kaptan on 10.01.2024.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Wortsuche"
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var filteredData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupViews()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func addViews(){
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }

    func setupViews() {
        view.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
        tableView.register(ArtikelTableViewCell.self, forCellReuseIdentifier: "artikelTableViewCell")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredData = filterData(for: searchText)
            if !filteredData.isEmpty {
                tableView.reloadData()
            } else {
                tableView.reloadData()
            }
        }

        func filterData(for searchText: String) -> [String] {
            var filteredData: [String] = []
            for (key, value) in ArtikelData.data {
                if key.lowercased().contains(searchText.lowercased()) {
                    let result = "\(value) \(key)"
                    filteredData.append(result)
                }
            }
            return filteredData
        }
        
    func extractArtikel(from result: String) -> String? {
        let components = result.components(separatedBy: " ")
        if components.count > 0 {
            return components.joined(separator: " ")
        }
        return nil
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artikelTableViewCell") as! ArtikelTableViewCell
        let result = filteredData[indexPath.row]
        if extractArtikel(from: result) != nil {
            cell.setArtikelText(result)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let artikel = extractArtikel(from: filteredData[indexPath.row]) {
            let customPopupVC = CustomPopupViewController()
            customPopupVC.modalPresentationStyle = .overFullScreen
            customPopupVC.displayWord(artikel)
            present(customPopupVC, animated: true, completion: nil)
        }
    }
}
