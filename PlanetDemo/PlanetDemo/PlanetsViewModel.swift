//
//  PlanetsViewModel.swift
//  PlanetDemo
//
//  Created by Tripathi, Himani on 1/8/19.
//  Copyright © 2019 Tripathi, Himani. All rights reserved.
//

import Foundation
import CoreData

class PlanetsViewModel {
    var planets = Planets(results: [])
    
    let persistentManager = PersistentManager.shared
    
    func fetchData(completion: @escaping () -> ()) {
        APIManager.getDeatils {[weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            if error == nil {
                strongSelf.planets = response
                strongSelf.saveData()
                completion()
            }
        }
    }
    
    func saveData() {
        guard !planets.results.isEmpty else { return }
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Asteroids", in: persistentManager.context)!
        
        for result in planets.results {
            let planet = NSManagedObject(entity: entity,
                                         insertInto: persistentManager.context)
            planet.setValue(result.name, forKeyPath: "name")
            planet.setValue(result.rotationPeriod, forKeyPath: "rotationPeriod")
            planet.setValue(result.orbitalPeriod, forKeyPath: "orbitalPeriod")
            planet.setValue(result.climate, forKeyPath: "climate")
            planet.setValue(result.diameter, forKeyPath: "diameter")
            planet.setValue(result.gravity, forKeyPath: "gravity")
            planet.setValue(result.terrain, forKeyPath: "terrain")
            planet.setValue(result.surfaceWater, forKeyPath: "surfaceWater")
            planet.setValue(result.terrain, forKeyPath: "terrain")
            planet.setValue(result.population, forKeyPath: "population")
            planet.setValue(result.created, forKeyPath: "created")
            planet.setValue(result.edited, forKeyPath: "edited")
            planet.setValue(result.url, forKeyPath: "url")
            planet.setValue(result.residents, forKeyPath: "residents")
            planet.setValue(result.films, forKeyPath: "films")
            persistentManager.save()
        }
    }
    
    func loadData(completion: () -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Asteroids")
        
        do {
            let result = try persistentManager.context.fetch(fetchRequest)
            var planetList: [Planet] = []
            for data in result {
                let planetObj = configurePlanet(data: data)
                planetList.append(planetObj)
                
            }
            self.planets.results = planetList
            completion()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteData(completion: () -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Asteroids")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try persistentManager.context.fetch(fetchRequest)
            for data in result {
                persistentManager.context.delete(data)
            }
        } catch {
            print("unable to delete records")
        }
        
        persistentManager.save()
        planets.results = []
        completion()
    }
    
    func entityIsEmpty(entity: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        
        do {
            let result = try persistentManager.context.fetch(fetchRequest)
            return result.count == 0 ? true : false
        } catch _ as NSError {
            return true
        }
    }
    
    func configurePlanet(data: NSManagedObject) -> Planet {
        let name = data.value(forKey: "name") as! String
        let rotationPeriod = data.value(forKey: "rotationPeriod") as! String
        let orbitalPeriod = data.value(forKey: "orbitalPeriod") as! String
        let diameter = data.value(forKey: "diameter") as! String
        let climate = data.value(forKey: "climate") as! String
        let gravity = data.value(forKey: "gravity") as! String
        let terrain = data.value(forKey: "terrain") as! String
        let surfaceWater = data.value(forKey: "surfaceWater") as! String
        let population = data.value(forKey: "population") as! String
        let residents = data.value(forKey: "residents") as! [String]
        let films = data.value(forKey: "films") as! [String]
        let created = data.value(forKey: "created") as! String
        let edited = data.value(forKey: "edited") as! String
        let url = data.value(forKey: "url") as! String
        
        let planet = Planet(name: name, rotationPeriod: rotationPeriod, orbitalPeriod: orbitalPeriod, diameter: diameter, climate: climate, gravity: gravity, terrain: terrain, surfaceWater: surfaceWater, population: population, residents: residents, films: films, created: created, edited: edited, url: url)
        return planet
    }
}
