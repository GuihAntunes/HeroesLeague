//
//  CoreDataService.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import CoreData
import UIKit

class CoreDataService: HeroesRepositoryProtocol {
    
    private var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    private let sectionsTitles = ["Comics", "Events", "Stories", "Series"]
    
    func searchHero(withName name: String, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        // Not necessary for local usage
    }
    
    
    func fetchHeroDetails(forHero heroId: Int, completion: @escaping RequesterCompletion<[MarvelCharacterDetailsResponse?]>) {
        DispatchQueue.main.async {
            guard let context = self.context else {
                completion(nil, CustomError.generalError("Failed to get local context!"))
                return
            }
            
            var comics: [HeroAppearance] = .init()
            var events: [HeroAppearance] = .init()
            var stories: [HeroAppearance] = .init()
            var series: [HeroAppearance] = .init()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataHeroDetails")
            do {
                guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                    completion(nil, CustomError.generalError("Failed to retrive local items!"))
                    return
                }
                for data in result {
                    let heroDetail = HeroAppearance()
                    heroDetail.id = data.value(forKey: "id") as? Int
                    heroDetail.title = data.value(forKey: "title") as? String
                    heroDetail.resourceURI = data.value(forKey: "detailType") as? String
                    heroDetail.description = data.value(forKey: "detailDescription") as? String
                    
                    if let resource = heroDetail.resourceURI {
                        if resource.contains(self.sectionsTitles[0].lowercased()) {
                            comics.append(heroDetail)
                        }
                        
                        if resource.contains(self.sectionsTitles[1].lowercased()) {
                            events.append(heroDetail)
                        }
                        
                        if resource.contains(self.sectionsTitles[2].lowercased()) {
                            stories.append(heroDetail)
                        }
                        
                        if resource.contains(self.sectionsTitles[3].lowercased()) {
                            series.append(heroDetail)
                        }
                    }
                }
                
                comics = comics.filter({ $0.id == heroId })
                events = events.filter({ $0.id == heroId })
                stories = stories.filter({ $0.id == heroId })
                series = series.filter({ $0.id == heroId })
                
                let comicsResponse = MarvelCharacterDetailsResponse(code: .init(), status: .init(), copyright: .init(), data: DetailsList(offset: .init(), limit: .init(), total: .init(), count: .init(), results: comics))
                let eventsResponse = MarvelCharacterDetailsResponse(code: .init(), status: .init(), copyright: .init(), data: DetailsList(offset: .init(), limit: .init(), total: .init(), count: .init(), results: events))
                let storiesResponse = MarvelCharacterDetailsResponse(code: .init(), status: .init(), copyright: .init(), data: DetailsList(offset: .init(), limit: .init(), total: .init(), count: .init(), results: stories))
                let seriesResponse = MarvelCharacterDetailsResponse(code: .init(), status: .init(), copyright: .init(), data: DetailsList(offset: .init(), limit: .init(), total: .init(), count: .init(), results: series))
                completion([comicsResponse, eventsResponse, storiesResponse, seriesResponse], nil)
                
            } catch {
                completion(nil, CustomError.generalError("Failed to load data from CoreData"))
            }
        }
    }
    
    
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        DispatchQueue.main.async {
            let heroes: [Hero] = self.retriveFavorites() ?? .init()
            
            let response = MarvelCharacterListResponse(code: .init(), status: .init(), copyright: .init(), data: HeroList(offset: .init(), limit: .init(), total: .init(), count: heroes.count, results: heroes))
            completion(response, nil)
        }
    }
    
    func saveHeroLocally(_ hero: Hero, details: [HeroAppearance]?, withThumbnail thumbnail: UIImage? = nil) {
        guard let context = context, let heroEntity = NSEntityDescription.entity(forEntityName: "CoreDataHero", in: context) else { return }
        let coreHero = NSManagedObject(entity: heroEntity, insertInto: context)
        coreHero.setValue(hero.name, forKey: "name")
        coreHero.setValue(hero.id, forKey: "id")
        if let imageData = thumbnail?.pngData() {
            coreHero.setValue(imageData, forKey: "image")
        }
        
        if let heroDetailsEntity = NSEntityDescription.entity(forEntityName: "CoreDataHeroDetails", in: context), let details = details {
            details.forEach({
                let coreHeroDetails = NSManagedObject(entity: heroDetailsEntity, insertInto: context)
                coreHeroDetails.setValue(hero.id, forKey: "id")
                coreHeroDetails.setValue($0.title, forKey: "title")
                coreHeroDetails.setValue($0.description, forKey: "detailDescription")
                coreHeroDetails.setValue($0.resourceURI, forKey: "detailType")
            })

        }
        
        
        do {
            try context.save()
        } catch {
            print("error on saving")
        }
    }
    
    func deleteHeroLocally(_ hero: Hero) {
        DispatchQueue.main.async {
            guard let context = self.context else { return }
            let heroFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataHero")
            let heroDetailsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataHeroDetails")
            heroFetchRequest.predicate = NSPredicate(format: "id = %i", hero.id ?? .init())
            heroDetailsFetchRequest.predicate = NSPredicate(format: "id = %i", hero.id ?? .init())
            guard let heroToDelete = try? context.fetch(heroFetchRequest).first as? NSManagedObject, let heroDetailsToDelete = try? context.fetch(heroDetailsFetchRequest) as? [NSManagedObject] else { return }
            context.delete(heroToDelete)
            heroDetailsToDelete.forEach({
                context.delete($0)
            })
            do {
                try context.save()
                
            } catch {
                print("Failed to fetch hero from CoreData and delete")
            }
        }
    }
    
    func retriveFavorites() -> [Hero]? {
        var heroes: [Hero] = .init()
        guard let context = self.context else {
            return nil
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataHero")
        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            for data in result {
                let hero = Hero()
                hero.id = data.value(forKey: "id") as? Int
                hero.name = data.value(forKey: "name") as? String
                hero.isFavorite = true
                hero.imageData = data.value(forKey: "image") as? Data
                heroes.append(hero)
            }
            
            return heroes
            
        } catch {
            return nil
        }
    }
}
