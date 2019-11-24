library(devtools)
library(dplyr)
library(multgee)

bmt <- foreign::read.spss(file='./data-raw/bmt.sav', to.data.frame=TRUE)
usethis::use_data(bmt, overwrite = TRUE)
saveRDS(bmt, './data-Rds/bmt.Rds')
ova <- foreign::read.spss(file='./data-raw/ova.sav', to.data.frame=TRUE)
usethis::use_data(ova, overwrite = TRUE)
saveRDS(ova, './data-Rds/ova.Rds')
fracture <- foreign::read.spss(file='./data-raw/fracture.sav', to.data.frame=TRUE)
usethis::use_data(fracture, overwrite = TRUE)
saveRDS(fracture, './data-Rds/fracture.Rds')
endom <- foreign::read.spss(file='./data-raw/endom.sav', to.data.frame=TRUE)
usethis::use_data(endom, overwrite = TRUE)
saveRDS(endom, './data-Rds/endom.Rds')
LBW <- foreign::read.spss(file='./data-raw/LBW.sav', to.data.frame=TRUE)
usethis::use_data(LBW, overwrite = TRUE)
saveRDS(LBW, './data-Rds/LBW.Rds')
teeth <- read.table('./data-raw/teeth.dat', header = TRUE)
usethis::use_data(teeth, overwrite = TRUE)
saveRDS(teeth, './data-Rds/teeth.Rds')
epilepsy <- read.table('./data-raw/epilepsy.dat', header = TRUE)
usethis::use_data(epilepsy, overwrite = TRUE)
saveRDS(epilepsy, './data-Rds/epilepsy.Rds')
melanoma <- read.table('./data-raw/melanoma.dat', header = TRUE)
usethis::use_data(melanoma, overwrite = TRUE)
saveRDS(melanoma, './data-Rds/melanoma.Rds')
endopaired <- read.csv('./data-raw/endompared.csv', header = TRUE)
usethis::use_data(endopaired, overwrite = TRUE)
saveRDS(endopaired, './data-Rds/endopaired.Rds')
lung<-c(3035, 2552, 2704, 2554, 2014, 1655, 1721, 1524, 1596, 2074, 2199, 2512,
        2933, 2889, 2938, 2497, 1870, 1726, 1607, 1545, 1396, 1787, 2076, 2837,
        2787, 3891, 3179, 2011, 1636, 1580, 1489, 1300, 1356, 1653, 2013, 2823,
        2996, 2523, 2540, 2520, 1994, 1641, 1691, 1479, 1596, 1877, 2032, 2484,
        2899, 2990, 2890, 2379, 1933, 1734, 1617, 1495, 1440, 1777, 1970, 2745,
        2841, 3535, 3010, 2091, 1667, 1589, 1518, 1349, 1392, 1619, 1954, 2633)
matrix(lung, 12)
lung_data <- data.frame(Y=lung, month=rep(1:12,6), year=rep(1974:1979, each=12))
usethis::use_data(lung_data, overwrite = TRUE)
saveRDS(lung_data, './data-Rds/lung_data.Rds')
pex <- foreign::read.spss('./data-raw/pex.sav', to.data.frame = TRUE)
names(pex)
pex <-
pex %>% select(c("patnr1", "fysiothe", "leeftijd",
                 "geslacht", "lengte", "gewicht", "bilaterale_klachten",
                 "vr16pijn", "vr17pijn",
                 "v4pijnr2",
                 "v5pijni2", "v4pijnr3", "v5pijni3",
                 "v4pijnr4", "v5pijni4", "v4pijnr5", "v5pijni5",
                 "v4pijnr6", "v5pijni6",
                 "recov2", "recov3", "recov4", "recov5", "recov6")) %>%
  rename(age=leeftijd, sex=geslacht, painrestbl=vr16pijn, painactbl=vr17pijn,
         height=lengte, weight=gewicht, bilateral_complaints=bilaterale_klachten,
         painrest6w=v4pijnr2, painact6w=v5pijni2,
         painrest3m=v4pijnr3, painact3m=v5pijni3,
         painrest6m=v4pijnr4, painact6m=v5pijni4,
         painrest9m=v4pijnr5, painact9w=v5pijni5,
         painrest12m=v4pijnr6, painact12m=v5pijni6,
         recovery6w=recov2, recovery3m=recov3,
         recovery6m=recov4, recovery9m=recov5,
         recovery12m=recov6) %>%
  mutate(fysiothe = recode(fysiothe, ja = "yes", nee='no'),
         sex= recode(sex, man='male', vrouw='female'))
usethis::use_data(pex, overwrite = TRUE)
saveRDS(pex, './data-Rds/pex.Rds')
# saveRDS(pex, file='v:/HomeDir/959750/Onderwijs/ep03/logisticregression/data/pex.Rda')


vaccination <- read.csv('./data-raw/vaccination.csv', header = TRUE)
usethis::use_data(vaccination, overwrite = TRUE)
saveRDS(vaccination, './data-Rds/vaccination.Rds')
data("arthritis")
arthritis <- arthritis[arthritis$time==5,]
arthritis$arthritis_fu <- factor(arthritis$y,levels = 1:5,
                                 labels = c('very poor', 'poor', 'fair', 'good', 'very good'))
arthritis$baseline <- factor(arthritis$baseline,levels = 1:5,
                             labels = c('very poor', 'poor', 'fair', 'good', 'very good'))
arthritis$time <- NULL
arthritis$y <- NULL
arthritis$sex <- factor(arthritis$sex, levels = 1:2, labels = c('female', 'male'))
arthritis$trt <- factor(arthritis$trt, levels = 1:2, labels = c('Placebo', 'Auranofin'))

saveRDS(arthritis, './data-Rds/arthritis.Rds')
usethis::use_data(arthritis, overwrite = TRUE)
TT<-table(teeth$X, teeth$Y)
xx<-as.numeric(rownames(TT))
yy<-as.numeric(colnames(TT))
aggregateteeth<- data.frame(X=xx, present=TT[,2], absent=TT[,1], n=rowSums(TT) )
saveRDS(aggregateteeth, './data-Rds/aggregateteeth.Rds')
usethis::use_data(aggregateteeth, overwrite = TRUE)

save(arthritis, vaccination, pex, bmt, ova, fracture, endom, LBW, teeth, epilepsy, melanoma, endopaired, lung_data,
       aggregateteeth,
     file = './data-Rds/EP03logistic.Rd')
