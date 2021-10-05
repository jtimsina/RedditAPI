//
//  FeedTableViewCell.swift
//  InfiniteScrollCodeChallenge
//
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let spacingBetweenCells = 8
    
    static let identifier = "FeedTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("No implementation for init(coder:) ")
    }
    
    lazy private var feedImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var redditNewsTitle: UILabel = {
        let newsTitle = UILabel(frame: .zero)
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.numberOfLines = 0
        newsTitle.textAlignment = .left
        newsTitle.font = UIFont.boldSystemFont(ofSize: CGFloat(customFontSize.boldFontSize))
        
        return newsTitle
    }()
    
    lazy private var redditComments: UILabel = {
        let commentsLabel = UILabel(frame: .zero)
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.numberOfLines = 0
        commentsLabel.textAlignment = .left
        commentsLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(customFontSize.boldFontSize))
        commentsLabel.textColor = .gray
        
        return commentsLabel
    }()
    
    lazy private var redditScore: UILabel = {
        let score = UILabel(frame: .zero)
        score.translatesAutoresizingMaskIntoConstraints = false
        score.numberOfLines = 0
        score.textAlignment = .left
        score.font = UIFont.boldSystemFont(ofSize: CGFloat(customFontSize.boldFontSize))
        score.textColor = .gray
        
        return score
    }()
    
    
//    override func layoutSubviews() {
//        
//        super.layoutSubviews()
//        // spacing between tableViewCells
//        let buttomSpace: CGFloat = 10.00
//        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: buttomSpace, right: 0))
//    }
 
    
    func configureCell(title: String?, score: String?, numComments: String?, imageData: Data?) {
        let formattedText = TextUtilities()
        
        setUpUI(imageData: imageData)
        
        redditNewsTitle.text = title
        redditComments.attributedText = formattedText.getTextAndImageForComment(comments: numComments)
        redditScore.attributedText = formattedText.getTextAndImageForScore(score: score)
      
        feedImageView.image = nil
        if let data = imageData {
            feedImageView.image = UIImage(data: data)
        }
    }
    
    private func setUpUI(imageData: Data? = nil) {
        
        //Vertical Stack for: newsTitle, imageView,
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.alignment = .leading
        vStackView.spacing = CGFloat(customFontSize.spacingBetweenViews)
        
        vStackView.addArrangedSubview(redditNewsTitle)
        if let _ = imageData {
            vStackView.addArrangedSubview(feedImageView)
        }
        //horizantal Stack for : Score, Comments, Share
        //subView of Vertical Stack View
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.distribution = .fill
        hStackView.alignment = .top
        hStackView.spacing = CGFloat(customFontSize.spacingBetweenViews)
        hStackView.addArrangedSubview(redditScore)
        hStackView.addArrangedSubview(redditComments)
        
        vStackView.addArrangedSubview(hStackView)
        contentView.addSubview(vStackView)
        
        setVStackViewConstraints(vStackView: vStackView)

    }
    
    private func setVStackViewConstraints(vStackView: UIStackView){
        vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18.0).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18.0).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18.0).isActive = true
    }
    
}

