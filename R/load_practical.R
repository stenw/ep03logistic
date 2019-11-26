load_practical <- function (name = NULL) {
  tutorialnames <- c("logisticregressionone",
                     "logisticregressiontwo",
                     "logisticregressionthree",
                     "ordinaltorial",
                     "poissontutorial")
  if (is.numeric(name)){
    name <- tutorialnames[name]
  }
  if (name %in% tutorialnames){
    learnr::run_tutorial(name, package = "EP03logistic")
  }else if("EP03Survival" %in% .packages()){
    ep03::load_practical(name)
  }else{
    stop('Unknown practical')
  }
}

