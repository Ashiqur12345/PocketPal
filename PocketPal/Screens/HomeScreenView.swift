import SwiftUI

struct HomeScreenView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
//                Text("Pocket Pal").font(.headline)
                Text("Summary of \(viewModel.summaryOfMonthText)").font(.title3).bold()
                
                Divider()
                            .padding()
                monthNavigationButtons
                MonthlySummaryView(date: viewModel.monthToSummarize)
                Spacer()
                addEntryButton.ignoresSafeArea()
            }
            .padding()
        }
    }
    
    private var monthNavigationButtons: some View{
        HStack{
            Button{
                viewModel.changeMonth(by: -1)
            } label:{
                Image(systemName: "chevron.left")
                Text(viewModel.previousMonthText)
            }
            .disabled(viewModel.monthToSummarize < viewModel.oldestEntryDate)
            
            Spacer()
            
            Button{
                viewModel.changeMonth(by: 1)
            } label:{
                Text(viewModel.nextMonthText)
                Image(systemName: "chevron.right")
            }
            .disabled(viewModel.monthToSummarize >= viewModel.latestEntryDate)
        }.font(.title3)
    }
    
    private var addEntryButton: some View{
        Button{
        } label:{
            HStack{
                Text("Add Entry")
                Image(systemName: "plus")
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(minHeight: 80)
            .background(Color.accentColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 100)
            )
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(viewModel: HomeScreenViewModel()).environment(\.managedObjectContext, Persistence.preview.container.viewContext)
    }
}
