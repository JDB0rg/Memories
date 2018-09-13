//
//  MemoryController.swift
//  Memories
//
//  Created by Madison Waters on 9/12/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

class MemoryController {
    
    private (set) var memories: [Memory] = []
    
    //// Crud Functions ////
    
    func create (title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    func update (memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        
        var scratch = memory
        
        scratch.title = title
        scratch.bodyText = bodyText
        scratch.imageData = imageData
        
        memories.remove(at: index)
        memories.insert(scratch, at: index)
        saveToPersistentStore()
    }
    
    func delete(memory: Memory) {
        if let index = memories.index(of: memory) {
            memories.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    //// File Persistance ////
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return directory.appendingPathComponent("memories.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(memories)
            try data.write(to: url)
            
        } catch {
            NSLog("Error Saving Memories data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            memories = try decoder.decode([Memory].self, from: data)
        } catch {
            NSLog("Error Loading Memories data: \(error)")
        }
        //Create a loadFromPersistentStore() method that will get the plist data from the persistentFileURL using the Data(contentsOf: URL) initializer. Using a PropertyListDecoder, decode the memories plist data back into an array of Memory objects. Set the model controller's memories variable to these newly decoded Memory objects.
    }
}








