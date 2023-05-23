import Foundation

class MonthlySummaryViewModel: ObservableObject{
    
    var summaryOfMonth: Date = .now
    
    var summaryOfMonthText: String{
        
        if Calendar.current.compare(summaryOfMonth, to: .now, toGranularity: .month) == .orderedSame{
            return "This Month"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: summaryOfMonth)
    }
    
    init(date: Date = .now) {
        summaryOfMonth = date
    }
    
}
