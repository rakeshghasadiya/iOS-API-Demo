//
//  Result.swift
//  WebServiceDemo
//
//  Created by Rakesh Ghasadiya on 21/12/16.
//  Copyright © 2016 Rakesh Ghasadiya. All rights reserved.
//

import Foundation

enum Result<Element> {
  case success(Element)
  case failure(Error)
}
