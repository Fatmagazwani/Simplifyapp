////
////  EventsView.swift
////  Simplify
////
////  Created by Fatma Gazwani on 25/06/1444 AH.
////
//
//import SwiftUI
//import CoreData
//import UserNotifications
//
//struct EventsView: View {
//    
//    //    @StateObject private var viewModel = ViewModel()
//    @Environment(\.managedObjectContext) var viewContext
//    @FetchRequest(entity: Event.entity(), sortDescriptors: [NSSortDescriptor(key: "duedate", ascending: true)])  var allEvents: FetchedResults<Event>
//    
//    
//    var body: some View {
//        
//        VStack{
//            AddingEvent()
//            
//            if(allEvents.isEmpty) {
//                ZStack{
//                    EmptyView()
//                }
//                
//            } else {
//                
//                ZStack{
//                    ListView()
//                }
//            }
//        }
//    }
//    
//}
//struct EventsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let persistentContainer = CoreDataManager.shared.persistentContainer
//        EventsView().environment(\.managedObjectContext, persistentContainer.viewContext)
//    }
//}
//
//
