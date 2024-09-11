import SwiftUI

public enum TypographyStyle {
  case landing
	case headingXL
	case headingL
	case headingM
	case headingS
	case subheadingM
	case subheadingS
	case bodyM
	case bodyMStrong
	case bodyS
	case bodySStrong
	case captionM
	case captionMStrong

	var font: UIFont {
		switch self {
        case .landing:
            return .systemFont(ofSize: 56, weight: .regular)
		case .headingXL:
			return .systemFont(ofSize: 28, weight: .bold)
		case .headingL:
			return .systemFont(ofSize: 22, weight: .bold)
		case .headingM:
			return .systemFont(ofSize: 20, weight: .bold)
		case .headingS:
			return .systemFont(ofSize: 19, weight: .semibold)
		case .subheadingM:
			return .systemFont(ofSize: 17, weight: .semibold)
		case .subheadingS:
			return .systemFont(ofSize: 16, weight: .semibold)
		case .bodyM:
			return .systemFont(ofSize: 15)
		case .bodyMStrong:
			return .systemFont(ofSize: 15, weight: .medium)
		case .bodyS:
			return .systemFont(ofSize: 13)
		case .bodySStrong:
			return .systemFont(ofSize: 13, weight: .medium)
		case .captionM:
			return .systemFont(ofSize: 11)
		case .captionMStrong:
			return .systemFont(ofSize: 11, weight: .medium)
		}
	}

	var lineSpacing: CGFloat? {
		switch self {
        case .landing:
            return nil
		case .headingXL:
			return nil
		case .headingL:
			return nil
		case .headingM:
			return nil
		case .headingS:
			return nil
		case .subheadingM:
			return nil
		case .subheadingS:
			return nil
		case .bodyM:
			return 1.27
		case .bodyMStrong:
			return 1.27
		case .bodyS:
			return nil
		case .bodySStrong:
			return nil
		case .captionM:
			return nil
		case .captionMStrong:
			return nil
		}
	}

	var kerning: CGFloat? {
		nil
	}
}

public struct Typography: ViewModifier {
	let style: TypographyStyle

	public init(style: TypographyStyle) {
		self.style = style
	}

	public func body(content: Content) -> some View {
		let scaledFont = UIFontMetrics.default.scaledFont(for: style.font)
		return content
		.font(Font(scaledFont))
		.ifLet(style.lineSpacing) {
			$0.lineSpacing($1)
		}
		.ifLet(style.kerning) {
			$0.kerning($1)
		}
	}
}

extension View {
	public func typography(_ style: TypographyStyle) -> some View {
		self.modifier(Typography(style: style))
	}
}
