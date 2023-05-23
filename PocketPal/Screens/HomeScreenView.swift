import SwiftUI

struct HomeScreenView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        VStack{
            NavigationStack{
                VStack{
                    Text("Pocket Pal").font(.title).bold()
                    
                    Divider()
                    
                    monthNavigationButtons
                    
                    MonthlySummaryView(date: viewModel.monthToSummarize)
                        .padding(.vertical)
                }
            }
            addEntryButton
        }.ignoresSafeArea(.all, edges: [.bottom])
    }
    
    private var monthNavigationButtons: some View{
        HStack{
            Button{
                viewModel.summarizePreviousMonth()
            } label:{
                Image(systemName: "chevron.left")
                Text(viewModel.previousMonthText)
            }
            .disabled(!viewModel.enablePreviousMonth)
            
            Spacer()
            
            Button{
                viewModel.summarizeNextMonth()
            } label:{
                Text(viewModel.nextMonthText)
                Image(systemName: "chevron.right")
            }
            .disabled(!viewModel.enableNextMonth)
        }.font(.title3)
            .padding(.horizontal)
    }
    
    private var addEntryButton: some View{
        
        Button{
        } label:{
            Label("Add Entry", systemImage: "plus.circle")
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 50))
        }
        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(viewModel: HomeScreenViewModel()).environment(\.managedObjectContext, Persistence.preview.container.viewContext)
    }
}
