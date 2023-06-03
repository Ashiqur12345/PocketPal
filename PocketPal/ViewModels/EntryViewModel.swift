import CoreData

class EntryViewModel: ObservableObject, Identifiable {
    
    private let entry: Entry
    
    init(entry: Entry) {
        self.entry = entry
    }
    
    var id: NSManagedObjectID{
        entry.objectID
    }
    
    var title: String{
        entry.title ?? "Untitled Entry"
    }
    
    var isExpense: Bool{
        entry.isExpense
    }
    var price: Double{
        entry.price
    }
    
    var time: Date{
        entry.time ?? .distantPast
    }
    
    var details: String{
        entry.details ?? ""
    }
    
}
