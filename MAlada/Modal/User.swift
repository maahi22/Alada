//
//  User.swift
//  MAlada
//
//  Created by Maahi on 13/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit



class User: NSObject ,NSCoding{
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(UserId, forKey: Keys.UserId)
        aCoder.encode(Username, forKey: Keys.Username)
      //  aCoder.encode(Password, forKey: Keys.Password)
        aCoder.encode(Mob, forKey: Keys.Mob)
        aCoder.encode(Gender, forKey: Keys.Gender)
        aCoder.encode(EmailID, forKey: Keys.EmailID)
        aCoder.encode(Status, forKey: Keys.Status)
        aCoder.encode(Message, forKey: Keys.Message)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.UserId = aDecoder.decodeObject(forKey: Keys.UserId) as? String
        self.Username = aDecoder.decodeObject(forKey: Keys.Username) as? String
       // self.Password = aDecoder.decodeObject(forKey: Keys.Password) as? String
        self.Mob = aDecoder.decodeObject(forKey: Keys.Mob) as? String
        self.Gender = aDecoder.decodeObject(forKey: Keys.Gender) as? String
        self.EmailID = aDecoder.decodeObject(forKey: Keys.EmailID) as? String
        self.Status = aDecoder.decodeObject(forKey: Keys.Status) as? String
        self.Message = aDecoder.decodeObject(forKey: Keys.Message) as? String
       
    }
    

    
    public var UserId : String?
    public var Username: String?
   // public var Password:String?
    public var Mob : String?
    public var Gender: String?
    public var EmailID:String?
    public var Status : String?
    public var Message: String?
   
    
    internal struct Keys {
        static let UserId = "UserId"
        static let Username = "Username"
       // static let Password = "Password"
        static let Mob = "Mob"
        static let Gender = "Gender"
        static let Status = "Status"
        static let EmailID = "EmailID"
        static let Message = "Message"
        
    }
    
    init(UserId: String, Username: String,  Mob: String, Gender: String, Status:String ,EmailID: String, Message: String) {
        
        self.UserId = UserId
        self.Username = Username
      //  self.Password = Password
        self.Mob = Mob
        self.Gender = Gender
        self.Status = Status
        self.EmailID = EmailID
        self.Message = Message
        
        
        
    }
    
    // MARK: - Class Constructors
    public class func DictionaryVal(jsonObject:NSDictionary) -> User {
        
        guard let user = User(json: jsonObject) else
        {
            return User(UserId: "", Username: "",  Mob: "", Gender: "", Status: "", EmailID: "", Message: "")
        }
        return user
    }

    // MARK: - Object Lifecycle
    public init?(json: NSDictionary) {
        
        guard let UserId = json[Keys.UserId] as? String else {return nil}
        guard let Username = json[Keys.Username] as? String else {return nil}
       // guard let Password = json[Keys.Password] as? String else {return nil}
        guard let Mob = json[Keys.Mob] as? String else {return nil}
        guard let Gender = json[Keys.Gender] as? String else {return nil}
        guard let Status = json[Keys.Status] as? String else {return nil}
        guard let EmailID = json[Keys.EmailID] as? String else {return nil}
        guard let Message = json[Keys.Message] as? String else {return nil}
        
        self.UserId = UserId
        self.Username = Username
       // self.Password = Password
        self.Mob = Mob
        self.Gender = Gender
        self.Status = Status
        self.EmailID = EmailID
        self.Message = Message
    }
    
    
    
    
    
    
    
    
}
