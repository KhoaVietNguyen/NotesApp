//
//  Helps.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import Foundation
import UIKit
import SwiftUI

extension Encodable {
    var toDictionary: [String: Any]?{
        guard let data = try? JSONEncoder().encode (self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
       // navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

struct BackgroundApp: View {
    var body: some View {
        Rectangle()
            .frame(height: 0)
            .background(LinearGradient(gradient: Gradient(colors: [.orange, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    //Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: 80,
                       height: 80)
                .background(Color.primary.colorInvert())
                .foregroundColor(Color.orange)
                .cornerRadius(8)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }
}

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}

extension Date {
    func dateAndTimetoString(format: String = "dd/MM/yyy HH:mm") -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.dateFormat = format
            return formatter.string(from: self)
    }
}
