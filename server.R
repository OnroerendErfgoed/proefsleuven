library(shiny)

shinyServer(function(input,output) {
  
  load_data <- function (path) {
    t <- read.csv(path)
    t$rotatiegroep <- cut(t$ROTATION, seq(0, 180, input$rotatiegroepgrootte))
    return(t)}    
  
  get_dataset <- reactive(load_data(input$dataset))
  
  get_explanatory <- reactive({
    d = get_dataset()
    if (input$explanatory == 1){
      d$F_INT
    }else{
      d$A_INT
    }
  })
  
  get_model_formula <- function(explanatory) {
    d = get_dataset()
    if (explanatory == 1){
      as.formula(d$F_INT ~ d$rotatiegroep)
    }else{
      as.formula(d$A_INT ~ d$rotatiegroep)
    }
  }
  
  aov_model <- reactive(aov(get_model_formula(input$explanatory)))
  
  output$histPlot <- renderPlot({
    hist(
      get_explanatory(), 
      main="Histogram van het aantal gedetecteerde sporen",
      ylab="Frequentie",
      xlab="Aantal gedetecteerde sporen",
      prob=TRUE
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
  })
  
  output$qqPlot <- renderPlot({
    qqnorm(get_explanatory(), main="Kwantiel-Kwantiel-plot van aantal gedetecteerde sporen")
    qqline(get_explanatory(), col="red")
  })
  
  output$boxPlot <- renderPlot({
    boxplot(get_model_formula(input$explanatory), notch=TRUE,las=2, main="Boxplot van aantal gedetecteerde sporen per rotatiegroep")
  })
  
  output$anovaSummary <- renderTable({
    summary(aov_model())
  })
  
  output$anovaPlot <- renderPlot({
    par(mfrow=c(2,2))
    plot(aov_model())
    par(mfrow=c(1,1))
  })
  
  output$TukeyHSD <- renderPlot({
    par(mar=c(5,9,4,1)+.1)
    plot(TukeyHSD(aov_model()), las=1, cex.axis=0.65)
  }, height=2000)
  
  output$tabel <- renderDataTable({ get_dataset() })
})
