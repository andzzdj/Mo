//
//  HomeViewController.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 2 on 1.3.22..
//

import UIKit

protocol DeleteAccountDelegate: AnyObject
{

    func deleteAccount(account: Account)

}

class HomeViewController: UIViewController
{

    var accounts = [Account]()
    var deleteBtn: UIButton?
    //let account = ["Account 1", "Account 2 prosirenje", "Account 3"]
    let segment = ["Transactions", "Stats"]
    @IBOutlet weak var accountsCV: UICollectionView!
    
    var selected: Int = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        do
        {
            accounts = try AppController.controller.persistentContainer.viewContext.fetch(Account.fetchRequest())
            
        }
        catch{}
        
        self.view.backgroundColor = .backgroundGrey
        // Do any additional setup after loading the view.
        accountsCV.backgroundColor = UIColor.backgroundGrey
        let ind =  IndexPath(item: selected, section: 0)
        self.accountsCV.selectItem(at:ind, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        
    }
    
    @IBAction func onEditAccountBtnClick(_ sender: Any)
    {

        print("Edit button clicked")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController
        {
            vc.setAccount(account: accounts[selected])
            //vc.deleteAccountButton.isHidden = false
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func openSettings(_ sender: Any)
    {
        
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return accounts.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.item == accounts.count
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as! AddCell
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as! AccountCell
            cell.set(text: accounts[indexPath.item].name ?? "")
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.item == accounts.count
        {
           // collectionView.sizeToFit()
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
           
        }
        else
        {
            if indexPath.item == selected
            {
                return CGSize(width: getCellWidth(for: accounts[indexPath.item].name ?? "") + 45, height: collectionView.frame.height)
            }
            else
            {
                return CGSize(width: getCellWidth(for: accounts[indexPath.item].name ?? "") + 15, height: collectionView.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("CLICK \(indexPath.item)")
            if indexPath.item == accounts.count
            {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController
                {
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        else
        {
            selected = indexPath.item
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func getCellWidth(for text: String)-> CGFloat
    {
        let attributedString = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 18)])
        let size = attributedString.size()
        return size.width
    }
    
    @objc func deleteCell(_ notification: Notification)
    {
            if let cell = notification.object as? AccountCell
            {
                if let indexPath = accountsCV.indexPath(for: cell)
                {
                    accountsCV.performBatchUpdates {

                        let removed = self.accounts.remove(at: indexPath.item)

                        if let index = self.accounts.firstIndex(where: { _account in

                            return _account.id == removed.id
                        })

                        {
                            self.accounts.remove(at: index)
                        }
                        self.accountsCV.deleteItems(at: [indexPath])
                    } completion: { _ in
                    }
                }
            }
        }
}

extension  HomeViewController : DeleteAccountDelegate
{
    func deleteAccount(account: Account)
    {
        //Podesi brisanje(deleteCell brise i celiju i account pa iskoristi to)] mozda moze i samo notification
    }
}


