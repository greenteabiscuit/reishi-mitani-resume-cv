PDF := reishi-mitani-resume-cv_en.pdf
SOURCE := resume_en.md
RENDERER := scripts/render_resume_pdf.swift

.PHONY: pdf

pdf: $(PDF)

$(PDF): $(SOURCE) $(RENDERER)
	/usr/bin/swift $(RENDERER) $(SOURCE) $(PDF)
