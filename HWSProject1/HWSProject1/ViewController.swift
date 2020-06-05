//
//  ViewController.swift
//  HWSProject1
//
//  Created by Adam Delaney on 3/28/20.
//  Copyright © 2020 Adam Delaney. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        DispatchQueue.global(qos: .userInitiated).async(){
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix("nssl"){
                    // this is a picture to load
                    self.pictures.append(item)
                }
            }
            self.pictures.sort()
            DispatchQueue.main.async(){
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1) of \(pictures.count)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // try loading "Detial" view controller and typecasting to be a DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // success! set selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            // push onto navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

