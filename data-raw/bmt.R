library(devtools)
library(devtools)

bmt <- foreign::read.spss(file='./data-raw/bmt.sav', to.data.frame=TRUE)
usethis::use_data(bmt, overwrite = TRUE)
ova <- foreign::read.spss(file='./data-raw/ova.sav', to.data.frame=TRUE)
usethis::use_data(ova, overwrite = TRUE)
fracture <- foreign::read.spss(file='./data-raw/fracture.sav', to.data.frame=TRUE)
usethis::use_data(fracture, overwrite = TRUE)
LBW <- foreign::read.spss(file='./data-raw/LBW.sav', to.data.frame=TRUE)
usethis::use_data(LBW, overwrite = TRUE)

