library(readr);library(dplyr);library(ggplot2)
a<-read_csv("donnees/seismes-fidji.csv",show_col_types=FALSE)
b<-a|>mutate(classe=if_else(depth<300,"Moins de 300 km","300 km ou plus"))
c<-b|>count(classe)
d<-ggplot(c,aes(classe,n))+geom_col()
d
