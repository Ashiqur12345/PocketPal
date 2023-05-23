import Foundation

class SummaryViewModel: ObservableObject{
    
    typealias SummaryExtent = Summary.Extent
    
    @Published private var summary: Summary
    
    init(summary: Summary) {
        self.summary = summary
    }
    
    var summaryExtent: Summary.Extent{
        return summary.extent
    }
    
    var oldestEntryDate: Date{
        return Calendar.current.date(byAdding: summary.by, value: -3, to: .now)!
    }
    
    var latestEntryDate: Date = .now
    
    var currentDateText: String{
        
        if Calendar.current.compare(summary.date, to: .now, toGranularity: summary.by) == .orderedSame{
            switch summary.by {
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
        
        switch summary.by {
        case .day:
            dateFormatter.dateFormat = "MMM dd, yyyy"
        case .month:
            dateFormatter.dateFormat = "MMM yyyy"
        case .year:
            dateFormatter.dateFormat = "yyyy"
        default:
            dateFormatter.dateFormat = "MMM dd, yyyy"
        }
        return dateFormatter.string(from: summary.date)
    }
    
    var previousDateText: String {
        
        if let date = Calendar.current.date(byAdding: summary.by, value: -1, to: summary.date){
            return shortenedDateDescription(date: date)
        }
        
        return ""
    }
    
    var nextDateText: String {
        
        if let date = Calendar.current.date(byAdding: summary.by, value: 1, to: summary.date){
            return shortenedDateDescription(date: date)
        }
        return ""
    }
    
    var canVisitPreviousDate: Bool {
        if let previousDate = Calendar.current.date(byAdding: summary.by, value: -1, to: summary.date){
            return Calendar.current.compare(previousDate, to: oldestEntryDate, toGranularity: summary.by) != .orderedAscending
        }
        return false
    }
    
    var canVisitNextDate: Bool {
        if let nextDate = Calendar.current.date(byAdding: summary.by, value: 1, to: summary.date){
            return Calendar.current.compare(nextDate, to: latestEntryDate, toGranularity: summary.by) != .orderedDescending
        }
        return false
    }
    
    private func shortenedDateDescription(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        switch summary.by {
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
    
    func summarizePreviousDate(){
        
        if let previousDate = Calendar.current.date(byAdding: summary.by, value: -1, to: summary.date){
            summary.date = previousDate
        }
    }
    
    func summarizeNextDate(){

        if let nextDate = Calendar.current.date(byAdding: summary.by, value: 1, to: summary.date){
            summary.date = nextDate
        }
    }
    
    func summarizeLatestDate(){
        summary.date = latestEntryDate
    }
    
    func changeSummaryExtent(extent: SummaryExtent){
        summary.extent = extent
        
        if summary.date < oldestEntryDate{
            summary.date = latestEntryDate
        }
        
        if summary.date > latestEntryDate{
            summary.date = latestEntryDate
        }
    }
    
}
