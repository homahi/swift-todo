//
//  ViewController.swift
//  todo
//
//  Created by 原野誉大 on 2018/03/01.
//  Copyright © 2018年 原野誉大. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items: [String]!

    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add Todo", message: "タスクを追加してください", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Done", style: .default) { [weak self] (action:UIAlertAction!) -> Void in
            self?.items.append((alert.textFields![0] as UITextField).text!)
            UserDefaults.standard.set(self?.items, forKey: "todoArray")
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {  (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextField { (textField: UITextField) -> Void in
            
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true, completion: nil)
        
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.register(defaults: ["todoArray": []])
        items = UserDefaults.standard.array(forKey: "todoArray") as! [String]
        
    }


}
extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit Todo", message: "Todoを編集してください", preferredStyle: .alert)
        let action = UIAlertAction(title: "Edit", style: .default) { [weak self] _ -> Void in
            self?.items[indexPath.row] = (alert.textFields![0] as! UITextField).text!
            tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ -> Void in
        }
        alert.addAction(cancel)
        alert.addAction(action)
        alert.addTextField{[weak self](textField) -> Void in
            textField.text = self?.items[indexPath.row]
        }
        present(alert, animated: true, completion: nil)

    }
    
}
extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

