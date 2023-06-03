import CoreData

class EntryListViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext
    private let dateRange: DateInterval
    
    @Published private(set) var listItems: [EntryViewModel] = []
    
    init(context: NSManagedObjectContext, dateRange: DateInterval) {
        self.context = context
        self.dateRange = dateRange
        
        for i in 0..<21 {
            let entry = Entry(context: context)
            entry.title = "Entry \(i)"
            listItems.append(EntryViewModel(entry: entry))
        }
    }
}
