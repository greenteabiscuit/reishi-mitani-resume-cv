import AppKit
import CoreGraphics
import Foundation

let args = CommandLine.arguments
if args.count != 3 {
    fputs("Usage: render_resume_pdf.swift input.md output.pdf\n", stderr)
    exit(2)
}

let inputURL = URL(fileURLWithPath: args[1])
let outputURL = URL(fileURLWithPath: args[2])
let markdown = try String(contentsOf: inputURL, encoding: .utf8)

let pageWidth: CGFloat = 612
let pageHeight: CGFloat = 792
let marginX: CGFloat = 36
let marginTop: CGFloat = 34
let marginBottom: CGFloat = 34
let contentWidth = pageWidth - marginX * 2

var mediaBox = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
guard let context = CGContext(outputURL as CFURL, mediaBox: &mediaBox, nil) else {
    fputs("Failed to create PDF context\n", stderr)
    exit(1)
}

let bodyFont = NSFont.systemFont(ofSize: 8.3)
let bodyBoldFont = NSFont.boldSystemFont(ofSize: 8.3)
let bodyItalicFont = NSFontManager.shared.convert(bodyFont, toHaveTrait: .italicFontMask)
let h1Font = NSFont.boldSystemFont(ofSize: 19)
let h2Font = NSFont.boldSystemFont(ofSize: 12.5)
let h3Font = NSFont.boldSystemFont(ofSize: 10.2)
let sectionFont = NSFont.boldSystemFont(ofSize: 8.7)
let dateFont = NSFontManager.shared.convert(NSFont.systemFont(ofSize: 8.2), toHaveTrait: .italicFontMask)
let textColor = NSColor(calibratedWhite: 0.08, alpha: 1)

func paragraphStyle(
    alignment: NSTextAlignment = .left,
    lineSpacing: CGFloat = 1.1,
    firstIndent: CGFloat = 0,
    headIndent: CGFloat = 0
) -> NSMutableParagraphStyle {
    let style = NSMutableParagraphStyle()
    style.alignment = alignment
    style.lineSpacing = lineSpacing
    style.paragraphSpacing = 0
    style.firstLineHeadIndent = firstIndent
    style.headIndent = headIndent
    return style
}

func attributedInline(
    _ text: String,
    font: NSFont,
    boldFont: NSFont? = nil,
    italicFont: NSFont? = nil,
    style: NSParagraphStyle
) -> NSAttributedString {
    let result = NSMutableAttributedString()
    var index = text.startIndex
    var isBold = false
    var isItalic = false

    while index < text.endIndex {
        if text[index...].hasPrefix("**") {
            isBold.toggle()
            index = text.index(index, offsetBy: 2)
            continue
        }
        if text[index] == "*" {
            isItalic.toggle()
            index = text.index(after: index)
            continue
        }

        let nextBold = text[index...].range(of: "**")?.lowerBound ?? text.endIndex
        let nextItalic = text[index...].range(of: "*")?.lowerBound ?? text.endIndex
        let next = min(nextBold, nextItalic)
        if next > index {
            let chunk = String(text[index..<next])
            var attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: textColor,
                .paragraphStyle: style,
            ]
            if isBold, let boldFont {
                attributes[.font] = boldFont
            }
            if isItalic, let italicFont {
                attributes[.font] = italicFont
            }
            result.append(NSAttributedString(string: chunk, attributes: attributes))
        }
        index = next
    }

    return result
}

struct Block {
    let attr: NSAttributedString?
    let spacingBefore: CGFloat
    let spacingAfter: CGFloat
    let rule: Bool
}

var blocks: [Block] = []
for rawLine in markdown.components(separatedBy: .newlines) {
    let line = rawLine.replacingOccurrences(of: "  ", with: "").trimmingCharacters(in: .whitespaces)
    if line.isEmpty {
        blocks.append(Block(attr: nil, spacingBefore: 0, spacingAfter: 2.7, rule: false))
        continue
    }
    if line == "---" {
        blocks.append(Block(attr: nil, spacingBefore: 4.5, spacingAfter: 6, rule: true))
        continue
    }

    let style: NSMutableParagraphStyle
    let attr: NSAttributedString
    var before: CGFloat = 0
    var after: CGFloat = 1.8

    if line.hasPrefix("# ") {
        style = paragraphStyle(alignment: .center, lineSpacing: 0)
        attr = attributedInline(String(line.dropFirst(2)), font: h1Font, boldFont: h1Font, italicFont: h1Font, style: style)
        before = 0
        after = 4
    } else if line.hasPrefix("## ") {
        style = paragraphStyle(lineSpacing: 0)
        attr = attributedInline(String(line.dropFirst(3)), font: h2Font, boldFont: h2Font, italicFont: h2Font, style: style)
        before = 4
        after = 3
    } else if line.hasPrefix("### ") {
        style = paragraphStyle(lineSpacing: 0)
        attr = attributedInline(String(line.dropFirst(4)), font: h3Font, boldFont: h3Font, italicFont: h3Font, style: style)
        before = 3
        after = 2.4
    } else if line.hasPrefix("* ") {
        style = paragraphStyle(lineSpacing: 1.1, firstIndent: 0, headIndent: 12)
        attr = attributedInline("• " + String(line.dropFirst(2)), font: bodyFont, boldFont: bodyBoldFont, italicFont: bodyItalicFont, style: style)
        after = 1.6
    } else if line.hasPrefix("*") && line.hasSuffix("*") && line.count > 2 {
        style = paragraphStyle(lineSpacing: 0)
        attr = attributedInline(String(line.dropFirst().dropLast()), font: dateFont, boldFont: dateFont, italicFont: dateFont, style: style)
        after = 3.5
    } else if line.hasPrefix("**") && line.hasSuffix("**") {
        style = paragraphStyle(lineSpacing: 0)
        attr = attributedInline(String(line.dropFirst(2).dropLast(2)), font: sectionFont, boldFont: sectionFont, italicFont: sectionFont, style: style)
        before = 2.3
        after = 2
    } else if line.hasPrefix("Email:") || line.hasPrefix("Tokyo,") {
        style = paragraphStyle(alignment: .center, lineSpacing: 0)
        attr = attributedInline(line, font: bodyFont, boldFont: bodyBoldFont, italicFont: bodyItalicFont, style: style)
        after = 1.5
    } else {
        style = paragraphStyle(lineSpacing: 1.1)
        attr = attributedInline(line, font: bodyFont, boldFont: bodyBoldFont, italicFont: bodyItalicFont, style: style)
        after = 1.8
    }
    blocks.append(Block(attr: attr, spacingBefore: before, spacingAfter: after, rule: false))
}

func blockHeight(_ attr: NSAttributedString) -> CGFloat {
    let rect = attr.boundingRect(
        with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
        options: [.usesLineFragmentOrigin, .usesFontLeading]
    )
    return ceil(rect.height)
}

func beginPage() {
    context.beginPDFPage(nil)
    context.saveGState()
    NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: false)
}

func endPage() {
    NSGraphicsContext.current = nil
    context.restoreGState()
    context.endPDFPage()
}

beginPage()
var yFromTop = marginTop
let bottomLimit = pageHeight - marginBottom

for block in blocks {
    if block.rule {
        let needed = block.spacingBefore + 1 + block.spacingAfter
        if yFromTop + needed > bottomLimit {
            endPage()
            beginPage()
            yFromTop = marginTop
        }
        yFromTop += block.spacingBefore
        let drawY = pageHeight - yFromTop
        NSColor(calibratedWhite: 0.78, alpha: 1).setStroke()
        let path = NSBezierPath()
        path.lineWidth = 0.5
        path.move(to: CGPoint(x: marginX, y: drawY))
        path.line(to: CGPoint(x: marginX + contentWidth, y: drawY))
        path.stroke()
        yFromTop += 1 + block.spacingAfter
        continue
    }

    guard let attr = block.attr else {
        yFromTop += block.spacingAfter
        continue
    }

    let height = blockHeight(attr)
    let needed = block.spacingBefore + height + block.spacingAfter
    if yFromTop + needed > bottomLimit {
        endPage()
        beginPage()
        yFromTop = marginTop
    }
    yFromTop += block.spacingBefore
    let drawY = pageHeight - yFromTop - height
    attr.draw(
        with: CGRect(x: marginX, y: drawY, width: contentWidth, height: height + 4),
        options: [.usesLineFragmentOrigin, .usesFontLeading]
    )
    yFromTop += height + block.spacingAfter
}

endPage()
context.closePDF()
