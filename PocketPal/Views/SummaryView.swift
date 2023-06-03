import SwiftUI

struct SummaryView: View {
    
    @ObservedObject var viewModel: SummaryViewModel
    var showNavigator: Bool
    var showGraph: Bool
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        VStack{
            Text(viewModel.currentDateText).bold().font(.title3)
            
            if showNavigator {
                VStack{
                    summaryExtentNavigationButtons
                    summaryDateNavigationButtons
                }
            }
            
            if showGraph{
                summaryPieChart
                Divider()
            }
            
            entryList
            Spacer()
        }
    }
    
    
    private var summaryExtentNavigationButtons: some View{
        Picker("", selection: $viewModel.summaryExtent){
            ForEach(SummaryExtent.allCases){ extent in
                
                Text(extent.rawValue.capitalized).tag(extent)
                
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var summaryDateNavigationButtons: some View{
        HStack{
            Button{
                viewModel.gotoPreviousDate()
            } label:{
                Image(systemName: "chevron.backward")
                Text(viewModel.previousDateText)
            }
            .disabled(!viewModel.canVisitPreviousDate)
            
            Spacer()
            
            HStack{
                
                Button{
                    viewModel.gotoNextDate()
                } label:{
                    Text(viewModel.nextDateText)
                    Image(systemName: "chevron.forward")
                }
                .disabled(!viewModel.canVisitNextDate)
                
                if viewModel.canVisitNextDate{
                    Button{
                        viewModel.gotoLatestDate()
                    } label:{
                        Image(systemName: "chevron.forward.to.line")
                    }
                }
            }
            
        }.font(.title3)
            .padding(.horizontal)
    }
    
    private var entryList: some View{
        VStack(alignment: .leading){
            List(-20..<0){ i in
                
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
        SummaryView(viewModel: SummaryViewModel(context: PersistenceController.preview.viewContext), showNavigator: true, showGraph: true)
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
