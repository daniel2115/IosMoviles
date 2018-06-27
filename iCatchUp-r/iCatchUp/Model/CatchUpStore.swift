//
//  CatchUpStore.swift
//  iCatchUp
//
//  Created by Developer User on 6/7/18.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CatchUpStore {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    let favoriteEntityName = "Favorite"
    
    func save() {
        delegate.saveContext()
    }
    
    func addFavorite(for source: Source) {
        let entityDescription = NSEntityDescription.entity(
            forEntityName: favoriteEntityName,
            in: context)
        let favorite = NSManagedObject(
            entity: entityDescription!,
            insertInto: context)
        favorite.setValue(source.id, forKey: "sourceId")
        favorite.setValue(source.name, forKey: "sourceName")
        save()
    }
    
    func deleteFavorite(for source: Source) {
        if let objectId = findFavoriteById(for: source)?.objectID {
            let request = NSBatchDeleteRequest(objectIDs: [objectId])
            do {
                try context.execute(request)
                save()
            } catch let error {
                print("Delete Error: \(error.localizedDescription)")
            }
        }
    }
    
    func findFavoriteBy(predicate: NSPredicate, for source: Source) -> NSManagedObject? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: favoriteEntityName)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result.first as? NSManagedObject
        } catch let error {
            print("Query Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func findFavoriteById(for source: Source) -> NSManagedObject? {
        let predicate = NSPredicate(format: "sourceId = %@", source.id)
        return findFavoriteBy(predicate: predicate, for: source)
    }
    
    func findFavoriteByName(for source: Source) -> NSManagedObject? {
        let predicate = NSPredicate(format: "sourceName = %@", source.name)
        return findFavoriteBy(predicate: predicate, for: source)
    }
    
    
    func findAllFavorites() -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: favoriteEntityName)
        do {
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
            
        } catch let error {
            print("Query Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func isFavorite(source: Source) -> Bool {
        return findFavoriteById(for: source) != nil
    }
    
    func favorite(source: Source) {
        setFavorite(true, for: source)
    }
    
    func unFavorite(source: Source) {
        setFavorite(false, for: source)
    }
    
    func setFavorite(_ isFavorite: Bool, for source: Source) {
        if self.isFavorite(source: source) == isFavorite {
            return
        }
        if isFavorite {
            addFavorite(for: source)
        } else {
            deleteFavorite(for: source)
        }
    }
    
    func favoriteSourceIdsAsString() -> String {
        if let favorites = findAllFavorites() {
            return favorites.map({ $0.value(forKey: "sourceId") as! String })
                .filter({ !$0.isEmpty })
                .prefix(20)
                .joined(separator: ",")
        }
        return ""
    }
}
