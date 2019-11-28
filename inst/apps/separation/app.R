#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

xbase <- c(-2, -1.5, -1, -0.5, 0, 0.5, 0.75, 1, 1.5, 2)
ybase <- c(0,    0,   0,   0,  0, 0,   1   , 1, 1,   1)



ui <- fluidPage(
   # Application title
   titlePanel("Separation"),
   # Sidebar with a slider input for number of bins
   sidebarLayout(
         sliderInput("x",
                     "x of new point",
                     min = -3,
                     max = 3,step = 0.5,
                     value = 0)
      ,
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("regplot"),
         textOutput("hat")

      )

))

# Define server logic required to draw a histogram
server <- function(input, output) {

  xa <- reactive({c(xbase, input$x)})
  xa1 <- reactive({c(xbase, min(input$x,0.4) )})
  xa_m <- reactive({c(xbase, 1)})
  # glm1 <- reactive({
  #   yall <- c(ybase, 1)
  #   xall <- xa()
  #   glm(yall~xall,family = binomial)
  # })

  glm2 <- reactive({
    yall <- c(ybase, 1)
    xall <- xa1()
    glm(yall~xall,family = binomial)
  })


   output$regplot <- renderPlot({
      # generate bins based on input$bins from ui.R
      xall <- xa()
      yall <- c(ybase, 1)
      plot(xa(), yall, ylim=c(-0.1, 1.1), xlim=c(-3, 4),
           col=c(rep('blue', length(xbase)),'red'),
           cex=c(rep(1,length(xbase)),2),
           pch=c(rep(15,length(xbase)),16),
           xlab='X', ylab='Pr')

      xgrid <- seq(-2, 6, length.out = 50)
      if( input$x > 0.5){
       lines(x=c(-2, 0.5, 0.5, 6), y=c(0, 0,1,1), lwd=2)
      }else{
      ypr <- predict(glm2(),
                     newdata = data.frame(xall=xgrid),
                     type = 'response')
      lines(xgrid, ypr, lwd=2)
      }
   })
   output$hat <- renderPrint({
     OR <-if (input$x>=0.4){
       Inf
     }else{
       exp(coef(glm2())[2])
     }
     paste0('OR=', OR )
   })
}

# Run the applicationi
shinyApp(ui = ui, server = server)

