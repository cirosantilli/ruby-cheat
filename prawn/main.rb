require 'prawn'

def generate_pdf(pdf_path)
  Prawn::Document.generate(pdf_path) do
    text 'Hello World!'
  end
end
