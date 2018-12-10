//
//  ViewController.swift
//  youtube
//
//  Created by 陈纲 on 2018/11/7.
//  Copyright © 2018 陈纲. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "Kanye Is The Best Channel"
//        kanyeChannel.profileImageName = "kanye_profile"
//
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_reputation_2017"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 98088779900222
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylorswiftred"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 8987766990088
//
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    var videos: [Video]?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil{
                print(error as Any)
                return
            }
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]]{
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                
                self.collectionView?.reloadData()
                
            }catch let jsonError{
                print(jsonError)
            }
            
            
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationItem.title = "Home"
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLable.text = "Home"
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLable
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        
        let searchImage = UIImage(named: "search1")?.withRenderingMode(.alwaysOriginal)
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
        
    }
    
    @objc func handleMore(){
        print(456)
    }
    
    @objc func handleSearch() {
        print(123)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}





