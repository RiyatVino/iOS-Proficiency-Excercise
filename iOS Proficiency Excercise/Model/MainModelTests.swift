//
//  MainModelTests.swift
//  iOS Proficiency ExcerciseTests
//
//  Created by Vino on 4/9/20.
//  Copyright © 2020 Vino. All rights reserved.
//

import XCTest
@testable import iOS_Proficiency_Excercise

class MainModelTests: XCTestCase {
    
      func testJsonModelClasswithAllValues() {
          let json = """
          {
          "title":"About Canada",
          "rows":[
              {
              "title":"Beavers",
              "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
              "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
              }
                ]
            }
          """.data(using: .utf8)!
    
          let person = try! JSONDecoder().decode(MainModel.self, from: json)
    
          XCTAssertEqual(person.titleValue, "About Canada")
          XCTAssertEqual(person.rowsValue?[0].titleValue, "Beavers")
          XCTAssertEqual(person.rowsValue?[0].descriptionValue, "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony")
          XCTAssertEqual(person.rowsValue?[0].imageHrefValue, "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
    }
    
      func testJsonModelClasswithNullData() {
          let json = """
          {
          "title":"About Canada",
          "rows":[
              {
              "title":null,
              "description":null,
              "imageHref":null
              }
                ]
            }
          """.data(using: .utf8)!
    
          let person = try! JSONDecoder().decode(MainModel.self, from: json)
    
          XCTAssertEqual(person.titleValue, "About Canada")
          XCTAssertEqual(person.rowsValue?[0].titleValue, nil)
          XCTAssertEqual(person.rowsValue?[0].descriptionValue, nil)
          XCTAssertEqual(person.rowsValue?[0].imageHrefValue, nil)
    }
 
}
