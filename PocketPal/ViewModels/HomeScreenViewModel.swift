import Foundation

class HomeScreenViewModel: ObservableObject{
    
    @Published var monthToSummarize: Date = .now
    
    var oldestEntryDate: Date{
        return Calendar.current.date(byAdding: .month, value: -7, to: .now)!
    }
    var latestEntryDate: Date = .now
    
    var summaryOfMonthText: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy"
        return dateFormatter.string(from: monthToSummarize)
    }
    
    private func shortenedMonthAndYear(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    // User Intents
    
    func changeMonth(by: Int){
        if let newDate = Calendar.current.date(byAdding: .month, value: by, to: monthToSummarize){
            monthToSummarize = newDate
        }
    }
    
    var previousMonthText: String {
        guard let date = Calendar.current.date(byAdding: .month, value: -1, to: monthToSummarize) else{
            return ""
        }
        
        return shortenedMonthAndYear(date: date)
    }
    var nextMonthText: String {
        guard let date = Calendar.current.date(byAdding: .month, value: 1, to: monthToSummarize) else{
            return ""
        }
        
        return shortenedMonthAndYear(date: date)
    }
    
}
