//
//  ArticleCell.swift
//  FawasNyNews
//
//  Created by D&C Dev on 20/05/2021.
//

import UIKit
import Kingfisher
class ArticleCell: UITableViewCell {

    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // temp disable the selection of cell style
        self.selectionStyle = .none
        // making thumb image circle
        self.thumbImage.layer.cornerRadius = thumbImage.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Update the Article to the cell components
    func updateCellResult(news: Article?) {
        if let article = news {
            self.titleLabel.text = article.title
            self.authorLabel.text = article.byLine
            self.createdDate.text = article.publishedDate
            if let url = article.media.first?.all.first?.url {
                self.thumbImage.kf.setImage(with: URL(string: url))
            }
        }
    }
    
}
