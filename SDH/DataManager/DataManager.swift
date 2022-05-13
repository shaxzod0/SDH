//
//  DataManager.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()
    
    func saveToFav(product: Results, compilation: @escaping (Result<Bool, Error>)-> Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "App delegate not found", code: 555)))
            return
        }
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Fav", in: context)
        let favObject = NSManagedObject(entity: entity!, insertInto: context)
        favObject.setValue(product.id, forKey: "id")
        favObject.setValue(product.trade_label.name, forKey: "tradeLabel")
        favObject.setValue(product.composition, forKey: "manufacturer")
        do{
            try context.save()
            compilation(.success(true))
        }catch{
            compilation(.failure(error))
        }
    }
    func fetchFav(compilation: @escaping (Result <[NSManagedObject], Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "App delegate not found", code: 555)))
            return
        }
        let managedContext =
        delegate.persistentContainer.viewContext
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Fav")
        do {
            let fav = try managedContext.fetch(fetchRequest)
            compilation(.success(fav))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func deleteObject(object: Fav)->Void{
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = delegate.persistentContainer.viewContext
        do{
            context.delete(object)
            try context.save()
        } catch{
            print(error)
        }
    }
    func deleteRecords(product: Results,complation: @escaping (Result<Bool, Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            complation(.failure(NSError(domain: "Appdelegate not found", code: 404, userInfo: nil)))
            return
        }
        let ctx = delegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        requestDel.returnsObjectsAsFaults = false
        do {
            let arrUsrObj = try ctx.fetch(requestDel)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                if usrObj.value(forKey: "id") as! Int == product.id {
                        ctx.delete(usrObj) // Deleting Object
                }
            }
        } catch {
            print("Failed")
        }
        do {
            try ctx.save()
        } catch {
            print("Failed saving")
        }
    }
    func checkIfItemExist(id: Int) -> Bool {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
}
