//
//  Diary - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreData

final class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let coreDataManager = CoreDataManager.shared
    var sample: [Sample] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        tableView.rowHeight = 55
        tableView.dataSource = self
        tableView.delegate = self
        decodeJSON()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callGet()
    }
    
    private func callGet() {
        coreDataManager.getAllEntity()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        guard let NewDetailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController", creator: {coder in DetailViewController(sample: nil, coder: coder)}) else { return }
        
        self.navigationController?.pushViewController(NewDetailViewController, animated: true)
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: "DiaryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func decodeJSON() {
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "sample") else { return }
        
        do {
            self.sample = try jsonDecoder.decode([Sample].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coreDataManager.entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        
        let entity: Entity = self.coreDataManager.entities[indexPath.row]
        cell.configureLabel(entity: entity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sample: Sample = self.sample[indexPath.row]
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController", creator: {coder in DetailViewController(sample: sample, coder: coder)}) else { return }
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete", handler: { action, view, completion in
            print("delete")
            let entity = self.coreDataManager.entities[indexPath.row]
            
            self.coreDataManager.delete(entity: entity)
            completion(true)
            
        })
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
