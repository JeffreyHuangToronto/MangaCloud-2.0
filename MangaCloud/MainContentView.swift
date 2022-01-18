//
//  ContentView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-11-20.
//

import SwiftUI

struct MainContentView: View {
    @StateObject var viewRouter: ViewRouter
    @StateObject var userLibraryViewModel = LibraryViewModel()
    @StateObject var latestViewModel = LatestViewModel()
    
    @State var lastPage: Page = .library
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    // Decide which view to show
                    switch viewRouter.currentPage {
                    case .library:
                        LibraryView()
                    case .latest:
                        LatestView(viewModel: latestViewModel)
                    case .settings:
                        Settings()
                    }
                    Spacer()
                    // Tab bar items
                    HStack {
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .library, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "bookmark.circle.fill", tabName: "Library")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .latest, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "books.vertical.fill", tabName: "Latest")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .settings, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "gearshape.fill", tabName: "Settings")
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/8)
                    .background(Color("TabBarBackground").shadow(radius: 2))
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .environmentObject(userLibraryViewModel)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainContentView(viewRouter: ViewRouter())
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct TabBarIcon: View {
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture {
            if (viewRouter.currentPage != assignedPage){
                viewRouter.currentPage = assignedPage
            }
        }
    }
}
