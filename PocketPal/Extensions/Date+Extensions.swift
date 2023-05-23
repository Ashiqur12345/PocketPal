import Foundation

extension Date{
    func changeMonth(by: Int) -> Date?{
        Calendar.current.date(byAdding: .month, value: by, to: self)
    }
}
