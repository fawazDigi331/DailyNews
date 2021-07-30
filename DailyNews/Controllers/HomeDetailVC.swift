//
//  HomeDetailVC.swift
//  DailyNews
//
//  Created by Fawaz Faiz on 29/07/2021.
//

import UIKit
import Kingfisher
class HomeDetailVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    {
        didSet {
            titleLabel.font      = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var authorLabel: UILabel!
    {
        didSet {
            authorLabel.font      = UIFont.systemFont(ofSize: 15)
            authorLabel.textColor = UIColor.gray
        }
    }
    @IBOutlet weak var publishedDateLabel: UILabel!{
        didSet {
            publishedDateLabel.font      = UIFont.systemFont(ofSize: 12)
            publishedDateLabel.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    {
        didSet {
            subTitleLabel.font      = UIFont.systemFont(ofSize: 15)
            subTitleLabel.textColor = UIColor.darkText
        }
    }
    @IBOutlet weak var readMoreBtn: UIButton!
    {
        didSet {
            readMoreBtn.setTitle(Strings.readMoreBtnTitle, for: .normal)
            readMoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        }
    }
    var article: Article?
   // var selectedArticle : [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTheDisplay()
    }
    
    func updateTheDisplay(){
        self.titleLabel.text = article?.title
        self.authorLabel.text = article?.byLine
        self.publishedDateLabel.text = article?.publishedDate
        self.subTitleLabel.text = article?.subTitle
        if let url = article?.media.first?.all.last?.url {
            self.coverImage.kf.setImage(with: URL(string: url))
        }
    }
    
    
    @IBAction func readMoreBtnAction(_ sender: Any) {
        guard let urlString = article?.url, let url = URL(string: urlString) else {
            return
        }
        
        // Open the URL in the external browser
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
