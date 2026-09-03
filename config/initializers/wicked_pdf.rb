# WickedPDF Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `render :pdf` call.
#
# To learn more, check out the README:
#
# https://github.com/mileszs/wicked_pdf/blob/master/README.md

WickedPdf.config ||= {}
WickedPdf.config.merge!({
  # Nombre lógico del layout, sin extensiones. Con "pdf.html.haml" Rails buscaba
  # literalmente layouts/pdf.html.haml para el formato :pdf y no lo encontraba,
  # así que el certificado respondía "Template is missing".
  layout: "pdf",
  orientation: "Landscape",
  lowquality: true,
  zoom: 1,
  dpi: 75
})