import SwiftUI

struct MonthlySummaryView: View {
    
    let viewModel: MonthlySummaryViewModel
    @Environment(\.managedObjectContext) private var context
    
    init(date: Date) {
        viewModel = MonthlySummaryViewModel(date: date)
    }
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Summary of ")
                
                Text(viewModel.summaryOfMonthText).bold()
            }.font(.title3)
            
            latestEntries.padding(.vertical)
            summaryPieChart
            Spacer()
        }
    }
    
    private var latestEntries: some View{
        Section("Latest Entries"){
            ScrollView(showsIndicators: false){
                VStack{
                    ForEach(-10..<0){ i in
                        NavigationLink{
                            Text("This is Item \(i * -1)").font(.title)
                        } label: {
                            Text("Item \(i * -1)").font(.title)
                                .padding(5)
                        }
                    }
                }
            }
        }
    }
    private var summaryPieChart: some View{
        Section("Pie Chart"){
            Circle()
        }
    }
}

struct MonthlySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySummaryView(date: .now).environment(\.managedObjectContext, Persistence.preview.container.viewContext)
    }
}
