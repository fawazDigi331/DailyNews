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
    var media: [Media] = []
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.customizeUI()
            self.loadArticles(articleType: "viewed", days: 7) // Default call
        }
    }
    // Any customization for this particular viewController
    func customizeUI(){
        navigationController?.navigationBar.topItem?.title = newsTitle.mostViewed.rawValue // Default call
        activityIndicator.color = UIColor.custom.smartBlue
        activityIndicator.backgroundColor = UIColor.white
        activityIndicator.layer.cornerRadius = 8
        // refresh control pull to  refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action:  #selector(newApiCall(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func newApiCall(_ sender: AnyObject) {
        loadArticles(articleType: "viewed", days: 7)
        navigationController?.navigationBar.topItem?.title = newsTitle.mostViewed.rawValue
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

           let optionMenu = UIAlertController(title: nil, message: "Select an option to sort", preferredStyle: .actionSheet)

           let sharedAction = UIAlertAction(title: "Most Shared", style: .default, handler: { (ACTION :UIAlertAction!)in
            self.loadArticles(articleType: "shared", days: 7)
            
           })
           let emailedAction = UIAlertAction(title: "Most Emailed", style: .default, handler: { (ACTION :UIAlertAction!)in
            self.loadArticles(articleType: "emailed", days: 7)
           })
        
        let viewedAction = UIAlertAction(title: "Most Viewed", style: .destructive, handler: { (ACTION :UIAlertAction!)in
            self.loadArticles(articleType: "viewed", days: 7)
        
           })
        
               
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           optionMenu.addAction(sharedAction)
           optionMenu.addAction(emailedAction)
           optionMenu.addAction(viewedAction)
           optionMenu.addAction(cancelAction)
  
           self.present(optionMenu, animated: true, completion: nil)
    }
    
    // ** Button Actions ** //
    @IBAction func sortBtnAction(_ sender: Any) {
        self.openSortActionSheet()
    }
   
    // ** API Calls ** //
    func loadArticles(articleType: String, days: Int){
        activityIndicator.startAnimating()
        // url elements broke 2 main section base url and endpoint anywhere in the specific call it can be changed as base url live / staging etc if assigned
        switch articleType {
        case "shared":
            url =  "\(UrlDirectory.baseUrl)\(UrlDirectory.getMostSharedNewsApi(for: days))"
            // update the title bar
            self.navigationController?.navigationBar.topItem?.title = newsTitle.mostShared.rawValue
        case "emailed":
            url =  "\(UrlDirectory.baseUrl)\(UrlDirectory.getMostEmailedNewsApi(for: days))"
            // update the title bar
            self.navigationController?.navigationBar.topItem?.title = newsTitle.mostEmailed.rawValue
        case "viewed":
            url =  "\(UrlDirectory.baseUrl)\(UrlDirectory.getMostViewedApi(for: days))"
            // update the title bar
            self.navigationController?.navigationBar.topItem?.title = newsTitle.mostViewed.rawValue
        default:
           break
        }
        
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
