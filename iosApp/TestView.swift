//
//  TestView.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/21.
//

import SwiftUI

struct Tree<Value: Hashable>: Hashable {
    let value: Value
    var children: [Tree]? = nil
}

struct TestView: View {
    let categories: [Tree<String>] = [
        .init(
            value: "Clothing",
            children: [
                .init(value: "Hoodies"),
                .init(value: "Jackets"),
                .init(value: "Joggers"),
                .init(value: "Jumpers"),
                .init(
                    value: "Jeans",
                    children: [
                        .init(value: "Regular"),
                        .init(value: "Slim")
                    ]
                ),
            ]
        ),
        .init(
            value: "Shoes",
            children: [
                .init(value: "Boots"),
                .init(value: "Sliders"),
                .init(value: "Sandals"),
                .init(value: "Trainers"),
            ]
        )
    ]
    
    var body: some View {
        OutlineGroup(categories, id: \.value, children: \.children) { tree in
                    Text(tree.value).font(.subheadline)
                }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct FileItem: Hashable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    var name: String
    var children: [FileItem]? = nil
    var description: String {
        switch children {
        case nil:
            return "📄 \(name)"
        case .some(let children):
            return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
        }
    }
}

