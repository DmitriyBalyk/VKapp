//
//  NewsController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 14.07.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

final class NewsViewBounds: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}
class NewsController: UITableViewController {
    
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var refreshControll:  UIRefreshControl?
    let apiNews = VkApiController()
    var newsArray = [NewsFeed]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeedTableView.prefetchDataSource = self
        apiNews.getNews(startFrom: "") { [weak self] news in
            self?.newsArray = news
            DispatchQueue.main.async {
                self?.newsFeedTableView.reloadData()
            }
        }
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControll?.tintColor = .red
        refreshControll?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        newsFeedTableView.refreshControl = refreshControl
    }
    
    @objc func refreshNews() {
        refreshControl?.beginRefreshing()
        let mostFreshNews = newsArray.first?.date ?? Int(Date().timeIntervalSince1970)
        apiNews.getNews(startFrom: String(mostFreshNews)) { [weak self] news in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.refreshControll?.endRefreshing()
            }
            guard news.count > 0 else { return }
            self.newsArray = news + self.newsArray
            let indexPathes = news.enumerated().map { offset, element in
                IndexPath(row: offset, section: 0)
            }
            DispatchQueue.main.async {
                self.newsFeedTableView.insertRows(at: indexPathes, with: .automatic)
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let new = newsArray[indexPath.row]
        cell.configure(with: new)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension NewsController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: isLoadingCell(for:)) else {
            return
        }
        
        apiNews.getNews(startFrom: Session.instance.baseUrl) { [weak self] news in
            guard let self = self else { return }
            self.newsArray = self.newsArray + news
            DispatchQueue.main.async {
                self.newsFeedTableView.reloadData()
            }
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == (self.newsArray.count - 3)
    }
}
