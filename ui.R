library(shiny)

shinyUI(fluidPage(
  
  headerPanel("Simulaties"),
  sidebarLayout(
  sidebarPanel(
    selectInput("dataset", "Kies een dataset:", 
                choices = list.files("./data", full.names=TRUE)),
    radioButtons("explanatory", "Verklarende variabele",
                 choices = list("Aantal" = 1, "Oppervlakte" = 2), selected = 1),
  
    conditionalPanel(condition="input.conditionedPanels == 'Histogram'",
      checkboxInput("normaal", "Normaalverdeling weergeven", TRUE),
      checkboxInput("densiteit", "Densiteitscurve weergeven", TRUE)
    ),
    conditionalPanel(condition="input.conditionedPanels != 'Histogram'",
      sliderInput("rotatiegroepgrootte", "Grootte van de roatatiegroepen:", 5, 60, 10, step=5)
    )
  ),
    
  
  mainPanel(
    tabsetPanel(
    tabPanel(
               'Histogram',
               h3('Histogram'),
               plotOutput("histPlot"),
               h3('Kwantiel-Kwantielplot'),
               plotOutput("qqPlot")
      ),
    tabPanel(
      'Boxplot',
      h3('Boxplot'),
       plotOutput("boxPlot")
    ),
    tabPanel(
      'Anova',
      h3('Anova tabel'),
      tableOutput("anovaSummary"),
      h3('Anova plot'),
      plotOutput("anovaPlot"),
      h3('Tukey Honest Significant Difference test'),
      plotOutput("TukeyHSD")
      ),
    tabPanel('brondata', dataTableOutput('tabel')),
    id = "conditionedPanels"
  )))
))
