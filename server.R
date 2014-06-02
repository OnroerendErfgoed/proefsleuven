library(shiny)

shinyServer(function(input,output) {
  
  # Function to load data from csv located at 'path' and add a rotationgroup
  load_data <- function (path) {
    t <- read.csv(path)
    t$rotatiegroep <- cut(t$ROTATION, seq(0, 180, input$rotatiegroepgrootte))
    return(t)}    
  
  # reactive wrapper around load_data function call
  get_dataset <- reactive(load_data(input$dataset))
  
  #reactive function that returns the selected explenatory variable
  get_explanatory <- reactive({
    d = get_dataset()
    if (input$explanatory == 1){
      d$F_INT
    }else{
      d$A_INT
    }
  })
  
  # reactive function that returns the model formula depending on the selected 
  #explenatory variable
  get_model_formula <- function(explanatory) {
    d = get_dataset()
    if (explanatory == 1){
      as.formula(d$F_INT ~ d$rotatiegroep)
    }else{
      as.formula(d$A_INT ~ d$rotatiegroep)
    }
  }
  
  # returns the ANOVA model
  aov_model <- reactive(aov(get_model_formula(input$explanatory)))
  
  # return histogram plot, sets ylim a bit higher so that the normal curve
  # always fits inside the plot
  output$histPlot <- renderPlot({
    hist(
      get_explanatory(), 
      main="Histogram van het aantal gedetecteerde sporen",
      ylab="Frequentie",
      xlab="Aantal gedetecteerde sporen",
      prob=TRUE,
      ylim= c(0, ceiling(max(hist(get_explanatory())$density*1005))/1000)
    )
    
    if (input$normaal) curve(dnorm(x,
                                   mean=mean(get_explanatory()), 
                                   sd=sd(get_explanatory())
    ), 
    col="darkblue",
    lwd=2,
    add=TRUE,
    yaxt="n"
    )
    
    if (input$densiteit) lines(density(get_explanatory()), col="red")  
  }, height=500)
  
  # create quantile-quantile plot, fixed height
  output$qqPlot <- renderPlot(
    {
     qqnorm(get_explanatory(), 
            main="Kwantiel-Kwantiel-plot van aantal gedetecteerde sporen")
            qqline(get_explanatory(), 
            col="red")
    },
    height=500)
  
  # create boxplot, fixed height
  output$boxPlot <- renderPlot(
    {
     boxplot(get_model_formula(input$explanatory), 
     notch=TRUE,
     las=2,
     main="Boxplot van aantal gedetecteerde sporen per rotatiegroep")
    },
    height=500)
  
  # output summary table
  output$anovaSummary <- renderTable({
    summary(aov_model())
  })
  
  # output anova plot, fixed height
  output$anovaPlot <- renderPlot(
    {
     par(mfrow=c(2,2))
     plot(aov_model())
     par(mfrow=c(1,1))
    },
    height=600)

  # output Tukey's Honest Significant Difference plot,  fixed height  
  output$TukeyHSD <- renderPlot(
    {
     par(mar=c(5,9,4,1)+.1)
     plot(TukeyHSD(aov_model()), las=1, cex.axis=0.65)
    },
    height=2000)
  
  # output current dataframe
  output$tabel <- renderDataTable({ get_dataset() })
  
  # create csv-download of current dataframe
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      write.csv(get_dataset(), con)
    }
  )
})
