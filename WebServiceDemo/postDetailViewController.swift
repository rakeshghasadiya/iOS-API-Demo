//
//  postDetailViewController.swift
//  WebServiceDemo
//
//  Created by Rakesh Ghasadiya on 21/12/16.
//  Copyright © 2016 Rakesh Ghasadiya. All rights reserved.
//

import UIKit

class postDetailViewController: UIViewController {

  var postModel: PostModel?
  
  @IBOutlet weak var postTitleLabel: UILabel!
  
  @IBOutlet weak var postDetailLabel: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    guard let postModel = postModel else {
      return
    }
    postTitleLabel.text = postModel.title
    postDetailLabel.text = postModel.body
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
