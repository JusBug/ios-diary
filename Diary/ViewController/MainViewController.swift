//
//  Diary - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    //var sample: [Sample] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        tableView.rowHeight = 55
        tableView.dataSource = self
        tableView.delegate = self
        //decodeJSON()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
    }
    
    @objc func tapAddButton() {
        guard let NewDetailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController", creator: {coder in DetailViewController(sample: nil, coder: coder)}) else { return }
        
        self.navigationController?.pushViewController(NewDetailViewController, animated: true)
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: "DiaryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
//    private func decodeJSON() {
//        let jsonDecoder = JSONDecoder()
//        guard let dataAsset = NSDataAsset(name: "sample") else { return }
//
//        do {
//            self.sample = try jsonDecoder.decode([Sample].self, from: dataAsset.data)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        tableView.reloadData()
//    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        
        let model = models[indexPath.row]
        cell.configureLabel(sample: sample)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sample: Sample = self.sample[indexPath.row]
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController", creator: {coder in DetailViewController(sample: sample, coder: coder)}) else { return }
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainViewController {
    func getAllItems() {
        do {
            models = try context.fetch(Item.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func createItem(itemTitle: String, itemBody: String) {
        let newItem = Item(context: context)
        newItem.itemTitle = itemTitle
        newItem.itemBody = itemBody
        newItem.itemCreatedDate = Date()
        
        do {
            try context.save()
            getAllItems()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteItem(item: Item) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateItem(item: Item, newItemTitle: String, newItemBody: String) {
        item.itemTitle = newItemTitle
        item.itemBody = newItemBody
        
        do {
            try context.save()
            getAllItems()
        } catch {
            print(error.localizedDescription)
        }
    }
}
