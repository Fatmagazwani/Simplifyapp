//
//  EmptyView.swift
//  Simplify
//
//  Created by Fatma Gazwani on 25/06/1444 AH.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack{
            VStack{
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
            }
            .padding(.top, 300)
            
            Spacer()
            
        }    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
