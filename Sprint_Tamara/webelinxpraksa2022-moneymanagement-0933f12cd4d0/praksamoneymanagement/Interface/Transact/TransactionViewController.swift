//
//  TransViewController.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 02/03/2022.
//

import UIKit



class TransactionViewController: CustomPopUpViewController
{

    var cells:[FieldCellInfo] =  []
    var testTransaction = Transaction()
    var categories: CategoryCollectionViewCell?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var transactionLbl: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var incomeExpenseSegmentControl: UISegmentedControl!
    @IBOutlet weak var fieldsCollectionView: UICollectionView!
    @IBOutlet weak var transactionView: UIView!
    
    @IBAction func isIncome(_ sender: Any)
    {
        if incomeExpenseSegmentControl.selectedSegmentIndex == 0
        {
            testTransaction.isIncome = true
            
        }
        else
        {
            testTransaction.isIncome = false
        }
        print(testTransaction.isIncome)
    }
    
    @IBAction func close(_ sender: Any)
    {
        testTransaction.save()
        self.dismiss(animated: true, completion: nil)
        print(testTransaction)
    }
    
    @IBAction func saveAndClose(_ sender: Any)
    {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    
        _ = AppController.controller
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCategory(_:)), name: Notification.Name("UpdateTransactionNotification"), object: nil)
        
        // TODO: prebaciti ovo u bazu da difault vrednost bude true
        testTransaction.isIncome = true
        self.view.clipsToBounds = true 
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        saveButton.layer.cornerRadius = 40 * 0.5
        backButton.layer.cornerRadius = 40 * 0.5
        
        saveButton.setTitleColor(UIColor.primaryColor, for: .normal)
        saveButton.titleLabel!.font = UIFont.systemFont(ofSize: 18)
        saveButton.backgroundColor = UIColor.lightPurple
        saveButton.tintColor = UIColor.primaryColor
        
        backButton.setTitleColor(UIColor.primaryColor, for: .normal)
        backButton.titleLabel!.font = UIFont.systemFont(ofSize: 18)
        backButton.backgroundColor = UIColor.lightPurple
        backButton.tintColor = UIColor.primaryColor

        transactionLbl.font = UIFont.boldSystemFont(ofSize: 35)
        
        cellsInfo()
        
    }
    
    

    @objc func updateCategory(_ notification: Notification)
    {
        categories?.leftCategoryImage.image = UIImage(systemName: testTransaction.category?.icon ?? "square")
        categories?.categoryLbl.text = testTransaction.category?.name ?? "Insert category"
        categories?.categoryLbl.textColor = UIColor.hexStringToUIColor(hex: testTransaction.category?.color ?? "8F4BFF")
        categories?.leftCategoryImage.tintColor = UIColor.hexStringToUIColor(hex: testTransaction.category?.color ?? "8F4BFF")
        categories?.rightCategoryImage.tintColor = UIColor.hexStringToUIColor(hex: testTransaction.category?.color ?? "8F4BFF")
    
    }
    
    func cellsInfo()
    {
        var cellOne = FieldCellInfo()
        
        cellOne.name = "Name"
        cellOne.userInteraction = true
        cellOne.numericKeyboard = false
        cellOne.isArrowVisible = false
        cellOne.doneButton = false
        cellOne.isDatePicker = false
    
        cells.append(cellOne)
        
        var cellTwo = FieldCellInfo()
        cellTwo.name = "Amount"
        cellTwo.userInteraction = true
        cellTwo.numericKeyboard = true
        cellTwo.isArrowVisible = false
        cellTwo.doneButton = true
        cellTwo.isDatePicker = false
        
        cells.append(cellTwo)
        
        var cellThree = FieldCellInfo()
        
        cellThree.name = "Repeat"
        cellThree.userInteraction = false
        cellThree.numericKeyboard = false
        cellThree.isArrowVisible = true
        cellThree.doneButton = false
        cellThree.isDatePicker = false
        
        cells.append(cellThree)
        
        var cellFour = FieldCellInfo()
        
        cellFour.name = "Due Date"
        cellFour.userInteraction = true
        cellFour.numericKeyboard = false
        cellFour.isArrowVisible = false
        cellFour.doneButton = false
        cellFour.isDatePicker = true
        
        cells.append(cellFour)
        
        
    }
    
}

extension TransactionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return cells.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if (indexPath.item == 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            categories = cell
            return cell
        }
        else
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FieldCollectionViewCell", for: indexPath) as! FieldCollectionViewCell
            
            if (indexPath.item < 1)
            {
                cell.setCell(cellInfo: cells[indexPath.item])
            }
            else
            {
                cell.setCell(cellInfo: cells[indexPath.item-1])
            }
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1
        {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
            {
                vc.modalPresentationStyle = .overFullScreen
                vc.transaction = self.testTransaction
                self.present(vc, animated: true, completion: nil)
                
            }
            
        }
        else if indexPath.item == 3
        {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RepeatViewController") as? RepeatViewController
            {
                vc.modalPresentationStyle = .overFullScreen
                testTransaction.repeatTransaction = Repeat()
                vc.repeatTransaction = self.testTransaction.repeatTransaction!
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

extension TransactionViewController: FieldCellDelegate
{
    
    func fieldCell(_ fieldCell: FieldCollectionViewCell, textDidChangeTo text: String)
    {
        if let indexPath = fieldsCollectionView.indexPath(for: fieldCell)
        {
            let index = indexPath.item
            switch index
            {
            case 0:
                testTransaction.name = text
            case 2:
                testTransaction.amount = Double(text)!
                print(text)
            default:
                break
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
         
        view.addGestureRecognizer(tap)
        view.removeGestureRecognizer(tap)
    }
    
    func addDatePicker(date: Date)
    {
        testTransaction.dueDate = date
    }
    
    func setTextInRepeatTextField(text: String)
    {
        if let cell = fieldsCollectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as? FieldCollectionViewCell
        {
            cell.textField.text = text
        }
        print(text)
    }
    
}




