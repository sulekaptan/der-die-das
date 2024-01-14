//
//  CustomPopupViewController.swift
//  DerDieDas
//
//  Created by Şule Kaptan on 10.01.2024.
//

import UIKit

class CustomPopupViewController: UIViewController {
    
    var selectedWord: String = ""
    
    let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "popupColor")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let artikelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: "textColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let translateButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.backgroundColor = .systemFill
        button.setTitle("Translation", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "translate"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.backgroundColor = .systemFill
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "save"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closePopupView))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    func addViews(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(popupView)
        popupView.addSubview(artikelLabel)
        popupView.addSubview(translateButton)
        popupView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 200),
            popupView.heightAnchor.constraint(equalToConstant: 200),
            
            artikelLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 20),
            artikelLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            artikelLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            artikelLabel.heightAnchor.constraint(equalToConstant: 30),
            
            translateButton.topAnchor.constraint(equalTo: artikelLabel.bottomAnchor, constant: 20),
            translateButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 30),
            translateButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -30),
            translateButton.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.topAnchor.constraint(equalTo: translateButton.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func displayWord(_ word: String) {
        selectedWord = word
        artikelLabel.text = word
    }
    
    @objc func closePopupView(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func translateButtonTapped() {
        openTranslationURL(for: selectedWord)
        print("Translate button tapped!")
    }
    
    @objc func saveButtonTapped() {
        // Check if the selected word is not empty before saving
        guard !selectedWord.isEmpty else {
            return
        }

        // Append the selected word to the bookmarks array in UserDefaults
        var bookmarks = UserDefaults.standard.stringArray(forKey: "bookmarks") ?? []
        bookmarks.append(selectedWord)
        UserDefaults.standard.set(bookmarks, forKey: "bookmarks")

        // Close the popup view
        dismiss(animated: true, completion: nil)
        

        print("UserDefaults Bookmarks: \(bookmarks ?? [])")

    }

    
    func openTranslationURL(for artikel: String) {
        if let translatedURL = createTranslationURL(for: artikel) {
            if UIApplication.shared.canOpenURL(translatedURL) {
                UIApplication.shared.open(translatedURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func createTranslationURL(for keyword: String) -> URL? {
        let baseTranslationURL = "https://translate.google.com/?hl=tr&sl=de&tl=en&text="
        if let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let fullURLString = baseTranslationURL + encodedKeyword
            return URL(string: fullURLString)
        }
        return nil
    }
}
