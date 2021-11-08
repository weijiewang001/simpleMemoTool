

import UIKit

class AccountBookModel: NSObject,NSCoding {
    var contentStr : String?
    var moneyStr : String?
    var typeStr : String?
    var timeStr : String?
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //Record data path
    static let AccountBookArchiveURL = DocumentsDirectory.appendingPathComponent("accountBook")
    
    init?(content: String,time: String,money: String,typeStr: String) {
        // Initialize stored properties.
        self.contentStr = content
        self.timeStr = time
        self.moneyStr = money
        self.typeStr = typeStr
        
        super.init()
        
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(contentStr, forKey:"contentStr")
        coder.encode(timeStr, forKey:"timeStr")
        coder.encode(moneyStr, forKey:"moneyStr")
        coder.encode(typeStr, forKey:"typeStr")
    }
    
    
    required init(coder decoder : NSCoder) {
        self.contentStr = decoder.decodeObject(forKey: "contentStr") as? String ?? ""
        self.timeStr = decoder.decodeObject(forKey: "timeStr") as? String ?? ""
        self.moneyStr = decoder.decodeObject(forKey: "moneyStr") as? String ?? ""
        self.typeStr = decoder.decodeObject(forKey: "typeStr") as? String ?? ""
    }
}
