#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(EP03logistic)

data("teeth")
br <-  seq(0,50, by=5)
# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("ROC Curve"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
         sliderInput("cut",
                     "Cutoff",
                     min = min(br),
                     max = max(br),
                     value = br[round(length(br)/2+0.5) ],
                     step =diff(br)[1] ),
         selectInput("select", label = h3("Select box"),
                     choices = list("Teeth" = 1, "Simulated" = 2),
                     selected = 2)
      ),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         tableOutput("conf"),
         textOutput("sens"),
         plotOutput("auc")
      )
   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  dd<-reactive({
    if(input$select==1) {
      teeth
    }else{
        data.frame(X=c(rnorm(50, 22,5),rnorm(50, 28,5)),Y=rep(0:1, each=50) )
      }
    })

   output$distPlot <- renderPlot({
     d <- dd()
     cutoff_r <- reactive(input$cut)
     cutoff <- cutoff_r()
      # generate bins based on input$bins from ui.R
     x0 <- d$X[d$Y==0]
     x1 <- d$X[d$Y==1]
     x00 <- x0[x0<=cutoff]
     x01 <- x0[x0>cutoff]
     x10 <- x1[x1<=cutoff]
     x11 <- x1[x1>cutoff]
     br <-  pretty(range(d$X), max(nclass.Sturges(d$X), nclass.FD(d$X) )+1)
     hist_info <-hist(d$X,breaks = br, xlim=range(d$X), col=rgb(1,0.25,0,0), border = FALSE,
                      main='Histogram', xlab='X')
     if(length(x00)>0) hist(x00,breaks = br, add = TRUE, xlim=range(d$X), col=rgb(1,0,0,0.5),
                            border = 'darkgrey')
     if(length(x01)>0) hist(x01,breaks = br, add=TRUE, col=rgb(1,0.25,0,0.5),
                            border = 'darkgrey')
     if(length(x10)>0) hist(x10, breaks=br, add = TRUE, col=rgb(0,0.25,1,0.5), border = 'darkgrey')
     if(length(x11)>0) hist(x11, breaks=br,add = TRUE, col=rgb(0,0,1,0.5), border = 'darkgrey')
     abline(v=cutoff, lwd=3)
   })
   output$conf <- renderTable({
     d <- dd()
     cutoff_r <- reactive(input$cut)
     cutoff <- cutoff_r()
     # generate bins based on input$bins from ui.R
     tab<-table(d$Y, factor(ifelse(d$X<=cutoff,0,1),levels=c(0,1) ),dnn = c('Obs', 'Pred'))
     df <-as.data.frame.matrix(tab)
     df$Confusion<- rownames(df)
     df[,c(3,1,2)]
   })
   output$sens <- renderText({
     d <- dd()
     cutoff_r <- reactive(input$cut)
     cutoff <- cutoff_r()
     # generate bins based on input$bins from ui.R
     tab<-table(d$Y, factor(ifelse(d$X<=cutoff,0,1),levels=c(0,1) ),dnn = c('Obs', 'Pred'))
     T1 <- (tab[2,2] +tab[2,1])
     sens <- ifelse(T1==0,1,tab[2,2]/T1)
     T2 <- (tab[1,1] +tab[1,2])
     spec <- ifelse(T2==0,1, tab[1,1]/T2)
     paste('Sens:', round(sens,2), 'Spec', round(spec,2))
   })
   output$auc <- renderPlot({
     d <- dd()
     cutoff_r <- reactive(input$cut)
     cutoff_true <- cutoff_r()
     # generate bins based on input$bins from ui.R
     myROC <-function(cutoff){
      tab<-table(d$Y, factor(ifelse(d$X<=cutoff,0,1),levels=c(0,1) ),dnn = c('Obs', 'Pred'))
     T1 <- (tab[2,2] +tab[2,1])
     sens <- ifelse(T1==0,1,tab[2,2]/T1)
     T2 <- (tab[1,1] +tab[1,2])
     spec <- ifelse(T2==0,1, tab[1,1]/T2)
     c(sens, spec)
     }
     theroc <- rbind(c(1,0),t(sapply(sort(unique(d$X)), function(x) myROC(x))),c(0,1) )
     plot(y=theroc[,1], x=1-theroc[,2], type='l', ylab='Sens', xlab='1-Spec')
     point_on_plot <- myROC(cutoff_true)
     points(y=point_on_plot[1],  x=1-point_on_plot[2], cex=2, col='red')
     abline(0,1, col='grey', lty=2)
   })
}

# Run the application
shinyApp(ui = ui, server = server)

