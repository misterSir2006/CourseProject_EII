import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CourseProject_EII")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func observerEntity(id: Int, x_coord: Double, y_coord: Double, acod_date: String,
                   acod_title: String, timestamp: String) -> ObserverEntity {
        let obs = ObserverEntity(context: persistentContainer.viewContext)
        
        obs.id = Int16(id)
        obs.x_coord = x_coord
        obs.y_coord = y_coord
        obs.acod_date = acod_date
        obs.acod_title = acod_title
        obs.timestamp = timestamp
        
        return obs
    }
    
    func observerEntities() -> [ObserverEntity] {
        let request: NSFetchRequest<ObserverEntity> = ObserverEntity.fetchRequest()
        var fetchedEntites: [ObserverEntity] = []
        
        do {
            fetchedEntites = try persistentContainer.viewContext.fetch(request)
            save()
        } catch let error {
            print(error)
        }
        
        return fetchedEntites
    }
    
    func save() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
