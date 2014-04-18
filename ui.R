library(shiny)

shinyUI(navbarPage('Simulaties',
  
  tabPanel('Analyse',
  
    sidebarLayout(
      sidebarPanel(
        selectInput("dataset", h6("Kies een dataset:"), 
                    choices = list.files("./data", full.names=TRUE)),
        downloadButton('downloadData', 'Download brondata'),
        conditionalPanel(
          condition="input.conditionedPanels != 'Brondata'",
          radioButtons(
                       "explanatory", 
                       h6("Verklarende variabele"),
                       choices = list("Aantal" = 1, "Oppervlakte" = 2),
                       selected = 1
                      )
        ),
        conditionalPanel(condition="input.conditionedPanels == 'Histogram'",
                         h6('Opties'),
                         checkboxInput("normaal", "Normaalverdeling weergeven", TRUE),
                         checkboxInput("densiteit", "Densiteitscurve weergeven", TRUE)
        ),
        conditionalPanel(condition="input.conditionedPanels != 'Histogram'",
                         sliderInput("rotatiegroepgrootte", h6("Grootte van de roatatiegroepen:"), 5, 60, 10, step=5)
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
          
          tabPanel('Brondata',
                   dataTableOutput('tabel')),
          id = "conditionedPanels"
        )))
)))
