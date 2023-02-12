////
////  EvensViewModel.swift
////  Simplify
////
////  Created by Fatma Gazwani on 24/06/1444 AH.
////
//
//import Foundation
//import CoreData
//import SwiftUI
//
//
//class AddingEventView {
//    @MainActor class ViewModel: ObservableObject {
//        
//        @Published var dueDate = Date()
//        @Published var showsheet: Bool = false
//        @Published var showingDetail = false
//        @Published var selectedColor: BordersColor = .blue
//        @Published var selectedDate = Date()
//        @Published var name: String = ""
//        @Published var ColorsPickers: BordersColor = .blue
//        @Published var duedate: String = ""
//        
//        @Environment(\.managedObjectContext)  var viewContext
//        @FetchRequest(entity: Event.entity(), sortDescriptors: [NSSortDescriptor(key: "duedate", ascending: true)]) private var allEvents: FetchedResults<Event>
//        
//        func addEvent() {
//            print(allEvents)
//            do {
//                let event = Event(context: viewContext)
//                event.name = name
//                event.thecolor = ColorsPickers.rawValue
//                event.duedate = dueDate
//                try viewContext.save()
//            }catch{
//                print(error.localizedDescription)
//            }
//        }
//        
//        func deleteEvent (at offsets: IndexSet) {
//            offsets.forEach {
//                index in
//                let event = allEvents[index]
//                viewContext.delete(event)
//                do {
//                    try viewContext.save()
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        
//        func theSelectedColor(_ value: String) -> BordersColor {
//            return BordersColor(rawValue: value) ?? .blue
//        }
//        
//        var dateClosedRange: ClosedRange<Date> {
//            let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
//            let max = Calendar.current.date(byAdding: .day, value: 365, to: Date())!
//            return min...max
//        }
//    }
//}
//
//
//extension BordersColor {
//    var id: UUID {
//        return UUID()
//    }
//    public var title: String {
//        switch self {
//        case .red:
//            return "Red"
//        case .yellow:
//            return "Yellow"
//        case .orange:
//            return "Orange"
//        case .purple:
//            return "Purple"
//        case .blue:
//            return "Blue"
//        case .indigo:
//            return "Indigo"
//        case .green:
//            return "Green"
//        case .mint:
//            return "Mint"
//        }
//    }
//
//        func theSelectedColor(_ value: String) -> Color{
//            let  thecolor = BordersColor(rawValue: value)
//
//            switch thecolor {
//            case .red:
//                return Color.red
//            case .yellow:
//                return Color.yellow
//            case .orange:
//                return Color.orange
//            case .purple:
//                return Color.purple
//            case .blue:
//                return Color.blue
//            case .indigo:
//                return Color.indigo
//            case .green:
//                return Color.green
//            case .mint:
//                return Color.mint
//            case .none:
//                return Color.blue
//            }
//        }
//        var dateClosedRange: ClosedRange<Date> {
//            let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
//            let max = Calendar.current.date(byAdding: .day, value: 365, to: Date())!
//            return min...max
//        }
//    }
//
//
//
