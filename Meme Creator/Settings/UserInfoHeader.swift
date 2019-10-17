//
//  UserInfoHeader.swift
//  Meme Creator
//
//  Created by MACBOOK on 10/17/19.
//  Copyright © 2019 Alexander. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class UserInfoHeader: UIView {
    
    // MARK: - Properties
    let profilePicture: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "profilePicture")
        return iv
    }()
    let storageRef = Storage.storage().reference(forURL: "gs://meme-5bf0a.appspot.com/").child("profilePicture").child("")
    let databaseRef = Database.database().reference()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profilePicture.clipsToBounds = true
        if let uid = Auth.auth().currentUser?.uid{
            databaseRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    self.usernameLabel.text = dict["username"] as? String
                    if let profileImageURL = dict["profilePicture"] as? String
                    {
                        let url = URL(string: profileImageURL)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil{
                                print(error!)
                                return
                            }
                            DispatchQueue.main.async {
                                self.profilePicture.image = UIImage(data: data!)
                            }
                        }).resume()
                    }
                }
            })
        }
        let profileImageDimension: CGFloat = 60
        
        addSubview(profilePicture)
        profilePicture.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profilePicture.layer.cornerRadius = profileImageDimension / 2

        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profilePicture.rightAnchor, constant: 12).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
