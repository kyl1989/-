library(pheatmap)
library(psych)
Genus = read.table('Genus.txt', header = TRUE, row.names = 1, sep = '\t')
Msms = read.table('msms.txt', header = TRUE, row.names = 1, sep = '\t')
Msms1 = t(Msms)
Genus1 = t(Genus)
Msms2 = Msms1[sort(row.names(Msms1)),]
Genus2 = Genus1[sort(row.names(Genus1)),]
Cor_P = corr.test(Msms2, Genus2, adjust='none')
write.table(Cor_P$r, file = 'Cor.xls', sep = '\t', col.names = NA)
write.table(Cor_P$p, file = 'P.xls', sep = '\t', col.names = NA)
pheatmap(Cor_P$r, display_numbers = matrix(ifelse(Cor_P$p < 0.05 , "*", ""), nrow(Cor_P$r)), cellwidth = 10, cellheight = 10, height = 10, width = 22, filename = 'heat.pdf')