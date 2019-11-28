#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

xbase <- c(-2, -1.5, 1, -0.5, 0, 0.5, 0.75, 1, 1.5, 2)
ybase <- c(0, 0, 0, 1, 0, 1, 0, 1, 1, 0)


# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Leverage"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
         sliderInput("x",
                     "x of new point",
                     min = -5,
                     max = 10,
                     value = 0)
      ,
        sliderInput("y",
                    "y of new point",
                    min = 0,
                    max = 1,
                    step = 1,
                    value = 0)
      ),


      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("regplot"),
         textOutput("hat")

      )

)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$regplot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2]
      xall <- c(xbase, input$x)
      yall <- c(ybase, input$y)
      plot(xall, yall, ylim=c(-0.1, 1.1), xlim=c(-3, 4),
           col=c(rep('blue', length(xbase)),'red'),
           cex=c(rep(1,length(xbase)),2),
           pch=c(rep(15,length(xbase)),16),
           xlab='X', ylab='Pr')
      glm1 <- glm(yall~xall,family = binomial)
      xgrid <- seq(-2, 6, length.out = 50)
      ypr <- predict(glm1,
                     newdata = data.frame(xall=xgrid),
                     type = 'response')
      lines(xgrid, ypr, lwd=2)
   })
   output$hat <- renderText({
     xall <- c(xbase, input$x)
     yall <- c(ybase, input$y)
     glm1 <- glm(yall~xall,family = binomial)
    paste('leverage:', round(hatvalues(glm1)[length(xall)], 2))
   })
}

# Run the applicationi
shinyApp(ui = ui, server = server)

