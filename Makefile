PDF := reishi-mitani-resume-cv_en.pdf
SOURCE := resume_en.md
PDF_JA := reishi-mitani-resume-cv_ja.pdf
SOURCE_JA := resume_ja.md
RENDERER := scripts/render_resume_pdf.swift

.PHONY: pdf pdf-ja

pdf: $(PDF)

$(PDF): $(SOURCE) $(RENDERER)
	/usr/bin/swift $(RENDERER) $(SOURCE) $(PDF)

pdf-ja: $(PDF_JA)

$(PDF_JA): $(SOURCE_JA) $(RENDERER)
	/usr/bin/swift $(RENDERER) $(SOURCE_JA) $(PDF_JA)
