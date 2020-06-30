//
//  VkController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 12.05.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import RealmSwift


class VkApiController: UIViewController{
    
    
    @IBOutlet private weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7464677"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"), //270342 262150
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
        
    }
}

extension VkApiController: WKNavigationDelegate {
    
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
            else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        if let token = params["access_token"],
            let userId = params["user_id"] {
            let session = Session.instance
            session.token = token
            session.userId = Int(userId)!
            print(token)
            print(userId)
        }
        
        //Вызов запроса
        
        //getGroups()
        //getFriends()
        //getPhoto()
        //groupsSearch()
        
        //Вывод
        decisionHandler(.cancel)
        //Переход
        performSegue(withIdentifier: "segueVK", sender: nil)
    }
    
    func saveData<T: Object>(data: [T]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    
    //Получение списка друзей
    func getFriendsMethod()  {
        let path = "/method/friends.get"
        let param: Parameters = ["access_token" : Session.instance.token,
                                 "extended" : 1,
                                 "fields": "domain, photo_50, nickname",
                                 "v" : "5.103"]
        AF.request(Session.instance.baseUrl + path, method: .get,
                   parameters: param).responseData { [weak self] response in
                    guard let value = response.value else { return }
                    let users = try! JSONDecoder().decode(ResponseFriend.self, from: value).response.items
                    self?.saveData(data: users)
                    print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    //Получение фотографий человека
    func getPhoto(ownerID: Int, completion: @escaping () -> Void) {
        let path = "/method/photos.getAll"
        let param: Parameters = ["access_token" : Session.instance.token,
                                 "extended" : 1,
                                 "v" : "5.103",
                                 "album_id" : "profile",
                                 "owner_id" : "\(ownerID)"]
        AF.request(Session.instance.baseUrl + path, method: .get,
                   parameters: param).responseData { [weak self] response in
                    guard let value = response.value else { return }
                    let photos = try! JSONDecoder().decode(ResponsePhoto.self, from: value).response.items
                    self?.saveData(data: photos)
                    print(Realm.Configuration.defaultConfiguration.fileURL!)
                    completion()
        }
    }
    
    //Получение групп текущего пользователя
    func getGroups(controller: MyGroupViewController) {
        let path = "/method/groups.get"
        let param: Parameters = ["access_token" : Session.instance.token,
                                 "extended" : 1,
                                 "v" : "5.103"]
        let request = AF.request(Session.instance.baseUrl + path, method: .get, parameters: param)
        let queue = OperationQueue()

        let getDataOperation = GetDataOperation(request: request)
        queue.addOperation(getDataOperation)

        let parseGroupsData = ParseGroupsData()
        parseGroupsData.addDependency(getDataOperation)

        let reloadGroupsTable = ReloadGroupsTable(controller: controller)
        reloadGroupsTable.addDependency(parseGroupsData)
        OperationQueue.main.addOperation(reloadGroupsTable)
        
        /*         AF.request(Session.instance.baseUrl + path, method: .get,
                   parameters: param).responseData { [weak self] response in
                    guard let value = response.value else { return }
                    let groups = try! JSONDecoder().decode(ResponsGroup.self, from: value).response.items
                    self?.saveData(data: groups)
                    print(Realm.Configuration.defaultConfiguration.fileURL!)
        }*/
    }
    
    //Получение групп по поисковому запросу
    func groupsSearch() {
        let path = "/method/groups.search"
        let param: Parameters = ["access_token" : Session.instance.token,
                                 "extended" : 1,
                                 "v" : "5.103",
                                 "q" : "Лентач"]
        AF.request(Session.instance.baseUrl + path, method: .get,
                   parameters: param).responseJSON { response in
                    guard let value = response.value else { return }
                    print(value)
        }
    }
    func getNews(completion: @escaping ([NewsFeed]) -> Void) {
        
        let methodUrl = "/newsfeed.get"
        let parameters: Parameters = [
            "user_ids" : "\(Session.instance.userId)",
            "access_token" : Session.instance.token,
            "filters" : "post",
            "v" : "5.68"
        ]
        
        AF.request(Session.instance.baseUrl + methodUrl, method: .get, parameters: parameters).responseData(queue: DispatchQueue.global()) { response in
            guard let data = response.value else { return }
            let news = try! JSONDecoder().decode(NewsResponse.self, from: data).response.items
            completion(news)
        }
    }
}
