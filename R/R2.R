R2_CS<-function(LL0, LL1, N){
  as.numeric(1-exp(2/N*(LL0-LL1)))
}
R2_NK<-function(LL0, LL1, N){
  R2CS <- R2_CS(LL0, LL1, N)
  as.numeric(R2CS/(1-exp(2*LL0/N)))
}
