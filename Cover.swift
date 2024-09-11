import SwiftUI

struct Cover: View {
    private let coverUrl: URL?
    private let tint: Color
    private let icon: Icon
    private let height: CGFloat

    @State private var base64Image: String? = nil
    @State private var isLoading = false
    @State private var isFailed = false

    init(coverUrl: URL?, tint: Color, icon: Icon, height: CGFloat = 128) {
        self.coverUrl = coverUrl
        self.tint = tint
        self.icon = icon
        self.height = height
    }

    var body: some View {
        if let coverUrl {
            VStack {
                if isLoading {
                    IconView(icon: .progress, tint: tint, animation: .rotate)
                } else if isFailed {
                    IconView(icon: icon, tint: tint)
                } else {
                    if let base64Image, let data = Data(base64Encoded: base64Image), let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: height)
                            .clipped()
                    }
                }
            }
            .clipped()
            .allowsHitTesting(false)
            .task {
                guard base64Image == nil, !isLoading else { return }

                await loadImage(url: coverUrl)
            }
        } else {
            IconView(icon: icon, tint: tint)
        }
    }

    private func loadImage(url: URL) async {
        isLoading = true
        do {
            let (data, _) = try await URLSession(configuration: .default).data(from: url)
            let base64String = data.base64EncodedString()
            DispatchQueue.main.async {
                self.base64Image = base64String
            }
            isLoading = false
            isFailed = false
        } catch {
            isLoading = false
            isFailed = true
        }
    }
}

#Preview {
    Cover(coverUrl: URL(string: ""), tint: .accent, icon: .book)
}
