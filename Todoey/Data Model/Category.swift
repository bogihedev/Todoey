//
//  Category.swift
//  Todoey
//
//  Created by Bogi Eliasen on 5/15/19.
//  Copyright © 2019 Bogi Eliasen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  let items = List<Item>()
}
