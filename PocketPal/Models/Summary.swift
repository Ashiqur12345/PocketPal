import Foundation

struct Summary{
    
    enum Extent: String, CaseIterable{
        case daily = "Daily"
        case monthly = "Monthly"
        case yearly = "Yearly"
    }
    var extent: Extent{
        
        get{
            switch by {
            case .day:
                return .daily
            case .month:
                return .monthly
            case .year:
                return .yearly
            default:
                return .monthly
            }
        }
        
        set{
            switch newValue {
            case .daily:
                self.by = .day
            case .monthly:
                self.by = .month
            case .yearly:
                self.by = .year
            }
        }
    }
    var date: Date
    private(set) var by: Calendar.Component = .month
    
    init(date: Date, extent: Extent) {
        self.date = date
        self.extent = extent
    }
}
