//
//  Comment.swift
//  Meme Creator
//
//  Created by MACBOOK on 10/15/19.
//  Copyright © 2019 Alexander. All rights reserved.
//


import Foundation

struct Comment {
    
    let user: User
    
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
