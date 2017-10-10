//
//  ViewController.swift
//  WebServiceDemo
//
//  Created by Rakesh Ghasadiya on 21/12/16.
//  Copyright © 2016 Rakesh Ghasadiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var postDataArray: [PostModel] = []
  
  
  @IBOutlet weak var postTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
postTableView.delegate = self
postTableView.dataSource = self
    
   
    
    
    EZLoadingActivity.show("Loading...", disableUI: true)
    
    PostApiManager.shared.getPosts { result in
      
      switch result {
        
      case .success(let objs):
       self.postDataArray = objs
       self.postTableView.reloadData()
       EZLoadingActivity.hide(true, animated: true)
        break
      case .failure(let error):
        print(error)
         EZLoadingActivity.hide(false, animated: true)
        break
      }
      
    }
    

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "postDetailSegue" {
      let detailViewController = segue.destination as! postDetailViewController
      detailViewController.postModel = postDataArray[sender as! Int]
    }else if segue.identifier == "newPostSegue" {
    
      let newPostViewController = segue.destination as! NewPostViewController
     newPostViewController.newPostDelegate = self
      if let index = sender as? Int {
        newPostViewController.postDetailModel = postDataArray[index]
        newPostViewController.status = .edit(index: index)
       
      }
    
    }
    
  }
  
  
  func deletePost(postIndex: IndexPath)
  {
    EZLoadingActivity.show("Deleteing...", disableUI: true)
    PostApiManager.shared.deletePost(postId: self.postDataArray[postIndex.row].id) { result in
      switch result {
      case .success(_):
        EZLoadingActivity.hide(true, animated: true)
        self.postTableView.beginUpdates()
        self.postDataArray.remove(at: postIndex.row)
        self.postTableView.deleteRows(at: [postIndex], with: .fade)
        self.postTableView.endUpdates()
        
        break
      case .failure(let error):
        EZLoadingActivity.hide(false, animated: true)
        print(error)
        break
      }
    }
  }
  
  
  @IBAction func newPostButtonTapped(_ sender: UIBarButtonItem) {
  self.performSegue(withIdentifier: "newPostSegue", sender: nil)
  
  }
  
  

}

extension ViewController : UITableViewDelegate,UITableViewDataSource{

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postDataArray.count
  }
 
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "postCellTableViewCell") as! postCellTableViewCell
    cell.configureCell(model: postDataArray[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "postDetailSegue", sender: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
      
      //Edit rowm

      self.performSegue(withIdentifier: "newPostSegue", sender: indexPath.row)
      
    }
    editAction.backgroundColor = UIColor.blue
    
    
    let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
      let alertController = UIAlertController(title: "Delete post", message: "Are you sure? do you want to delete this post detail?", preferredStyle: UIAlertControllerStyle.alert)
      
      let DestructiveAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
        print("Cancel")
      }
      
      let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
       
        self.deletePost(postIndex: indexPath)

        
      }
      alertController.addAction(DestructiveAction)
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
      
      
    }
    deleteAction.backgroundColor = UIColor.red
    
    return [editAction,deleteAction]
    
  }

}

extension ViewController :  NewPostDeligate
{
  func postdelegate(postModel : PostModel, postControllerState: PostControllerState) {
    switch postControllerState
    {
    case .new:
       postDataArray.append(postModel)
      break
    case .edit(let index):
      
        postDataArray[index] =  postModel
        
      break
    }
    print(postModel)
    postTableView.reloadData()
  }
  
}
