PrepareTable<-function(Samplelist=Samplelist,path=path, SNP1pattern=SNP1pattern, SNP2pattern=SNP2pattern){
  library(tidyverse)
  library(data.table)
  table_list<-list()
  element_no=1
  for (i in Samplelist){
    setwd(path)
    table1<-read.delim(i,header =F, sep='\t' ) ### Needs to be streamlined for multiple files! 
    ##Maybe:assign(paste0("table_", i), read.delim(i, header =F, sep='\t' ))
    table2<-table1[,-11][,-9][,-8][,-7][,-5][,-3][,-2] ## Remove columns containing unnecessary info
    colnames(table2) <- c('Read_name', "Start", "CIGAR", "Seq", "File", "Barcode_combination", "Orient") 
    ## Add a column with seq lengths
    table2$Length<-nchar(table2$Seq)
    ## Sum Lengths with Start in a new column - End
    table2$End<-rowSums(table2[,c('Start', 'Length')])
    ## Adjust the length to correct for position (x-1)
    table2$End<- table2$End-1
    ## Switch up the columns "Start" and "End" for Reverse reads
    Forward_reads<-table2[table2$Orient=="Forward",]
    Reverse_reads<-table2[table2$Orient=="Reverse",]
    colnames(Reverse_reads)[9]<-"Start"
    colnames(Reverse_reads)[2]<-"End"
    ## Merge reads back
    table3<-rbind(Forward_reads,Reverse_reads)
    
    ##add two columns SNP1 and SNP2
    table3 <- table3 %>% mutate(SNP1="0") %>% mutate(SNP2="0")
    
    
    SNP1<-table3[table3$Seq %like% SNP1pattern,] %>%
      mutate(SNP1='1')
    
    SNP2<-table3[table3$Seq %like% SNP2pattern,] %>%
      mutate(SNP2='1')
    
    # Read in/assign input by reference to the dataframes
    setDT(table3)
    setDT(SNP1)
    setDT(SNP2)
    
    # change table3, by SNP1/SNP2, using the 'Seq' column; specifically the SNP1/2 column values by using SNP1/2 column values (where the 'Seq' matches)
    table3[SNP1, on="Seq", SNP1:=i.SNP1]
    table3[SNP2, on="Seq", SNP2:=i.SNP2]
    
    # Split the barcode column and add names
    table4<-table3 %>% separate(Barcode_combination, c("P5", "P7"))
    table5<-table4
    # Replace P5 and P7 with actual barcode sequences
    
    ### Needs conditional statements to check what kind of barcodes i have at each column for every table!!
    #P5tags<- data.frame(P5=c('1','2'), P5_BC_seq=c("XXX","YYY"))
    #P7tags<- data.frame(P7=c('1','2'), P7_BC_seq=c("XXX","YYY"))
    
    #table5<-dplyr::left_join(table5, P5tags, by='P5')
    #table5<-dplyr::left_join(table5, P7tags, by='P7')
    ###
    
    table_list[[element_no]]<- table5
    
    element_no=element_no+1
    
    #append(table_list, table5)
    # 
    ## Remember if no barcode present, do this filter(... !="") initially
    ## loop ends here
  }
  names(table_list)<- Samplelist
  return(table_list)
}
