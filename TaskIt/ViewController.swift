//
//  ViewController.swift
//  TaskIt
//
//  Created by Robert E Spivack on 10/28/14.
//  Copyright (c) 2014 Robert E. Spivack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        let date1 = Date.from(year: 2014, month: 05, day: 20)
        let date2 = Date.from(year: 2014, month: 03, day: 3)
        let date3 = Date.from(year: 2014, month: 12, day: 13)
        
        
        
        let task1 = TaskModel(task: "Study French", subtask: "Verbs", date: date1)
        let task2 = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: date2)
        
        taskArray = [task1, task2,TaskModel(task: "Gym", subtask: "Leg day", date: date3)]
        
        self.tableView.reloadData()
        
        
//        println(task1["task"])
//        println(task1["date"])
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

//        func sortByDate (taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//       
//        taskArray = taskArray.sorted(sortByDate)
// 
// Instead of using function inside function, can do it all 'oneliner' using 'closure' syntax
        
        taskArray = taskArray.sorted{
            (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            //comparison logic here
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        
        
        self.tableView.reloadData()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = taskArray[indexPath!.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
        }
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        }
        
        
    }
    
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    
    
    // UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        println(indexPath.row)
        
        
        let thisTask = taskArray[indexPath.row]
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
 
    //UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        println("Inside tableViewDelegate: ",indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
 
    
    //Helpers
   
   
    
}

