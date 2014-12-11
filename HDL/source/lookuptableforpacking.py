import re

Fdef = open('gpu_definitions.vh','r')


widthsearch = re.compile(r'.+?`[^\s]+? WIDTH (\d+)\n')
heightsearch = re.compile(r'.+?`[^\s]+? HEIGHT (\d+)\n')
for line in (Fdef):
	if widthsearch.match(line):
		m = widthsearch.match(line)
		width = int(m.group(1))
	if heightsearch.match(line):
		m = heightsearch.match(line)
		height = int(m.group(1))

Fdef.close()


Fmain = open('gpu_packlut.sv', 'w')
Fmain.write('`include "source/gpu_definitions.vh"\n')
Fmain.write('module gpu_packlut\n(\n\t\
input wire [`HEIGHT_BITS - 1:0] addressy,\n\
\toutput wire [`HEIGHT_BITS + `WIDTH_BITS - 1:0] rtpaddy\n\
\t);\n')

Fmain.write('\
\treg [`HEIGHT_BITS + `WIDTH_BITS - 1:0] reg_rtpaddy;\n\
\tassign rtpaddy = reg_rtpaddy;\n\
\talways @ (addressy)\n\
\tbegin\n\
\t\tcase (addressy)\n')

for i in range(height):
	widthadd = width*i
	Fmain.write('\t\t\t`HEIGHT_BITS\'d{0:d}: reg_rtpaddy = `SUM_BITS\'d{1:d};\n'.format(i,widthadd))

Fmain.write('\t\tendcase\n\
\tend\n\
endmodule\n')

Fmain.close



