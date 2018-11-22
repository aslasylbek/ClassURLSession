//
//  ViewController.swift
//  ClassURLSession
//
//  Created by UIB_CIT on 11/20/18.
//  Copyright © 2018 UIB_CIT. All rights reserved.
//

import UIKit


struct cellData {
    var title: String
    var body: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var allData = [cellData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                let jsons = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [Any]
                for json in jsons {
                    
                    let js = json as! [String:Any]
                    
                    let title = js["title"] as! String
                    let body = js["body"] as! String
                    
                    self.allData.append(cellData(title: title, body: body))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
              
            } catch{
                print(error)
            }
        }
        
        task.resume()
        
    }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = allData[indexPath.row].title
        
        return cell
    }
    
    
}



