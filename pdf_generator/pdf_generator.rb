require "pdfkit"

def generate_pdf
    page = PDFKit.new(File.open("page.html"), :page_size => 'Letter')
    p page
    page.to_file("page.pdf")
end

generate_pdf 