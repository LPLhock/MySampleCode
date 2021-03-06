//
//  ViewController.swift
//  JSDAsyncAwait
//
//  Created by Jersey on 14/7/2021.
//

import UIKit
import HelloNetwork

struct User: Codable {
    let name: String
}

func printCurrentThread(filterString: String? = "", flagString: Any? = "") {
    NSLog("==\(filterString)==, printCurrentThread -> JerseyCafe: Flag --> \(flagString), CurrentThread --> \(Thread.current)")
}

class ViewController: UIViewController {
    
    let userURL: URL = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    let imageURL: URL = URL(string: "http://cn-head-cdn.hellotalk8.com/hu/210611/c6293e3d4d157.jpg?x-oss-process=style/small&")!
    
    var userData: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Swift"
        
        setupView()
        
        // 下载图片, 裁剪
        requestImageURLWithLoad()
        requestUserDataWithLoad()
        
        UserFollowInfoApi(userId: 123456).start { response in
            if let data = response.data {
                let _ = try? JSONDecoder().decode(FollowInfoModel.self, from: data)
            }
        }
    }
    
    // MARK: SetupUI
    func setupView() {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(photoImageView)
        photoImageView.frame = CGRect(x: 200, y: UIScreen.main.bounds.height - 100, width: 60, height: 60)
    }
    
    // MARK: Async SetupData
    
    func requestImageURLWithLoad() {
        async {
            do {
                printCurrentThread(filterString: "进入 Async 准备下载图片")
                let result = try await asycnAwaitFetchThumbnail(for: "")
                printCurrentThread(filterString: "下载图片后")
                switch result {
                case .success(let image):
                    self.photoImageView.image = image
                case .failure(_):
                    print("Error")
                }
            } catch {
                 print("Oops: \(error)")
            }
        }
    }
    
    func requestUserDataWithLoad() {
        async {
            let result = await fetchUserData(for: "")
            switch result {
            case .success(let users):
                self.userData = users
                self.tableView.reloadData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    enum FetchError: Error {
            case netError
            case badID
            case badImage
    }
    
    /// 图片下载,裁剪图片大小
    /// - Parameters:
    ///   - id: 图片标识
    ///   - completion: 下载结果回调
    func fetchThumbnail(for id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let request = URLRequest(url: self.imageURL)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(FetchError.netError))
            } else if (response as? HTTPURLResponse)?.statusCode != 200 {
                completion(.failure(FetchError.netError))
            } else {
                guard let image = UIImage(data: data!) else {
                    completion(.failure(FetchError.badImage))
                    return
                }
                image.prepareThumbnail(of: CGSize(width: 40, height: 40)) { thumbnail in
                    guard let thumbnail = thumbnail else {
                        completion(.failure(FetchError.badImage))
                        return
                    }
                    completion(.success(thumbnail))
                }
            }
        }
        task.resume()
    }
    
    /// 异步特性处理,图片下载裁剪
    /// - Parameter id: id
    /// - Returns: 回调
    func asycnAwaitFetchThumbnail(for id: String) async throws -> Result<UIImage, Error> {
//        printCurrentThread(filterString: "准备进入图片下载裁剪")
        let request = URLRequest(url: self.imageURL)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.netError
        }
        let maybeImage = UIImage(data: data)
        guard let resultImage = await maybeImage?.byPreparingThumbnail(ofSize: CGSize(width: 40, height: 40)) else {
            throw FetchError.netError
        }
        return .success(resultImage)
    }
    
//    func fetchOneThumbnail(withID id: String) async throws -> UIImage {
//        let imageReq = imageRequest(for: id), metadataReq = metadataRequest(for: id)
//        let (data, _) = try await URLSession.shared.data(for: imageReq)
//        let (metadata, _) = try await URLSession.shared.data(for: metadataReq)
//        guard let size = parseSize(from: metadata),
//              let image = await UIImage(data: data)?.byPreparingThumbnail(ofSize: size)
//        else {
//            throw ThumbnailFailedError()
//        }
//        return image
//    }
    
    func fetchUserData(for id: String) async -> Result<[User], Error> {
        let request = URLRequest(url: self.userURL)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let users = try JSONDecoder().decode([User].self, from: data)
            
            return .success(users)
        } catch {
            return .failure(FetchError.netError)
        }
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellIdentifier")
        t.dataSource = self
        t.delegate = self
        
        return t
    }()
    
    lazy var photoImageView: UIImageView = {
        let m = UIImageView()
        
        return m
    }()
}
 
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var presenedVC: UIViewController? = nil
        if indexPath.row == 0 {
            presenedVC = JSDViewController()
        } else if indexPath.row == 1 {
            presenedVC = JSDSIGABRTVC()
        } else if indexPath.row == 2 {
            presenedVC = JSDPerformSelectorVC()
        }
        let nav = UINavigationController(rootViewController: presenedVC!)
        self.present(nav, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData?.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        
        c.textLabel?.text = "zzz"
        fetchThumbnail(for: c.textLabel?.text ?? "", completion: { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    c.imageView?.image = image
                }
            case .failure(_):
                print("Error")
            }
        })
        
        async {
            let result = try await asycnAwaitFetchThumbnail(for: "")
            switch result {
            case .success(let image):
                c.imageView?.image = image
            case .failure(_):
                print("Error")
            }
        }
        
        if self.userData?.count ?? 0 > indexPath.row {
            let user = self.userData?[indexPath.row]
            c.textLabel?.text = user?.name
        }

        var textString = ""
        switch indexPath.row {
            case 0: textString = "JSDViewController"
            case 1: textString = "JSDSIGABRTVC"
            case 2: textString = "JSDPerformSelectorVC"
            default: break
        }
        if textString.count > 0 {
            c.textLabel?.text = textString
        }
        
        
        return c
    }
}

actor Counter {
    var value = 0
    
    var testDataString: [Int] = [1]

    func increment() -> Int {
        value = value + 1
        NSLog("Counter func1")
        return value
    }
    
    func increment2() -> Int {
        value = value + 2
        NSLog("Counter func2")
        return value
    }
    
    func updateData(_ data :[Int]) {
        self.testDataString = data
    }
}

let counter = Counter()
