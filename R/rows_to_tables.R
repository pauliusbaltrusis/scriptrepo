setwd('/Users/paulius.baltrusis/Desktop/HCS_target')

x<-read.delim('HCS_targets.bed', header = F, sep = '\t')


# Every row is separate table file
for (i in 1:nrow(x)) {
  write.table(x[i,], file=(paste("HCS_", i,".bed", sep="")), sep = "\t", col.names = F, 
              row.names = F, quote = FALSE)
  print(i)
              }
