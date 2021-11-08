//
//  MemoModel.swift
//  Memorial
//
//  Created by TBC on 2021/5/13.
//

import UIKit

class MemoModel: NSObject,NSCoding {
    var contentStr : String?
    var timeStr : String?
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //Memo data path
    static let MemoArchiveURL = DocumentsDirectory.appendingPathComponent("memo")
    //Plan data path
    static let PlanArchiveURL = DocumentsDirectory.appendingPathComponent("plan")
    //Card data path
    static let CardArchiveURL = DocumentsDirectory.appendingPathComponent("card")
    //Drink data path
    static let DrinkArchiveURL = DocumentsDirectory.appendingPathComponent("drink")
    
    init?(content: String,answer: String) {
        // Initialize stored properties.
        self.contentStr = content
        self.timeStr = answer
        
        super.init()
        
    }
    
    //encode to Object
    func encode(with coder: NSCoder) {
        coder.encode(contentStr, forKey:"contentStr")
        coder.encode(timeStr, forKey:"timeStr")
    }
    
    //decode
    required init(coder decoder : NSCoder) {
        self.contentStr = decoder.decodeObject(forKey: "contentStr") as? String ?? ""
        self.timeStr = decoder.decodeObject(forKey: "timeStr") as? String ?? ""
    }
}
