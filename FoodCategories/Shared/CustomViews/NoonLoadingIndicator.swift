//
//  NoonLoadingIndicator.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/26/25.
//

import SwiftUI

class NoonLoadingIndicatorUISetting {
    public static var defaulte: NoonLoadingIndicatorUISetting = .init(
        expandColor: .gray.opacity(0.8),
        collapseColor: .gray.opacity(0.2)
    )
    
    private(set) var expandSeconds: Double
    private(set) var collapseSeconds: Double
    private(set) var expandPercentage: Double
    private(set) var collapsePercentage: Double
    private(set) var expandColor: Color
    private(set) var collapseColor: Color
    
    init(
        expandSeconds: Double = 1,
        collapseSeconds: Double = 0.3,
        expandPercentage: Double = 1,
        collapsePercentage: Double = 0.1,
        expandColor: Color,
        collapseColor: Color
    ) {
        self.expandSeconds = expandSeconds
        self.collapseSeconds = collapseSeconds
        self.expandPercentage = expandPercentage
        self.collapsePercentage = collapsePercentage
        self.expandColor = expandColor
        self.collapseColor = collapseColor
    }
}

extension NoonLoadingIndicatorUISetting {
    func updateExpandColor(color: Color) {
        self.expandColor = color
    }
}

struct NoonLoadingIndicator: View {
    
    @State private var isAnimating: Bool = false
    @State private var uiSettings: NoonLoadingIndicatorUISetting
    
    init(uiSettings: NoonLoadingIndicatorUISetting = .defaulte) {
        self.uiSettings = uiSettings
    }
    
    var body: some View {
        GeometryReader { geometry in
            let minDimension = min(geometry.size.width, geometry.size.height)
            
            Circle()
                .fill(isAnimating ? uiSettings.expandColor : uiSettings.collapseColor)
                .frame(width: isAnimating ? minDimension * uiSettings.expandPercentage : minDimension * uiSettings.collapsePercentage)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .task {
                    await startAnimation()
                }
        }
    }
    
    private func startAnimation() async {
        while true {
            withAnimation(.linear(duration: uiSettings.expandSeconds)) {
                isAnimating = true
            }
            
            try? await Task.sleep(for: .seconds(uiSettings.expandSeconds))
            
            guard !Task.isCancelled else { break }
            
            withAnimation(.easeOut(duration: uiSettings.collapseSeconds)) {
                isAnimating = false
            }
            
            try? await Task.sleep(for: .seconds(uiSettings.collapseSeconds))
            
            guard !Task.isCancelled else { break }
        }
    }
}
