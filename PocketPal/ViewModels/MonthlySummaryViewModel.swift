import Foundation

class MonthlySummaryViewModel: ObservableObject{
    
    var monthToSummarize: Date = .now
    
    init(date: Date = .now) {
        monthToSummarize = date
    }
    
}
