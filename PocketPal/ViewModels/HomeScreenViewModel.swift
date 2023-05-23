import Foundation

class HomeScreenViewModel: ObservableObject{
    
    @Published var monthToSummarize: Date = .now
    
    var oldestEntryDate: Date{
        return Calendar.current.date(byAdding: .month, value: -7, to: .now)!
    }
    var latestEntryDate: Date{
        var dateComponents = DateComponents()
        dateComponents.year = Calendar.current.component(.year, from: monthToSummarize)
        dateComponents.month = Calendar.current.component(.month, from: monthToSummarize)
        dateComponents.day = Calendar.current.component(.day, from: monthToSummarize)
        
        return /*Calendar.current.date(from: dateComponents) ??*/ .now
    }
    
    private func shortenedMonthAndYear(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    var previousMonthText: String {
        
        if let date = monthToSummarize.changeMonth(by: -1){
            return shortenedMonthAndYear(date: date)
        }
        return ""
    }
    var nextMonthText: String {
        
        if let date = monthToSummarize.changeMonth(by: 1){
            return shortenedMonthAndYear(date: date)
        }
        return ""
    }
    
    var enablePreviousMonth: Bool {
        if let previousMonth = monthToSummarize.changeMonth(by: -1){
            return Calendar.current.compare(previousMonth, to: oldestEntryDate, toGranularity: .month) != .orderedAscending
        }
        return false
    }
    
    var enableNextMonth: Bool {
        if let nextMonth = monthToSummarize.changeMonth(by: 1){
            return Calendar.current.compare(nextMonth, to: latestEntryDate, toGranularity: .month) != .orderedDescending
        }
        return false
    }
    
    
    // User Intents
    func summarizeNextMonth(){
        if let date = monthToSummarize.changeMonth(by: 1){
            monthToSummarize = date
        }
    }
    
    func summarizePreviousMonth(){
        if let date = monthToSummarize.changeMonth(by: -1){
            monthToSummarize = date
        }
    }
}
