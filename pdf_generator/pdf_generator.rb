require "pdfkit"

def generate_pdf
    page = PDFKit.new("https://google.com", :page_size => 'Letter')
    page.to_file("page.pdf")
end

generate_pdf 