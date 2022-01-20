//
//  SegmentedViewController.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/20.
//

import SwiftUI

struct Segment: Identifiable {
    var id: Int
    var segmentName: String
}

struct SegmentedControlView: View {
    @Binding var selected : Int
    var segments: [Segment]

    var body: some View {
        HStack {
            ForEach(segments) { segment in
                Button(action: {
                    self.selected = segment.id
                })
                {
                    Text(segment.segmentName)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 0)
                        .font(.custom("HelveticaNeue-Medium", size: 16))
                }
                .foregroundColor(self.selected == segment.id ? Color("textColor") : Color("graytext"))
            }
        }.padding(20)
        .clipShape(Capsule())
        .animation(.default)
    }
}
