////
////  AddingEvent.swift
////  Simplify
////
////  Created by Fatma Gazwani on 25/06/1444 AH.
////
//
//import SwiftUI
//import CoreData
//import UserNotifications
//
//
//    enum BordersColor: String, Identifiable, CaseIterable {
//        var id: UUID {
//            return UUID()
//        }
//        case red = "red"
//        case yellow = "yellow"
//        case orange = "orange"
//        case purple = "purple"
//        case blue = "blue"
//        case indigo = "indigo"
//        case green = "green"
//        case mint = "mint"
//    }
//
//    extension BordersColor {
//         var title: String {
//            switch self {
//            case .red:
//                return "Red"
//            case .yellow:
//                return "Yellow"
//            case .orange:
//                return "Orange"
//            case .purple:
//                return "Purple"
//            case .blue:
//                return "Blue"
//            case .indigo:
//                return "Indigo"
//            case .green:
//                return "Green"
//            case .mint:
//                return "Mint"
//
//            }
//        }
//    }
//
//func DueDateString(){
//    let duedate = Date()
//    let format = duedate.getFormattedDate(format: "yyyy-MM-dd")
//}
//    struct AddingEvent: View {
//        @State  var name: String = ""
//        @State  var ColorsPickers: BordersColor = .blue
//        @State  var duedate: String = ""
//        @Environment(\.managedObjectContext)  var viewContext
//        @FetchRequest(entity: Event.entity(), sortDescriptors: [NSSortDescriptor(key: "duedate", ascending: true)])  var allEvents: FetchedResults<Event>
//
//         func addEvent() {
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
//         func theSelectedColor(_ value: String) -> Color{
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
//
//         func deleteEvent (at offsets: IndexSet) {
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
//    //    @StateObject private var viewModel = ViewModel()
//        @State  var dueDate = Date()
//        @State  var showsheet: Bool = false
////        @State  var showingDetail = false
//        @State var selectedDate = Date()
//        @State  var selectedColor: Color = .blue
//
//
//        @Environment(\.dismiss) var dismiss
//
//        var dateClosedRange: ClosedRange<Date> {
//            let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
//            let max = Calendar.current.date(byAdding: .day, value: 365, to: Date())!
//            return min...max
//        }
//
//
//    var body: some View {
//
//        VStack{
//            VStack{
//                HStack(alignment: .top){
//                    Spacer()
//                    Button("Add_") {
//
//                        showsheet = true
//                    }.accessibilityLabel("Addـaـnewـevent")
//
//
//                        .sheet(isPresented: $showsheet) {
//                            ScrollView{
//                                VStack {
//
//                                    DatePicker("Please_choose_a_date", selection: $dueDate,
//                                               in: dateClosedRange)
//                                        .accessibilityLabel("Please_choose_a_date")
//                                        .padding([.leading, .bottom, .trailing])
//                                        .labelsHidden()
//                                        .datePickerStyle(.graphical)
////
////                                    VStack(alignment: .leading){
////                                        Text("Event_Name:")
////                                            .font(.title3)
////                                            .fontWeight(.semibold)
////                                        TextField("Event_Name", text: $name)
////                                            .textFieldStyle(.roundedBorder)
////                                            .accessibilityLabel("Enter_event_Name")
////                                    }.padding()
//
////                                    Picker("Pick_a_color_for_the_event_borders", selection: $ColorsPickers) {
////                                        ForEach(BordersColor.allCases) { thecolor in
////                                            Text(thecolor.title).tag(thecolor)
////                                                .fontWeight(.bold)
////
////                                        }.pickerStyle(.segmented)
////                                    }.padding(.horizontal)
//
////                                    Notification()
//
//                                    Button (action: {
//                                        addEvent()
//                                    }, label: {
//                                        Text("Add_Event")
//                                            .accessibilityLabel("Add_a_new_event")
//                                            .font(.title3)
//                                            .fontWeight(.semibold)
//                                            .padding (16.0)
//                                            .background(Color.accentColor)
//                                            .foregroundColor(.white)
//                                            .clipShape(RoundedRectangle (cornerRadius:10.0, style: .continuous))
//                                    })
//
//                                }
//                            }
//                        }
//                        .padding(.top)
//                        .padding(.horizontal, 24)
//                        .font(.title3)
//                        .foregroundColor(.accentColor)
//                }
//
//
//
//            }.padding()
//        }
//    }
//
//}
//
//struct AddingEvent_Previews: PreviewProvider {
//    static var previews: some View {
//        let persistentContainer = CoreDataManager.shared.persistentContainer
//        AddingEvent().environment(\.managedObjectContext, persistentContainer.viewContext)
//    }
//}
//
//extension Date {
//    func getFormattedDate(format: String) -> String {
//        let dateformat = DateFormatter()
//        dateformat.dateFormat = "MM/dd/yyyy"
//        return dateformat.string(from: self)
//    }
//}
