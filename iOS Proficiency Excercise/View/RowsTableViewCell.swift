//
//  RowsTableViewCell.swift
//  iOS Proficiency Excercise
//
//  Created by Vino on 4/7/20.
//  Copyright © 2020 Vino. All rights reserved.
//

import UIKit

/**
The RowsTableViewCell used to create the tilte,Image and description for UITableView
*/
class RowsTableViewCell: UITableViewCell {
    let mainBgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 0
        label.backgroundColor =  UIColor.clear
        label.textAlignment = .center
        label.textColor =  UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let imageRefView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // without this your image will shrink and looks ugly
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 0
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.backgroundColor =  UIColor.clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(mainBgView)
        NSLayoutConstraint.activate([
        mainBgView.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant: 8),
        mainBgView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,constant: 8),
        mainBgView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,constant: -8),
        mainBgView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor,constant: -8)
            ])
        
        mainBgView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo:mainBgView.topAnchor),
        titleLabel.leadingAnchor.constraint(equalTo:mainBgView.leadingAnchor),
        titleLabel.trailingAnchor.constraint(equalTo:mainBgView.trailingAnchor),
        titleLabel.heightAnchor.constraint(equalToConstant:40)
            ])
        
        mainBgView.addSubview(imageRefView)
        let leftSpacing = (self.contentView.frame.size.width/3)/2
        NSLayoutConstraint.activate([
        imageRefView.topAnchor.constraint(equalTo:titleLabel.bottomAnchor,constant: 0),
        imageRefView.leadingAnchor.constraint(equalTo:mainBgView.leadingAnchor,constant: leftSpacing),
        imageRefView.trailingAnchor.constraint(equalTo:mainBgView.trailingAnchor,constant: -leftSpacing),
        imageRefView.heightAnchor.constraint(equalToConstant:150)
        ])
        
        mainBgView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
        descriptionLabel.topAnchor.constraint(equalTo:imageRefView.bottomAnchor,constant: 0),
        descriptionLabel.leadingAnchor.constraint(equalTo:mainBgView.leadingAnchor,constant: 8),
        descriptionLabel.trailingAnchor.constraint(equalTo:mainBgView.trailingAnchor,constant: -8),
        descriptionLabel.bottomAnchor.constraint(equalTo:mainBgView.bottomAnchor,constant: -8)
        ])

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
