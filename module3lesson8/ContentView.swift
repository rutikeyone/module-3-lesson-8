//
//  ContentView.swift
//  module3lesson8
//
//  Created by Andrew on 09.05.2026.
//

import SwiftUI

struct ContentView: View {
    @State var opacity: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Text("Title")
                    .padding()
                    .foregroundStyle(.accentText)
            }
            .frame(maxWidth: .infinity)
            .background(.primaryTitle)
            .zIndex(1)
            .opacity(opacity)
            .animation(.easeInOut(duration: 0.1), value: opacity)
            
            ScrollView {
                VStack {
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .global).minY
                        
                        let height = minY > 0 ? minY : 0
                        let offsetY = -minY < 0 ? -minY : 0
                        
                        Image(.programming)
                            .resizable()
                            .scaledToFill()
                            .frame(width: proxy.size.width)
                            .frame(height: 300 + height)
                            .offset(y: offsetY)
                            .onChange(of: minY) { _, newValue in
                                opacity = min(max(-minY / 300, 0), 1)
                            }
                    }
                    .frame(height: 300)
                }
                
                LazyVStack(spacing: 16) {
                    ForEach(0..<100, id: \.self) { item in
                        Rectangle()
                            .frame(height: 50)
                            .foregroundStyle(.green.opacity(0.4))
                            .overlay {
                                Text("\(item)")
                            }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
