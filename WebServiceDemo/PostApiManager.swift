//
//  PostApiManager.swift
//  WebServiceDemo
//
//  Created by Rakesh Ghasadiya on 21/12/16.
//  Copyright © 2016 Rakesh Ghasadiya. All rights reserved.
//

import Foundation
import Alamofire
import Marshal

class PostApiManager  {
  
  static let shared = PostApiManager()
  
  
  func getPosts(completion : @escaping (Result<[PostModel]>) -> Void) -> Void {
    
    Alamofire.request( "\(Urls.hostName.rawValue)posts")
      .validate()
      .responseJSON { response in
        
        switch response.result {
        case .success:
          
          do {
              let objs = try JSONParser.JSONArrayWithData(response.data!).map(PostModel.init)
            
            completion(Result.success(objs))
          
          } catch let error {
      
            completion(Result.failure(error))
          }
          
          break
          
        case .failure(let error):
          
          completion(Result.failure(error))

        }
    }
  }
  
  func deletePost(postId: Int,completion : @escaping (Result<Void> )-> Void) -> Void{
  
    print("\(Urls.hostName.rawValue)posts/\(postId)")
    Alamofire.request( "\(Urls.hostName.rawValue)posts/\(postId)", method: .delete)
      .validate()
      .responseJSON{ response in
    
    switch response.result
    {
        case .success:
            completion ( Result.success() )
          
        break
        case .failure(let error):
          completion(Result.failure(error))
        break
      }
    }
  
  }
  
  func addNewPost(_ postdata: [String: String], completion : @escaping (Result<PostModel>)-> Void) -> Void {
    
    Alamofire.request("\(Urls.hostName.rawValue)posts", method: .post, parameters: postdata, encoding: URLEncoding.default, headers: nil)
    .validate()
      .responseJSON{ response in
        
        switch response.result
        {
        case .success:
          do{
          let objs = try  JSONParser.JSONObjectWithData(response.data!)
          let objss = try PostModel.init(object: objs)
          completion(Result.success(objss))
            
          }catch let error{
          
          completion(Result.failure(error))
          }
            
            break
        case .failure(let error):
          print(error)
          completion(Result.failure(error))
          break
        
        }
    }
  }

  
  func editPost(_ postdata: [String: String], completion : @escaping (Result<PostModel>)-> Void) -> Void {
    
    Alamofire.request("\(Urls.hostName.rawValue)posts/1", method: .put, parameters: postdata, encoding: URLEncoding.default, headers: nil)
      .validate()
      .responseJSON{ response in
        
        switch response.result
        {
        case .success:
          do{
            let objs = try  JSONParser.JSONObjectWithData(response.data!)
            let objss = try PostModel.init(object: objs)
            completion(Result.success(objss))
            
          }catch let error{
            
            completion(Result.failure(error))
          }
          
          break
        case .failure(let error):
          print(error)
          completion(Result.failure(error))
          break
          
        }
    }
  }
  
}
