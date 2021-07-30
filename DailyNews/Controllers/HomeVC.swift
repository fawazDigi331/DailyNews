//
//  HomeVC.swift
//  DailyNews
//
//  Created by Fawaz Faiz on 29/07/2021.
//

import UIKit
import Alamofire
import Kingfisher

class HomeVC: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        }
    }
    let refreshControl = UIRefreshControl()
    var articles: [Article] = []
    var selectedArticle : [Article] = []
    var media: [Media] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.customizeUI()
            self.loadArticles(days: 1) // Default call
        }
    }
    // Any customization for this particular viewController
    func customizeUI(){
        navigationController?.navigationBar.topItem?.title = newsTitle.popular.rawValue
        activityIndicator.color = UIColor.custom.smartBlue
        activityIndicator.backgroundColor = UIColor.white
        activityIndicator.layer.cornerRadius = 8
        // refresh control pull to  refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action:  #selector(newApiCall(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func newApiCall(_ sender: AnyObject) {
        loadArticles(days: 7)
        self.refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.homeToDetail {
            if let destinationVC = segue.destination as? HomeDetailVC {
                destinationVC.article = sender as? Article
            }
        }
    }
    
    // ** Setup Action sheet for sorting options ** //
    func openSortActionSheet(){

           let optionMenu = UIAlertController(title: nil, message: "Choose a timeline for articles", preferredStyle: .actionSheet)

           let onedayAction = UIAlertAction(title: "1 Day", style: .default, handler: { (ACTION :UIAlertAction!)in
            self.loadArticles(days: 1)
           })
           let sevendaysAction = UIAlertAction(title: "7 Days", style: .default, handler: { (ACTION :UIAlertAction!)in
            self.loadArticles(days: 7)
           })
        
        let thirtydaysAction = UIAlertAction(title: "30 Days", style: .destructive, handler: { (ACTION :UIAlertAction!)in
            self.loadArticles(days: 30)
           })
               
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           optionMenu.addAction(onedayAction)
           optionMenu.addAction(sevendaysAction)
           optionMenu.addAction(thirtydaysAction)
           optionMenu.addAction(cancelAction)
  
           self.present(optionMenu, animated: true, completion: nil)
    }
    
    // ** Button Actions ** //
    @IBAction func sortBtnAction(_ sender: Any) {
        self.openSortActionSheet()
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
       performSegue(withIdentifier: "searchIdfr", sender: self)
    }
    
    // ** API Calls ** //
    func loadArticles(days: Int){
     
        activityIndicator.startAnimating()
        let url =  UrlDirectory.baseUrl + UrlDirectory.getPopularNewsApi(for: days)
        print(url)
        AF.request(url).validate().responseDecodable(of: Articles.self) { (response) in
            switch response.result {
                case .success:
                    guard let articles = response.value else { return }
                    self.articles = articles.all
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
           }
        }
  
}

// ** TableView Delegates ** //

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return articles.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell

        cell.updateCellResult(news: self.articles[indexPath.row])
  
       return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.performSegue(withIdentifier: Strings.homeToDetail, sender: self.articles[indexPath.row])
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
   }
}
