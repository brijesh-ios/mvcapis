//
//  DriverlistViewController.swift
//  Safeobuddy
//
//  Created by Brijesh kumar on 14/05/1941 Saka.
//  Copyright © 1941 Dhanuka electrotech pvt. ltd. All rights reserved.
//

import UIKit

class DriverlistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var Vehiclelist = [DriverList]()
    @IBOutlet var searchBar: UISearchBar!
    var searchActive : Bool = false
     var dataarray : NSMutableArray!
    // var filtered:NSMutableArray!
    var filtered : NSArray!
   // var dataarray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(red:71.0/255, green:162.0/255, blue:255.0/255, alpha:1.0)

       // self.searchBar.showsCancelButton = false

        self.GetVehicledetail1()
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
 
        print("view will appear")
        searchActive = false;
         searchBar.resignFirstResponder()
    }
     
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
     //   self.tableview.isHidden=true
        searchBar.resignFirstResponder()
    }
    //
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
      //  self.tableview.isHidden=true
        searchBar.resignFirstResponder()
    }
    
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.tableview.isHidden = false
       // self.dataarray = UserDefaults.standard.array(forKey: "dataarray") as? NSMutableArray
        //filtered.removeAll(keepingCapacity: false)
       let dataarray2 = UserDefaults.standard.array(forKey: "dataarray")
//        let searchPredicate = NSPredicate(format: "SELF.Name CONTAINS[c] %@ OR SELF.DriverNumber CONTAINS[c] %@", searchText, searchText)
        
         let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
        filtered = (dataarray2! as NSArray).filtered(using: searchPredicate) as NSArray
        
        print ("array = %@", filtered as Any)
       // let array = (Vehiclelist as NSArray).filtered(using: searchPredicate)
        
       // filtered = array as? NSMutableArray
 //                 let namePredicate =
//                    NSPredicate(format: "Name like %@",searchText)
//                // filtered = self.dataarray1!.filter { namePredicate.evaluate(with: $0) } as! [String]
//                print("names = ,\(filtered)")
//                filtered = self.dataarray.filter { namePredicate.evaluate(with: $0) }
        
        // var pre:NSPredicate = NSPredicate(format: "vehiclenos CONTAINS[c] %@", searchText)
        
        if(searchText == ""){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableview.reloadData()
    }
    
      func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return self.filtered.count
        }
         return self.Vehiclelist.count
    }
    
    //      func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ridecell", for: indexPath) as! List2TableViewCell
        
        cell.didTap1Btn.addTarget(self, action: #selector(didTapCellButton(_:)), for: .touchUpInside)
        cell.didTap1Btn.tag = indexPath.row
        
        if(searchActive){
            
             cell.drivername.text = (((filtered[indexPath.row] as AnyObject).value(forKey: "Name") as? String)!)
            cell.drivercontact.text = (((filtered[indexPath.row] as AnyObject).value(forKey: "DriverNumber") as? String)!)
            cell.vehiclenumber.text = (((filtered[indexPath.row] as AnyObject).value(forKey: "VehicleNumber") as? String)!)
            cell.dlnumber.text = (((filtered[indexPath.row] as AnyObject).value(forKey: "DLNo") as? String)!)
        }
        else
        {
            cell.drivername.text = self.Vehiclelist[indexPath.row].Name!
            cell.drivercontact.text = self.Vehiclelist[indexPath.row].DriverNumber!
            cell.vehiclenumber.text = self.Vehiclelist[indexPath.row].VehicleNumber!
            cell.dlnumber.text = self.Vehiclelist[indexPath.row].DLNo!
        }
       

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.0
    }
 
     @objc func didTapCellButton(_ sender: UIButton) {
         if(searchActive){
            if (((filtered[sender.tag] as AnyObject).value(forKey: "DriverNumber") as? String)!) == ""{
                
                //self.displayMessage(title: nil, msg: "Contact not available!")
                
            }
            else
            {
             let url1 =  (((filtered[sender.tag] as AnyObject).value(forKey: "DriverNumber") as? String)!)
            
            let url: NSURL = URL(string: "TEL://\(url1)")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        else
         {
            
                if self.Vehiclelist[sender.tag].DriverNumber! == ""{
                    // self.displayMessage(title: nil, msg: "Contact not available!")
                    
                }
                else
                {
            let url1 =  self.Vehiclelist[sender.tag].DriverNumber!
             let url: NSURL = URL(string: "TEL://\(url1)")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                    
            }
            }
     }
    
    
    func GetVehicledetail1(){
        
        //
//        if !NetHelper.isReachable(){
//            let str = NSLocalizedString("Please check your internet connection", comment: "Please check your internet connection")
//            self.displayMessage(title: "", msg: str)
//            return
//        }
//        else
//        {
           // let wait = addWaitSpinner()
            
            let url = URL(string: "http://abc.com/MobileService.aspx?method=GetDriverAPIData")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            //let params = ["contactid" : MyProfile.uid! , "date" : "15/07/2019", "roleid" : "6"]
         //   let strid = "9219"
            //let postString = "CId=\(MyProfile.uid!)"
            let postString = "6543"
            request.httpBody = postString.data(using: .utf8)
            // Getting response for POST Method
            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        return // check for fundamental networking error
                    }
                    
                    // Getting values from JSON Response
                    let responseString = String(data: data, encoding: .utf8)
                    let jsonData = responseString?.data(using: .utf8)
                    let dictionary = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableLeaves)
                    print(dictionary as Any)
                    
                    if dictionary == nil
                    {
                        DispatchQueue.main.async {

                        let str = NSLocalizedString("Data not found!", comment: "Data not found!")
                       // self.displayMessage(title: "", msg: str)
                            
                        }
                    }
                    else
                    {
                         if let dataDict1 = dictionary! as? [String :Any]{
                            if let driverData1 = dataDict1["success"] as? String? , driverData1 == "0"{
                                
                                DispatchQueue.main.async {
                                  //  self.removeWaitSpinner(waitView: wait)
                                    //self.listtableView .reloadData()
                                    let str = NSLocalizedString("Data not found!", comment: "Data not found!")
                                     //   self.displayMessage(title: "", msg: str)
 
                                }
                                
                              
                                
                            }
                                
                            else
                            {
                                
                                if let dataDict = dictionary! as? [String :Any]{
                                    if let driverData = dataDict["Notificationdata"] as? [Any]{
                                        
                                        let CDataArray = driverData
                                        UserDefaults.standard.set(CDataArray, forKey: "dataarray")
                                        
                                        for i in driverData{
                                            if let dict = i as? [String: Any]{
                                                let d = DriverList(rawData: dict)
                                                self.Vehiclelist.append(d)
                                                
                                            }
                                            
                                        }
                                        //self.removeWaitSpinner(waitView: wait)
                                        //let characters = Array(dataDict)
                                        // self.V1Array = NSMutableArray (object: Array(dataDict))
                                        //self.V1Array = mutableCopy(array:characters)
                                    }
                                }
                                
                            }
                        }
                    }
                    
             
                    DispatchQueue.main.async {
                       // self.removeWaitSpinner(waitView: wait)
                        self.tableview .reloadData()
                        
                    }
                    
                }
                task.resume()
             
    }
}
}
class List2TableViewCell: UITableViewCell {
    
    @IBOutlet weak var drivercall: UIView!
    @IBOutlet weak var sidelbl: UILabel!
    @IBOutlet weak var bottomlbl: UILabel!
    @IBOutlet weak var lblcorner: UILabel!

    @IBOutlet weak var vehiclenumber: UILabel!
    @IBOutlet weak var drivername: UILabel!
    @IBOutlet weak var drivercontact: UILabel!
    @IBOutlet weak var dlnumber: UILabel!
    @IBOutlet weak var didTap1Btn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        innerView.layer.cornerRadius = 10
//        innerView.clipsToBounds = true
//        innerView.layer.borderColor = UIColor.blue.cgColor
//        innerView.layer.borderWidth = 1
//        datenTimeBtn.layer.cornerRadius = 4
//        datenTimeBtn.clipsToBounds = true
//
//        listmainView.layer.cornerRadius = 10
//        listmainView.clipsToBounds = true
//        listmainView.layer.borderColor = UIColor.lightGray.cgColor
//        listmainView.layer.borderWidth = 1
        
        sidelbl.layer.cornerRadius = 5
        sidelbl.clipsToBounds = true
        sidelbl.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
        
        
        // Initialization code
    }
    
    
    
}
