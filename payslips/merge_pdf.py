from PyPDF2 import PdfFileMerger
from glob import glob

pdfs = glob('./payslips/*.pdf')
pdfs.remove('./payslips/7.Nov 2021.pdf')

merger = PdfFileMerger()

for pdf in pdfs:
    merger.append(pdf)

merger.write("payslips/combined.pdf")
print('Done!')
merger.close()
