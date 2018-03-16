# 画相关性热图

setwd('D:\\Program Files\\R\\Rtest')
library(pheatmap)
library(psych)
Env_data = read.table('env.xls', header = TRUE, row.names = 1, sep = '\t')
Otu_data = read.table('genus.percents.xls', header = TRUE, row.names = 1, sep = '\t')

Otu_t50 = Otu_data[order(rowSums(Otu_data), decreasing = TRUE)[1:50],]
Env_order = Env_data[order(row.names(Env_data)),]
Cor_P = corr.test(t(Otu_t50), Env_order, method = 'spearman', adjust='none')
write.table(Cor_P$r, file = 'Cor.xls', sep = '\t')
write.table(Cor_P$p, file = 'P.xls', sep = '\t')

pheatmap(Cor_P$r, display_numbers = matrix(ifelse(Cor_P$p < 0.05 , "*", ""), nrow(Cor_P$r)), cellwidth = 10, cellheight = 10, width = 6, filename = 'heat.pdf')

#pdf('heatmap_cor.pdf')
#pheatmap(Cor_P$r, display_numbers = matrix(ifelse(Cor_P$p < 0.05 , "*", ""), nrow(Cor_P$r)), cellwidth = 10, cellheight = 10, width =10000, height = 100)
#dev.off()
