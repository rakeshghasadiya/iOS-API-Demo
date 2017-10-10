//
//  PostModel.swift
//  WebServiceDemo
//
//  Created by Rakesh Ghasadiya on 21/12/16.
//  Copyright © 2016 Rakesh Ghasadiya. All rights reserved.
//

import Foundation
import Marshal
struct PostModel {
  
  fileprivate var _userId : Int
  fileprivate var _id : Int
  fileprivate var _title : String
  fileprivate var _body : String
  
  
  var userId : Int {
    return _userId
  }
  
  var id : Int {
    return _id
  }
  
  var title : String {
    return _title
  }
  
  var body : String {
    return _body
  }
   
  
}

extension PostModel : Unmarshaling {
  
  enum Keys : String {
    case userId
    case id
    case title
    case body
  }
  
  init(object: MarshaledObject) throws {
  
      
    _userId = try object.value(for: Keys.userId.rawValue)
    _id = try object.value(for:  Keys.id.rawValue)
    _title = try object.value(for: Keys.title.rawValue)
    _body = try object.value(for: Keys.body.rawValue)
  }
  
}
