//
//  ArtikelTableViewCell.swift
//  DerDieDas
//
//  Created by Şule Kaptan on 10.01.2024.
//

import UIKit

class ArtikelTableViewCell: UITableViewCell {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let artikel: UILabel = {
        let label = UILabel()
        label.text = "der Vogel"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(named: "textColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func addViews(){
        addSubview(stackView)
        stackView.addArrangedSubview(artikel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setArtikelText(_ text: String) {
        let attributedText = NSMutableAttributedString(string: text)

        let firstThreeCharacters = text.prefix(3)
        let firstThreeCharactersRange = NSRange(location: 0, length: min(3, text.count))

        switch firstThreeCharacters {
        case "der":
            attributedText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: firstThreeCharactersRange)
        case "die":
            attributedText.addAttribute(.foregroundColor, value: UIColor.systemRed, range: firstThreeCharactersRange)
        case "das":
            attributedText.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: firstThreeCharactersRange)
        default:
            break
        }
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: NSRange(location: 0, length: min(3, text.count)))

        artikel.attributedText = attributedText
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
