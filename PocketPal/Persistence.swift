import CoreData

class Persistence{
    let container: NSPersistentContainer
    private init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "PocketPal")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores{ description, error in
            if let error {
                fatalError("Core data load error. \(error)")
            }
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
    }
    
    
    static let shared: Persistence = Persistence()
    
    static var preview: Persistence = {
        let result = Persistence(inMemory: true)
        let viewContext = result.container.viewContext

        loadDummyData(context: viewContext)
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    private static func loadDummyData(context: NSManagedObjectContext){
        
        let incomeEntry = Entry(context: context)
        incomeEntry.title = "Dummy INCOME"
        incomeEntry.isExpense = false
        incomeEntry.amount = 500
        incomeEntry.time = .now
        incomeEntry.details = "This is a dummy income"
        
        let expenseEntry = Entry(context: context)
        expenseEntry.title = "Dummy EXPENSE"
        expenseEntry.isExpense = true
        expenseEntry.amount = 100
        expenseEntry.time = .now
        expenseEntry.details = "This is a dummy expense"
    }
}
