import SwiftUI

struct SummaryView: View {
    
    @ObservedObject var viewModel: SummaryViewModel
    var showNavigator: Bool
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        VStack{
            Text(viewModel.currentDateText).bold().font(.title3)
            summaryExtentNavigationButtons.padding(5)
            
            if showNavigator {
                summaryDateNavigationButtons
            }
            
            summaryPieChart
            Divider()
            latestEntries
            Spacer()
        }
    }
    
    private var summaryExtentNavigationButtons: some View{
        HStack{
            
            ForEach(SummaryViewModel.SummaryExtent.allCases, id: \.rawValue){ extent in 
                
                Button{
                    viewModel.changeSummaryExtent(extent: extent)
                } label:{
                    Text(extent.rawValue)
                }
                .disabled(viewModel.summaryExtent == extent)
            }
            
        }
        .padding(.horizontal)
    }
    
    private var summaryDateNavigationButtons: some View{
        HStack{
            Button{
                viewModel.summarizePreviousDate()
            } label:{
                Image(systemName: "chevron.backward")
                Text(viewModel.previousDateText)
            }
            .disabled(!viewModel.canVisitPreviousDate)
            
            Spacer()
            
            HStack{
                
                Button{
                    viewModel.summarizeNextDate()
                } label:{
                    Text(viewModel.nextDateText)
                    Image(systemName: "chevron.forward")
                }
                .disabled(!viewModel.canVisitNextDate)
                
                if viewModel.canVisitNextDate{
                    Button{
                        viewModel.summarizeLatestDate()
                    } label:{
                        Image(systemName: "chevron.forward.to.line")
                    }
                }
            }
            
        }.font(.title3)
            .padding(.horizontal)
    }
    
    private var latestEntries: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Latest entries of")
                Text(viewModel.currentDateText).bold()
            }
                .font(.subheadline).padding(.horizontal)
            
            List(-10..<0){ i in
                NavigationLink{
                    Text("This is Item \(i * -1)").font(.title)
                } label: {
                    Text("Item \(i * -1)").font(.title2)
                        .padding(5)
                }
            }.listStyle(.inset)
        }
    }
    
    private var summaryPieChart: some View{
        Circle()
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(viewModel: SummaryViewModel(summary: Summary(date: .now, extent: .monthly)), showNavigator: true)
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
