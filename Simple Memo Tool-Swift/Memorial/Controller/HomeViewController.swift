
import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataArr: NSArray!
    var colorArr: NSArray!
    var identifierArr: NSArray!
    
    let cellId = "HomeCell" //get CellId
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView()
        customTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    //background image
    func customView() {
        let bgImg = UIImageView.init(image: UIImage(named: "home_bg"))
        bgImg.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        bgImg.contentMode = .scaleAspectFill
        self.view.insertSubview(bgImg, at: 0)
    }
    
    func customTableView() {
        //data
        dataArr = ["Memorial","White Noise","Plan","Punch Card","hydration record","Accont book"]
        colorArr = [0x8DC421,0xAF3D7D,0x3D8BFF,0xFFA200,0xA8A8A9,0xE1E1E1]
        identifierArr = ["memo","noise","Plan","PunchCard","drinking","AccountBook"]
        //tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        //nibName is cell file created
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentBtn.setTitle(dataArr[indexPath.row] as? String, for: .normal)
        cell.contentBtn.backgroundColor = UIColor.init(valueRGB: colorArr[indexPath.row] as! UInt, alpha: 1.0)
        return cell
    }
    
    // if choose cell then excute this method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: (identifierArr[indexPath.row] as? String)!, sender: nil)
    }
    

}
