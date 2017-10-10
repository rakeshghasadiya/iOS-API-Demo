//
//  NewPostViewController.swift
//  WebServiceDemo
//
//  Created by Rakesh Ghasadiya on 22/12/16.
//  Copyright © 2016 Rakesh Ghasadiya. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

  var status = PostControllerState.new
  var postDetailModel: PostModel?
  var newPostDelegate: NewPostDeligate?
  
  @IBOutlet weak var addEditButton: UIButton!
  
  @IBOutlet weak var titleTextField: UITextField!
  
  @IBOutlet weak var descriptionTextView: UITextView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
  
    switch status {
    case .new:
     addEditButton.setTitle("Add", for: .normal)
      break
    case .edit(let _):
      addEditButton.setTitle("Save", for: .normal)
    
      guard let title = postDetailModel?.title, let description = postDetailModel?.body else {
        return
      }
      
      titleTextField.text = title
      descriptionTextView.text = description
      break
    }
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
  @IBAction func addEditButtonTapped(_ sender: UIButton) {
    
    guard let title = titleTextField.text, let description = descriptionTextView.text else {
      return
    }
    
    guard title.characters.count > 0, description.characters.count > 0  else{
      return
    }
    
    
    
    switch status
    {
    case .new:
      let data = ["userId": "1","title": "\(title)","body": "\(description)"]
      EZLoadingActivity.show("Loading..", disableUI: true)
      PostApiManager.shared.addNewPost( data) { result in
        switch result
        {
        case .success(let objs):
         self.newPostDelegate?.postdelegate(postModel: objs, postControllerState: self.status)
      EZLoadingActivity.hide(true, animated: true)
          break
        case .failure(let error):
          print(error)
          EZLoadingActivity.hide(false, animated: true)
          break
        }
      }
      
      break
    case .edit:
      
      let data = ["id": "\(postDetailModel?.id)","userId": "1","title": "\(title)","body": "\(description)"]
      PostApiManager.shared.editPost( data) { result in
        switch result
        {
        case .success(let objs):
          self.newPostDelegate?.postdelegate(postModel: objs, postControllerState: self.status)
          EZLoadingActivity.hide(true, animated: true)
          break
        case .failure(let error):
          print(error)
          EZLoadingActivity.hide(false, animated: true)
          break
        }
      }
      
      break
      
    }
    
    
          self.dismiss(animated: true, completion: nil)
  }
}


protocol NewPostDeligate {
  
  func postdelegate(postModel: PostModel, postControllerState: PostControllerState)
  
}
