import Foundation

enum SummaryExtent: String, CaseIterable, Identifiable{
    
    case daily
    case monthly
    case yearly
    
    var id: String{
        rawValue
    }
    
    var calendarComponent: Calendar.Component{
        switch self {
        case .daily:
            return .day
        case .monthly:
            return .month
        case .yearly:
            return .year
        }
    }
}

class SummaryViewModel: ObservableObject{
    
    @Published var summaryExtent: SummaryExtent{
        didSet{
            if date < oldestEntryDate{
                date = latestEntryDate
            }
    
            if date > latestEntryDate{
                date = latestEntryDate
            }
        }
    }
    @Published var date: Date
    
    init(summaryExtent: SummaryExtent = .monthly, date: Date = .now) {
        self.summaryExtent = summaryExtent
        self.date = date
    }
    
    var oldestEntryDate: Date{
        return Calendar.current.date(byAdding: summaryExtent.calendarComponent, value: -50, to: .now)!
    }
    
    var latestEntryDate: Date = .now
    
    var currentDateText: String{
        
        if Calendar.current.compare(date, to: .now, toGranularity: summaryExtent.calendarComponent) == .orderedSame{
            switch summaryExtent.calendarComponent {
            case .day:
                return "Today"
            case .month:
                return "This Month"
            case .year:
                return "This Year"
            default: break
            }
        }
        let dateFormatter = DateFormatter()
        
        switch summaryExtent.calendarComponent {
        case .day:
            dateFormatter.dateFormat = "MMM dd, yyyy"
        case .month:
            dateFormatter.dateFormat = "MMM yyyy"
        case .year:
            dateFormatter.dateFormat = "yyyy"
        default:
            dateFormatter.dateFormat = "MMM dd, yyyy"
        }
        return dateFormatter.string(from: date)
    }
    
    var previousDateText: String {
        
        if let date = Calendar.current.date(byAdding: summaryExtent.calendarComponent, value: -1, to: date){
            return shortenedDateDescription(date: date)
        }
        
        return ""
    }
    
    var nextDateText: String {
        
        if let date = Calendar.current.date(byAdding: summaryExtent.calendarComponent, value: 1, to: date){
            return shortenedDateDescription(date: date)
        }
        return ""
    }
    
    var canVisitPreviousDate: Bool {
        if let previousDate = Calendar.current.date(byAdding: summaryExtent.calendarComponent, value: -1, to: date){
            return Calendar.current.compare(previousDate, to: oldestEntryDate, toGranularity: summaryExtent.calendarComponent) != .orderedAscending
        }
        return false
    }
    
    var canVisitNextDate: Bool {
        if let nextDate = Calendar.current.date(byAdding: summaryExtent.calendarComponent, value: 1, to: date){
            return Calendar.current.compare(nextDate, to: latestEntryDate, toGranularity: summaryExtent.calendarComponent) != .orderedDescending
        }
        return false
    }
    
    private func shortenedDateDescription(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        switch summaryExtent.calendarComponent {
        case .day:
            dateFormatter.dateFormat = "MMM dd"
        case .month:
            dateFormatter.dateFormat = "MMM yyyy"
        case .year:
            dateFormatter.dateFormat = "yyyy"
        default:
            dateFormatter.dateFormat = "MMM dd, yyyy"
        }
        
        
        return dateFormatter.string(from: date)
    }
    
    // User Intents
    
    func gotoPreviousDate(){
        
        if let previousDate = Calendar.current.date(byAdding: summaryExtent.calendarComponent, value: -1, to: date){
            date = previousDate
        }
    }
    
    func gotoNextDate(){

        if let nextDate = Calendar.current.date(byAdding: summaryExtent.calendarComponent, value: 1, to: date){
            date = nextDate
        }
    }
    
    func gotoLatestDate(){
        date = latestEntryDate
    }
}
