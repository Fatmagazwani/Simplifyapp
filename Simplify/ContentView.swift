//
//  ContentView.swift
//  CountDown
//
//  Created by Fatma Gazwani on 11/06/1444 AH.
//

import SwiftUI
import CoreData
import UserNotifications

enum BordersColor: String, Identifiable, CaseIterable {
    var id: UUID {
        return UUID()
    }
    case red = "red"
    case yellow = "yellow"
    case orange = "orange"
    case purple = "purple"
    case blue = "blue"
    case indigo = "indigo"
    case green = "green"
    case mint = "mint"
}
extension BordersColor {
    var title: String {
        switch self {
        case .red:
            return "Red"
        case .yellow:
            return "Yellow"
        case .orange:
            return "Orange"
        case .purple:
            return "Purple"
        case .blue:
            return "Blue"
        case .indigo:
            return "Indigo"
        case .green:
            return "Green"
        case .mint:
            return "Mint"
        }
    }
}
let duedate = Date()
let format = duedate.getFormattedDate(format: "yyyy-MM-dd")

struct ContentView: View {
    @State private var name: String = ""
    @State private var ColorsPickers: BordersColor = .blue
    @State private var duedate: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Event.entity(), sortDescriptors: [NSSortDescriptor(key: "duedate", ascending: true)]) private var allEvents: FetchedResults<Event>
    
    private func addEvent() {
        print(allEvents)
        do {
            let event = Event(context: viewContext)
            event.name = name
            event.thecolor = ColorsPickers.rawValue
            event.duedate = dueDate
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    private func theSelectedColor(_ value: String) -> Color{
        let  thecolor = BordersColor(rawValue: value)
        
        switch thecolor {
        case .red:
            return Color.red
        case .yellow:
            return Color.yellow
        case .orange:
            return Color.orange
        case .purple:
            return Color.purple
        case .blue:
            return Color.blue
        case .indigo:
            return Color.indigo
        case .green:
            return Color.green
        case .mint:
            return Color.mint
        case .none:
            return Color.orange
        }
    }
    
    private func deleteEvent (at offsets: IndexSet) {
        offsets.forEach {
            index in
            let event = allEvents[index]
            viewContext.delete(event)
            do {
                try viewContext.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    


    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Event Reminder"
        content.body = name
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "eventReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    @State private var dueDate = Date()
    @State private var showingDetail = false
    @State var selectedDate = Date()
    @State private var selectedColor: Color = .blue
    @Environment(\.dismiss) var dismiss
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 365, to: Date())!
        return min...max
    }
    var characterLimit = 20
    
    var body: some View {
        
        VStack{
            VStack{
                HStack(alignment: .top){
                    Spacer()
                    Button("Add_") {
                        showingDetail = true
                        
                    }.accessibilityLabel("Addـaـnewـevent")
                        .sheet(isPresented: $showingDetail) {
                            VStack {
                                
                                DatePicker("Please_choose_a_date", selection: $dueDate,
                                           in: dateClosedRange)
                                .accessibilityLabel("Please_choose_a_date")
                                .padding([.leading, .trailing])
                                .labelsHidden()
                                .datePickerStyle(.graphical)
                                
                                
                                VStack(alignment: .leading){
                                    Text("Event_Name:")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    TextField("Event_Name", text: $name)
                                        .limitTextLength($name, to: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .accessibilityLabel("Enter_event_Name")
                                    
                                }.padding(.horizontal)
                                    .padding(.bottom)
                                HStack{
                                    Text("Col_or:")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Picker("Pick_a_color_for_the_event_borders", selection: $ColorsPickers) {
                                        ForEach(BordersColor.allCases) { thecolor in
                                            Text(thecolor.title).tag(thecolor)
                                                .fontWeight(.bold)
                                            
                                        }
                                    }.padding(.leading)
                                        .pickerStyle(.menu)
                                }.padding(.leading)
                                    .padding(.bottom)

                                Button (action: {
                                    showingDetail = false
                                    addEvent()
                                    scheduleNotification()

                                }, label: {
                                    Text("Add_Event")
                                        .accessibilityLabel("Add_a_new_event")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding (16.0)
                                        .background(Color.accentColor)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle (cornerRadius:10.0, style: .continuous))
                                })
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal, 24)
                        .font(.title3)
                        .foregroundColor(.accentColor)
                }
            }
            //            .padding()
            
            if(allEvents.isEmpty) {
                ZStack{
                    VStack{
                            Image("track")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.top, 150)
                            .opacity(0.5)

                        Text("No_Eevnts_Yet")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("""
            press_Add_to_add_a_new_event
            """)
                        .font(.title2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel("Add_a_new_event_from_the_Button_at_the_top_right")
                        Spacer()
                    }
                }
            } else {
                
                ZStack{
                    NavigationView{
                        List{
                            ForEach(allEvents) { event in
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 13)
                                        .fill(Color("White"))
                                        .frame(height: 110)
                                        .shadow(radius: 3)
                                    
                                    RoundedShape(corners: [.topRight, .topLeft])
                                        .frame(height: 30)
                                        .padding(.bottom, 91)
                                        .foregroundColor(theSelectedColor(event.thecolor!))
                                    
                                    VStack(alignment: .leading){
                                        HStack(alignment: .top){
                                            Text(event.name ?? "")
                                            Text("-")
                                            Text(event.duedate!, style:.date)
                                            Spacer()
                                        }.padding(.horizontal)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("White"))
                                        
                                        Spacer()
                                    }.padding(.top)
                                    
                                    VStack{
                                        HStack{
                                            
                                            if event.duedate! < Date() {
                                                Text("Event_ended")
                                            } else {
                                                Text(event.duedate!, style:.relative)
                                                Text("left_")
                                            }
                                        }.font(.title2)
                                            .padding(.top)
                                            .fontWeight(.bold)
                                            .foregroundColor((theSelectedColor(event.thecolor!)))
                                    }
                                }
                                
                            }
                            
                            .onDelete(perform: deleteEvent)
                            .listRowSeparator(.hidden)
                            
                        }.accessibilityLabel("Press_on_the_lists_to_view_their_information")
                            .scrollContentBackground(.hidden)
                            .listStyle(PlainListStyle())
                        //                            .navigationTitle("Simplify")
                        //                            .navigationBarTitleDisplayMode(.inline)
                        
                    }
                    
                }
            }
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MM/dd/yyyy"
        return dateformat.string(from: self)
    }
}

struct TextLengthLimiter: ViewModifier {
  @Binding var text: String
  let maxLength: Int

  func body(content: Content) -> some View {
    content
      .onReceive(text.publisher.collect()) { output in
        text = String(output.prefix(maxLength)) // HERE
      }
  }

}

extension TextField {
  func limitTextLength(_ text: Binding<String>,
                       to maxLength: Int) -> some View {
    self.modifier(TextLengthLimiter(text: text,
                                    maxLength: maxLength))
  }
}

