import tabula
from glob import glob

input_path = './payslips/combined.pdf'
earnings_path = './earnings_/'
deductions_path = './deductions_/'

for file in glob(input_path):
    print(file)

    tables = tabula.read_pdf_with_template(input_path=file,
                                           template_path="~/Downloads/tabula-combined.json")
                                              template_path = "./tabula-templates/deductions.tabula-template.json")

    for i, table in enumerate(tables):
        print(table)
        fname=f'table{i}.csv'
        table.to_csv(fname, index = False)
        print('-'*80)
