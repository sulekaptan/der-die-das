//
//  GameViewController.swift
//  DerDieDas
//
//  Created by Şule Kaptan on 10.01.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    let correctLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .green
        label.text = "Correct: 0"
        return label
    }()
    
    let wrongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .red
        label.text = "Wrong: 0"
        return label
    }()
    
    
    var currentQuestionIndex = 0
    var correctCount = 0
    var wrongCount = 0
    var artikelData = ArtikelData.data.shuffled()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addViews()
        setupViews()
        nextWord()
    }
    
    func addViews(){
        view.addSubview(questionLabel)
        view.addSubview(optionsStackView)
        view.addSubview(correctLabel)
        view.addSubview(wrongLabel)
        
        optionsStackView.addArrangedSubview(createOptionButton("der"))
        optionsStackView.addArrangedSubview(createOptionButton("die"))
        optionsStackView.addArrangedSubview(createOptionButton("das"))
    }
    
    func setupViews() {
        
        view.backgroundColor = UIColor(named: "bgColor")
        
        
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            optionsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            correctLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            correctLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            wrongLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            wrongLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func createOptionButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "textColor")
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor(named: "bgColor"), for: .normal)
        return button
    }

    
    @objc func optionSelected(_ sender: UIButton) {
        let selectedOption = sender.titleLabel?.text ?? ""
        checkAnswer(selectedOption)
        nextWord()
    }
    
    func checkAnswer(_ selectedOption: String) {
        // Doğru kelimeyi almak için, rastgele bir çifti alıp value'sunu kullanıyoruz.
        let correctWord = artikelData[currentQuestionIndex].value
        
        if selectedOption == correctWord {
            correctCount += 1
        } else {
            wrongCount += 1
            // Burada yanlış seçeneği gösterme işlemi yapılabilir.
        }
        
        updateScoreLabels()
    }

    
    func updateScoreLabels() {
        correctLabel.text = "Correct: \(correctCount)"
        wrongLabel.text = "Wrong: \(wrongCount)"
    }
    
    func nextWord() {
            if currentQuestionIndex < artikelData.count {
                let nextWordPair = artikelData[currentQuestionIndex]
                let nextWord = nextWordPair.key
                questionLabel.text = nextWord
                currentQuestionIndex += 1
            } else {
                finishGame()
            }
        }
    
    func finishGame() {
    }
}
