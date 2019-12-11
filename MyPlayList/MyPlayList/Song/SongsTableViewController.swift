//
//  SongsTableViewController.swift
//  MyPlayList
//
//  Created by Capgemini on 12/3/19.
//  Copyright © 2019 Capgemini. All rights reserved.
//

import UIKit
import AVFoundation

class SongsTableViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    
    var videos : [Video] = []
    //var videos1 : [Video] = []
     var video:Video = Video()
    var videosKey = [String]()
    var videosName = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "MyPlaylist"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //  tableView.reloadData()
        getPlist()
       
    }
    
    
    func getPlist()
    {
        let path = Bundle.main.path(forResource: "SongList", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        videosKey = dict!.object(forKey: "SongKeys") as! [String]
        videosName = dict!.object(forKey: "SongName") as! [String]
        for i in 0...9 {
            let video1 = Video()
            video1.key = videosKey[i]
            video1.title = videosName[i]
            videos.append(video1)
          //  print("SongKeys=\(video1.key)")
            
        }
      //  print("videos list = \(videos)")
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoTableViewCell
        cell.videoTitle.text = videos[indexPath.row].title
        let url = "https://img.youtube.com/vi/\(videos[indexPath.row].key)/0.jpg"
       // print("Url=\(url)")
        //    if let thumbnailImage = getThumbnailImage(forUrl: url) {
        //        cell.videoImage.image = thumbnailImage
        //    }
        cell.videoImage.downloaded(from: url)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vi = videos[indexPath.row]
        self.video = vi
        performSegue(withIdentifier: "toVideo", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVideo" {
            let vc = segue.destination as! VideoPlayerViewController
            vc.video = self.video
            
        }
        
    }
    
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     // let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
     // let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
     }
     */
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
