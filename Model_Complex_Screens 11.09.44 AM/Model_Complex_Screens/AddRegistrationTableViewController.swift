//
//  AddRegistrationTableViewController.swift
//  Model_Complex_Screens
//
//  Created by Student on 27/08/25.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeViewControllerDelegate{
    func selectRoomTypeViewController(_  controller:SelectRoomTypeTableViewController, didSelect roomType: RoomType){
        self.roomType = roomType
        updateRoomType()
        updateButtonState()
        roomCharges()
    
}
    
    
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDate: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    @IBOutlet weak var numberOfNights: UILabel!
    @IBOutlet weak var numberOfNightsDesc: UILabel!
    @IBOutlet weak var roomPriceLabel: UILabel!
    @IBOutlet weak var roomTypeDesc: UILabel!
    @IBOutlet weak var wifiPriceLabel: UILabel!
    @IBOutlet weak var isWifiLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    
    
    
    
    
    
    var roomType:RoomType?
    
    var existingRegistration:Registration?
    var selectedRowIndex: Int?
 
    
    
    var registration : Registration?{
        guard let roomType = roomType else {return nil}
        
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
      
        return Registration(firstName:firstName,
                            lastName:lastName,
                            emailAddress:email,
                            checkInDate:checkInDate,
                            checkOutDate:checkOutDate,
                            numberOfAdults:numberOfAdults,
                            numberOfChildren:numberOfChildren,
                            wifi:hasWifi,
                            roomType:roomType)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkOutDatePicker.minimumDate = midnightToday
        
        if let existingRegistration = existingRegistration{
            firstNameTextField.text = existingRegistration.firstName
            lastNameTextField.text = existingRegistration.lastName
            emailTextField.text = existingRegistration.emailAddress
            checkInDatePicker.date = existingRegistration.checkInDate
            checkOutDatePicker.date = existingRegistration.checkOutDate
            numberOfAdultsStepper.value = Double(existingRegistration.numberOfAdults)
            numberOfChildrenStepper.value = Double(existingRegistration.numberOfChildren)
            wifiSwitch.isOn = existingRegistration.wifi
            roomType = existingRegistration.roomType
        }
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        updateButtonState()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
    }
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    var isCheckInDatePickerVisible = false{
        didSet{
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var ischeckOutDatePickerVisible = false {
        didSet{
            checkOutDatePicker.isHidden = !ischeckOutDatePickerVisible
        }
    }
    
    
    
    func updateDateViews(){
        checkOutDatePicker.minimumDate =  Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        checkInDateLabel.text =  checkInDatePicker.date.formatted(date:.abbreviated,time: .omitted)
        checkOutDate.text =  checkOutDatePicker.date.formatted(date:.abbreviated,time: .omitted)
    }
    
    
    
    @IBAction func isWifiOn(_ sender: UISwitch) {
        roomCharges()
    }
    
    
    func updateNumberOfGuests(){
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    
    func updateRoomType(){
        if let roomType = roomType{
            roomTypeLabel.text = roomType.name
        }else{
            roomTypeLabel.text = "Not Set"
        }
    }
    
    func roomCharges(){
        guard let roomType = roomType else { return }
        
        var nights = Calendar.current.dateComponents([.day], from: checkInDatePicker.date, to: checkOutDatePicker.date).day ?? 0
        nights = max(nights,1)
        let roomCost = nights * roomType.price
        let wifiCost = wifiSwitch.isOn ? 10 * nights : 0
        let total = roomCost + wifiCost
        numberOfNights.text = "\(nights)"
        numberOfNightsDesc.text = "\(checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)) – \(checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted))"
        
        roomPriceLabel.text = roomType.name
        roomTypeDesc.text = "$ \(roomCost)"
        
        wifiPriceLabel.text = wifiSwitch.isOn ? "Yes" : "No"
        isWifiLabel.text = "$ \(wifiCost)"
        
        totalAmountLabel.text = "$ \(total)"
    }
//
//    
//    @IBAction func doneBarButtonTapped(_ sender: Any) {
//        
//        let firstName = firstNameTextField.text ?? ""
//        let lastName = lastNameTextField.text ?? ""
//        let email = emailTextField.text ?? ""
//        let checkInDate = checkInDatePicker.date
//        let checkOutDate = checkOutDatePicker.date
//        let numberOfAdults = Int(numberOfAdultsStepper.value)
//        let numberOfChildren = Int(numberOfChildrenStepper.value)
//        let hasWifi = wifiSwitch.isOn
//        let roomChoice = roomType?.name ?? ""
//        
//        print("Done tapped")
//        print("\(firstName)")
//        print("\(lastName)")
//        print("\(email)")
//        print("\(checkInDate)")
//        print("\(checkOutDate)")
//        print("\(numberOfAdults)")
//        print("\(numberOfChildren)")
//        print("\(hasWifi)")
//        print("\(roomChoice)")
//    }
//    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
        roomCharges()
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
        roomCharges()
    }
    
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateButtonState(){
        doneButton.isEnabled = (registration != nil)
    }
    
    
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateButtonState()
    }
    
    
    @IBAction func valueChanged(_ sender: Any) {
        updateButtonState()
    }
    
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
               return 0
        case checkOutDatePickerCellIndexPath where   ischeckOutDatePickerVisible == false:
              return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkInDatePickerCellIndexPath:
            return 190
        case checkOutDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
            isCheckInDatePickerVisible.toggle()
        }else if indexPath == checkOutDateLabelCellIndexPath && ischeckOutDatePickerVisible == false {
            ischeckOutDatePickerVisible.toggle()
        }else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
            isCheckInDatePickerVisible.toggle()
            ischeckOutDatePickerVisible.toggle()
        }else{
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
