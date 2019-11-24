#' Endometrial cancer data
#'
#' This file contains 315 records with data on cases and controls
#'  from the Leisure World study of endometrial cancer as related
#'   to treatment with estrogens for menopausal symptoms and
#'   other risk factors.
#'   Each case was matched to four controls. Matching was by date
#'   of birth (within one year), marital status, and residence.
#'
#' @format A data frame with 315 observations and 13 variables:
#' \describe{
#' \item{STRATUM}{Stratum }
#' \item{OUTCOME}{Case or Control}
#' \item{GALL}{Gallbladder disease}
#' \item{HYP}{Hypertension}
#' \item{OB}{Obesity}
#' \item{EST}{Estrogen usage}
#' \item{DOSE}{Dose of conjugated}
#' \item{DUR}{Duration of estrogen use in months}
#' \item{NON}{Non-estrogen drug}
#' \item{AGE}{age of the subject}
#' \item{AGE}{age of the matching control}
#'  \item{AGEGR}{age category}
#' }
#'
#' @source Breslow NE, and Day N, Statistical Methods in Cancer Research. Volume I:
#'  The Analysis of Case-Control Studies. IARC Scientific Publications, IARC:Lyon, 1980.
#'
#' @examples
#' TODO
"endom"

#' Bone merrow transplant data
#'
#' @format A data frame with 166 observations and 6 variables:
#' \describe{
#' \item{agvhd}{Acute Graft Versus Host Disease }
#' \item{diag}{Diagnosis}
#' \item{agedon}{Age of donor}
#' \item{agerec}{Age of recipient}
#' \item{sexdon}{Sex of donor}
#' \item{sexrec}{Sex of recipient}
#' }
#' @examples
#' TODO
"bmt"

#' Ovarian cancer data
#'
#' @format A data frame with 358 observations and 8 variables:
#' \describe{
#' \item{T}{}
#' \item{D}{}
#' \item{SURV}{}
#' \item{KARN}{}
#' \item{BRODERS}{}
#' \item{FIGO}{}
#' \item{ASCITES}{}
#' \item{DIAM}{}
#' }
#' @examples
#' TODO
"ova"


#' Low Birth Weight Data
#'
#' @format A data frame with 36 observations and 5 variables:
#' \describe{
#' \item{SMOKING}{Smoking}
#' \item{ALCOHOL}{Alcohol use}
#' \item{SOCCLASS}{Social Economic Class}
#' \item{LWB}{Low Birth Weight}
#' \item{NUMBERS}{Bumber of observations in groups}
#' }
#' @examples
#' TODO
"LBW"


#' Fracture Data
#'
#' @format A data frame with 36 observations and 5 variables:
#' \describe{
#' \item{ID}{}
#' \item{DEF}{}
#' \item{LOC}{}
#' \item{STEN}{}
#' }
#' @examples
#' data(fracture)
#' with(fracture, table(LOC, STEN))
"fracture"


#' Pex data
#'
#' @docType data
#' @keywords datasets
#' @name pex
#' @usage data(pex)
#' @format A data frame with info about 131 individuals
#' @references Van Linschoten (2009) Supervised exercise therapy versus usual care for patellofemoral pain syndrome: an open label randomised controlled trial - \emph{BMJ}
"pex"


#' Vaccination data
#'
#' @docType data
#' @keywords datasets
#' @name vaccination
#' @usage data(vaccination)
#' @format A data frame containing 6 variables and 12 rows
#' @examples
#' data(vaccination)
#' vaccination
#' @references A handbook of small data sets (1993)  and Mead, R  (1988) The design of experiments: statistical principles for practical application
"vaccination"



#' Vaccination data
#'
#' @docType data
#' @keywords datasets
#' @name arthritis
#' @usage data(arthritis)
#' @format A data frame containing 6 variables and 302 rows / patients
#' @examples
#' data(arthritis)
#' arthritis
#' @references Lipsitz, S.R. and Kim, K. and Zhao, L. (1994) Analysis of repeated categorical data using generalized estimating equations. Statistics in Medicine, 13, 1149-116
"arthritis"
