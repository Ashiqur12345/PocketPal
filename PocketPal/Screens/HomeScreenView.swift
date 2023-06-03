import SwiftUI

enum HomeTabs{
    case home
    case search
    case stats
}

struct HomeScreenView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @ObservedObject var viewModel: HomeScreenViewModel
    
    @State var selectedTab: HomeTabs = .home
    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                homeTab
                searchTab
                statsTab
            }
        }.ignoresSafeArea(.all, edges: [.bottom])
    }
    
    private var homeTab: some View{
        
        NavigationStack{
            VStack{
                Text("Pocket Pal").font(.title).bold()
                
                ZStack {
                    EntryListView(viewModel: EntryListViewModel(context: context, dateRange: DateInterval.init(start: .now, duration: 1)))
                    VStack{
                        Spacer()
                        addEntryButton
                            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                            .padding([.bottom, .trailing])
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
            /*.toolbar{
                ToolbarItem{
                    Button{
                        
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }*/
        }
        .tabItem {
            Label("Home", systemImage: "house")
        }
        .tag(HomeTabs.home)
    }
    
    private var searchTab: some View{
        NavigationStack{
            Text("Search")
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Search")
        }
        .tabItem {
            Label("Search", systemImage: "magnifyingglass")
        }
        .tag(HomeTabs.search)
    }
    
    private var statsTab: some View{
        NavigationStack{
            VStack{
                SummaryView(viewModel: SummaryViewModel(context: context), showNavigator: true, showGraph: true)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Stats")
        }
        .tabItem {
            Label("Stats", systemImage: "chart.xyaxis.line")
        }
        .tag(HomeTabs.stats)
    }
    
    private var addEntryButton: some View{
        NavigationLink{
            EntryInputView(viewModel: EntryInputViewModel(context: context))
                .navigationTitle("Add New Entry")
        } label: {
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(viewModel: HomeScreenViewModel()).environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
