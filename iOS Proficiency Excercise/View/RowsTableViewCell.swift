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
        mainBgView.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant: 8).isActive = true
        mainBgView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,constant: 8).isActive = true
        mainBgView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,constant: -8).isActive = true
        mainBgView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor,constant: -8).isActive = true
        
        mainBgView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo:mainBgView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:mainBgView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:mainBgView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        mainBgView.addSubview(imageRefView)
        let leftSpacing = (self.contentView.frame.size.width/3)/2
        imageRefView.topAnchor.constraint(equalTo:titleLabel.bottomAnchor,constant: 0).isActive = true
        imageRefView.leadingAnchor.constraint(equalTo:mainBgView.leadingAnchor,constant: leftSpacing).isActive = true
        imageRefView.trailingAnchor.constraint(equalTo:mainBgView.trailingAnchor,constant: -leftSpacing).isActive = true
        imageRefView.heightAnchor.constraint(equalToConstant:150).isActive = true
        
        mainBgView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo:imageRefView.bottomAnchor,constant: 0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:mainBgView.leadingAnchor,constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:mainBgView.trailingAnchor,constant: -8).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo:mainBgView.bottomAnchor,constant: -8).isActive = true

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
