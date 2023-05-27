import Foundation
import CoreData

class EntryInputViewModel: ObservableObject{
    
    @Published var entryTitle: String = ""
    @Published var entryPrice: Double = 0
    
    @Published var entryIsExprense: Bool = true
    
    @Published var entryDate: Date = .now
    
    @Published var entryDetails: String = ""
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.context.parent = context
    }
}
