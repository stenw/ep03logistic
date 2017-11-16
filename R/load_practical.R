load_practical <- function (name = NULL) {
  tutorialnames <- c("logisticregression1", "conditionallogisticregression", "poissonregression")
  if (name %in% tutorialnames){
    learnr::run_tutorial(name, package = "EP03logistic")
  }else if("EP03" %in% .packages()){
    ep03::load_practical(name)
  }else{
    stop('Unknown practical')
  }
}
