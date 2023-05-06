import Foundation

class ArcTaskGroupStorage {
    private let fileName = "data"
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func load() -> [ArcTaskGroup] {
        let fileURL = getDocumentDirectory().appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let arcTaskGroups = try decoder.decode([ArcTaskGroup].self, from: data)
            return arcTaskGroups
        } catch {
            print("Error loading ArcTaskGroups: \(error)")
            return []
        }
    }
    
    func save(arcTaskGroups: [ArcTaskGroup]) {
        let fileURL = getDocumentDirectory().appendingPathComponent(fileName)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(arcTaskGroups)
            try data.write(to: fileURL)
        } catch {
            print("Error saving ArcTaskGroups: \(error)")
        }
    }
    
    // CRUD operations
    
    // Create
    func create(arcTaskGroup: ArcTaskGroup) {
        var arcTaskGroups = load()
        arcTaskGroups.append(arcTaskGroup)
        save(arcTaskGroups: arcTaskGroups)
    }
    
    // Read
    func read() -> [ArcTaskGroup] {
        return load()
    }
    
    // Update
    func update(arcTaskGroup: ArcTaskGroup) {
        var arcTaskGroups = load()
        if let index = arcTaskGroups.firstIndex(where: { $0.id == arcTaskGroup.id }) {
            arcTaskGroups[index] = arcTaskGroup
            save(arcTaskGroups: arcTaskGroups)
        }
    }
    
    // Delete
    func delete(arcTaskGroup: ArcTaskGroup) {
        var arcTaskGroups = load()
        arcTaskGroups.removeAll(where: { $0.id == arcTaskGroup.id })
        save(arcTaskGroups: arcTaskGroups)
    }
}
