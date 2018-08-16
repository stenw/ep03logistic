# Some functions to calculate effect sizes on a two by two table




#' Various risk measures for the 2x2 table
#'
#' @param a number of deseased in the exposed group or a 2x2 matrix containing a, b, c and d
#' @param b number of non-deseased in the exposed group
#' @param c number of deseased in the non-exposed group
#' @param d number of non-deseased in the non-exposed group
#' @param log give results on the log scale (for the relative risk and the ods ratio the se is
#'  not given on the original scale. For the risk difference the results are always given on
#'  the original scale)
#'
#' @return
#' A list of class 'riskestimate' with elements:
#' estimate: the (log)risk estimate
#' se: the standard error of the the (log)risk estimate
#' outcome: A description of the outcome
#' log: a logical value indicating if the estimate is on the log scale
#'
#'
#' @examples
#' \cite{Van Linschoten et al. (2009)}
#' twobytwo_or(26, 62, 21, 60)
#' twobytwo_rr(26, 62, 21, 60)
#' twobytwo_rd(26, 62, 21, 60)
#' @name twobytwo
NULL

#' @rdname twobytwo
#' @export
twobytwo_or<- function(a, b, c, d, log=TRUE){
  if(is.matrix(a)){
    b <- a[1,2]
    c <- a[2,1]
    d <- a[2,2]
    a <- a[1,1]
  }
  r1 <- a/(a+b)
  r2 <- c/(c+d)
  o1 <- r1/(1-r1)
  o2 <- r2/(1-r2)
  or <- o1/o2
  if (log){
   or <- log(or)
   se <- sqrt(1/a+1/b+1/c+1/d)
  } else {
    se <- NULL
  }
  structure(list(estimate=or, se=se, outcome='Odds Ratio', log=log),
            class='riskestimate')
}

#' @rdname twobytwo
#' @export
twobytwo_rd <- function(a, b, c, d){
  if(is.matrix(a)){
    b <- a[1,2]
    c <- a[2,1]
    d <- a[2,2]
    a <- a[1,1]
  }
  r1 <- a/(a+b)
  r2 <- c/(c+d)
  rd <- r1-r2

  se <- sqrt((r1*(1-r1))/(a+b) +(r2*(1-r2))/(c+d) )
  structure(list(estimate=rd, se=se, outcome='Risk Difference', log=FALSE),
            class='riskestimate')
}

#' @rdname twobytwo
#' @export
twobytwo_rr<- function(a, b, c, d, log=TRUE){
  if(is.matrix(a)){
    b <- a[1,2]
    c <- a[2,1]
    d <- a[2,2]
    a <- a[1,1]
  }
  r1 <- a/(a+b)
  r2 <- c/(c+d)
  rr <- r1/r2
  if (log){
    rr <- log(rr)
    se <- sqrt((1-r1)/a +(1-r2)/c )
  } else {
    se <- NULL
  }

  structure(list(estimate=rr, se=se, outcome='Risk Ratio', log=log),
            class='riskestimate')
}





confint.riskestimate <- function(x, level=0.95){
  a <- (1 - level)/2
  a <- c(a, 1 - a)
  Z <- qnorm(a)
  ci <- x$estimate + Z*x$se
  if(x$log){
    ci <- exp(ci)
  }
  ci
}

print.riskestimate <- function(x, ...){
  cat('\nEstimate of', x$outcome, '\n')
  est <- x$estimate
  if(x$log){
    est<- exp(est)
  }
  print(est)
  cat('95% Confidence interval\n')
  print(confint(x))
}
