//
//  postCellTableViewCell.swift
//  WebServiceDemo
//
//  Created by Rakesh Ghasadiya on 21/12/16.
//  Copyright © 2016 Rakesh Ghasadiya. All rights reserved.
//

import UIKit

class postCellTableViewCell: UITableViewCell {

  @IBOutlet weak var postTitleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configureCell(model:PostModel)
  {
      postTitleLable.text = model.title
  }
  
}
