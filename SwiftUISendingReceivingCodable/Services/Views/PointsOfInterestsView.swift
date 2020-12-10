//
//  PointsOfInterestsView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 08/12/2020.
//

import SwiftUI
import MapKit

struct PointsOfInterestsView: View {
  
    @State var selectedInterests = PointsOfInterestEnum.convert(pointsOfInterestList: ((UserDefaults.standard.array(forKey: "selectedInterests") as? [MKPointOfInterestCategory] ?? [MKPointOfInterestCategory]())))
    
    var body: some View {
        List {
            ForEach(PointsOfInterestEnum.allCases, id: \.self) { pointOfInterst in
                MultipleSelectionRow(title: pointOfInterst.rawValue, isSelected: self.selectedInterests.contains(pointOfInterst)) {
                    // --> closure action from MultipleSelectionRow :
                    if self.selectedInterests.contains(pointOfInterst) {
                        self.selectedInterests.removeAll(where: { $0 == pointOfInterst })
                    }
                    else {
                        self.selectedInterests.append(pointOfInterst)
                    }
                    // <--
                }
            }
        }
        .onDisappear() {
            UserDefaults.standard.set(PointsOfInterestEnum.convert(enumList: selectedInterests), forKey: "selectedInterests")
        }
    }
    
    struct MultipleSelectionRow: View {
        var title: String
        var isSelected: Bool
        var action: () -> Void
        
        var body: some View {
            Button(action: self.action) {
                HStack {
                    Text(self.title)
                    if self.isSelected {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

struct PointsOfInterestsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsOfInterestsView()
    }
}
