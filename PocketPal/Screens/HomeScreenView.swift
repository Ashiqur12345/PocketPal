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
                    SummaryView(viewModel: SummaryViewModel(summary: Summary(date: .now, extent: .monthly)), showNavigator: true)
                    Spacer()
                }
                .toolbar{
                    ToolbarItem(placement: .bottomBar){
                        addEntryButton
                    }
                }
                .navigationTitle("Home")
                .navigationBarHidden(true)
            }
        }.ignoresSafeArea(.all, edges: [.bottom])
    }
    
    private var addEntryButton: some View{
        Button{
            
        } label:{
            Label("Add Entry", systemImage: "plus.circle")
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .frame(height: 100)
                .frame(minWidth: 250, maxWidth: .infinity)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding([.top])
        }
        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(viewModel: HomeScreenViewModel()).environment(\.managedObjectContext, Persistence.preview.container.viewContext)
    }
}
