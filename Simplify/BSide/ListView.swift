////
////  ListView.swift
////  Simplify
////
////  Created by Fatma Gazwani on 25/06/1444 AH.
////
//
//import SwiftUI
//
//
//struct ListView: View {
//    
//    @Environment(\.managedObjectContext) var viewContext
//    @FetchRequest(entity: Event.entity(), sortDescriptors: [NSSortDescriptor(key: "duedate", ascending: true)])  var allEvents: FetchedResults<Event>
//
//
//    
//    var body: some View {
//        VStack{
//            List{
//                ForEach(allEvents) { event in
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 13)
//                            .fill(Color.blue)
////                            .fill(theSelectedColor(event.thecolor!)
//                            .opacity(0.1)
//                            .frame(height: 120)
//                            .shadow(radius: 2, x: 5)
//                        RoundedRectangle(cornerRadius: 13)
//                            .stroke(Color.blue)
////                            .stroke(theSelectedColor(event.thecolor!), lineWidth: 2)
//                            .frame(height: 120)
//                        
//                        
//                        VStack(alignment: .leading){
//                            HStack(alignment: .top){
//                                Text(event.name ?? "")
//                                Text("-")
//                                Text(event.duedate!, style:.date)
//                                Spacer()
//                            }.padding(.horizontal)
//                                .font(.caption)
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color("Black"))
//                            
//                            Spacer()
//                        }.padding(.top)
//                        VStack{
//                            HStack{
//                                Text(event.duedate!, style:.relative)
//                                    .monospacedDigit()
//                                Text("left_")
//                            }.font(.title2)
//                                .padding(.top)
//                                .fontWeight(.bold)
//                        }
//                    }
//                }
////                .onDelete(perform: deleteEvent)
//            }.accessibilityLabel("Press_on_the_lists_to_view_their_information")
//                .scrollContentBackground(.hidden)
//        }
//    }
//}
//
//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let persistentContainer = CoreDataManager.shared.persistentContainer
//
//        ListView().environment(\.managedObjectContext, persistentContainer.viewContext)
//    }
//}
//
//
