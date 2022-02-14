//
//  TextField.swift
//  GPS Tracking App
//
//  Created by Egor Syrtcov on 14.02.22.
//

import SwiftUI
import Combine

struct StandardTextField: View {

    enum CurrentState {
        case error
        case active
        case inactive
    }

    private let leadingIconImage: UIImage?
    private let trailingIconImage: UIImage?
    private let showPasswordBtn: Bool

    private let textColor: Color
    private let title: String

    //MARK: PUBLIC
    //MARK: - Properties
    @Binding var text: String
    @Binding var state: CurrentState
    @Binding var isSecureEntry: Bool
    var error: Error?

    init(title: String,
         state: Binding<CurrentState> = .constant(.inactive),
         text: Binding<String>,
         textColor: Color = .white,
         leadingIconImage: UIImage? = nil,
         trailingIconImage: UIImage? = nil,
         showPasswordBtn: Bool = false,
         onError: Color? = nil,
         isSecureEntry: Binding<Bool> = .constant(false)
    ) {
        self._text = text
        self.title = title
        self.textColor = textColor
        self.leadingIconImage = leadingIconImage
        self.trailingIconImage = trailingIconImage
        self.showPasswordBtn = showPasswordBtn
        self._state = state
        self._isSecureEntry = isSecureEntry
    }

    var body: some View {

        var foregroundColor: Color {
            switch $state.wrappedValue {
            case .active:
                return .red
            case .inactive:
                return .white
            case .error:
                return .red
            }
        }

        return VStack(alignment: .leading) {
            HStack {
                if let image = leadingIconImage {
                    Image(uiImage: image)
                        .padding([.leading, .trailing], 17)
                        .padding([.top,. bottom], 20)
                        .frame(width: 20)
                        .foregroundColor(
                            .white
                        )

                }

                if isSecureEntry {
                    SecureField(
                        title,
                        text: $text
                    )
                    .foregroundColor(foregroundColor)
                }
                else {

                    TextField(
                        title,
                        text: $text,
                        onEditingChanged: { status in
                            state = status
                                ? .active
                                : .inactive
                        },
                        onCommit: {
                            state = .inactive
                        }
                    )
                    .foregroundColor(foregroundColor)
                }

                if showPasswordBtn {
                    let image = isSecureEntry
                        ? UIImage(named: "hide")!
                        : UIImage(named: "show")!
                    Button(
                        action: {
                            isSecureEntry = !isSecureEntry
                        },
                        label: {
                            Image(uiImage: image)
                                .padding([.leading, .trailing], 17)
                                .padding([.top,. bottom], 20)
                                .frame(width: 20)
                                .foregroundColor(
                                    .white
                                )
                        }
                    )
                }

                if let image = trailingIconImage {
                    Image(uiImage: image)
                        .padding([.trailing], 21)
                        .padding([.top,. bottom], 20)
                        .frame(width: 20)

                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, maxHeight: 56)
            .padding()
            .foregroundColor(
                Color.gray)
            .background(Color.clear)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(
                        foregroundColor,
                        lineWidth: 1
                    )
            )
        }
    }
}

struct StandardTextField_Previews: PreviewProvider {
    static var previews: some View {
        StandardTextField(
            title: "Promo code",
            state: .constant(.inactive),
            text: .constant(""),
            textColor: .white,
            trailingIconImage: UIImage(named: "done")
        )
    }
}
