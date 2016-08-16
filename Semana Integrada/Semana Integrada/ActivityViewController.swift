//
//  ActivityViewController.swift
//  Semana Integrada
//
//  Created by vntlab on 7/25/16.
//  Copyright © 2016 venturuspucc. All rights reserved.
//

import UIKit

class ActivyViewController: UIViewController,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    //let vet = ["Joao","Rodrigo","Carradas"]
    let scheduleDAO = ScheduleDAO()
    var dictionary = [String:[Schedule]]()
    var sortedKeys = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionary = scheduleDAO.generatePalestras();
        sortedKeys = Array(dictionary.keys).sort(<)
        
        navigationItem.title = "Atividades"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.0);
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedKeys[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath)
        let keys = sortedKeys
        let key = keys[indexPath.section]
        let Palestra = dictionary[key]
        //cell.textLabel?.text = Palestra![indexPath.row].EventTitle
        
     
        var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? EventTableCellView
        
        if cell == nil {
            
            let cellNib = UINib(nibName: "customCellInterface", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "myCell")
            cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? EventTableCellView
            
        }
        if ( Palestra![indexPath.row].EventType == "Palestra"){
            cell?.eventType.textColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 1.0)
        }
        if ( Palestra![indexPath.row].EventType == "WorkShop"){
            cell?.eventType.textColor = UIColor(red: 0.12, green: 0.52, blue: 0.78, alpha: 1.0)
        }
        cell?.eventType.text = Palestra![indexPath.row].EventType
      
        cell?.eventDescription.text = Palestra![indexPath.row].EventTitle
        cell?.EventHour.text = Palestra![indexPath.row].EventLocation
        
        
        
        return cell!
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = sortedKeys
        let key = keys[section]
        let numberOfRows = dictionary[key]
        return numberOfRows!.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let selectIndexPath = tableView.indexPathForSelectedRow
        let eventDetailsViewController = segue.destinationViewController as? ActivityDetailController
        
        let keys = Array(dictionary.keys)
        
        let hourKey = keys[selectIndexPath!.section]
        
        eventDetailsViewController?.event = dictionary[hourKey]![selectIndexPath!.row]
        
        

    }

    
    
    
}
