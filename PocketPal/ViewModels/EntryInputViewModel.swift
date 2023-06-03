import Foundation
import CoreData

class EntryInputViewModel: ObservableObject{
    
    @Published var entryTitle: String
    
    @Published var entryPrice: Double
    
    @Published var entryIsExprense: Bool
    
    @Published var entryTime: Date
    
    @Published var entryDetails: String
        
    
    private var isTitleValid: Bool{
        return entryTitle.count > 2
    }
    private var isPriceValid: Bool{
        return entryPrice > 0
    }
    @Published var errorMessage: String = ""

    private var entry: Entry
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, editableEntry: Entry? = nil) {
        self.context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.context.parent = context
        
        if let entry = editableEntry{
            self.entry = entry
        }
        else{
            self.entry = Entry(context: context)
        }
        
        entryTitle = entry.title ?? ""
        entryPrice = entry.price
        entryIsExprense = entry.isExpense
        entryTime = entry.time ?? .now
        entryDetails = entry.details ?? ""
    }
    
    // User Intents
    
    func submitForm(){
        
        if !isTitleValid{
            errorMessage = "Invalid Title"
            return
        }
        if !isPriceValid{
            errorMessage = "Price must be a positive number"
            return
        }
        errorMessage = ""
                   
        entry.title = entryTitle
        entry.price = entryPrice
        entry.isExpense = entryIsExprense
        entry.time = entryTime
        entry.details = entryDetails
        
        do{
            try context.save()
            try context.parent?.save()
        }
        catch{
            errorMessage = "Failed to save"
            print("Entry save failed", error.localizedDescription)
        }
    }
    
    func cancel(){
        context.rollback()
        context.parent?.rollback()
    }
    
    
}
