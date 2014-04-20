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
            plotOutput("histPlot", height="100%")
          ),
        
          tabPanel(
            'QQ-plot',
            plotOutput("qqPlot", height="100%")
          ),
          
          tabPanel(
            'Boxplot',
            plotOutput("boxPlot", height="100%")
          ),
          
          tabPanel(
            'Anova',
            tabsetPanel(
              tabPanel(
                'Tabel',
                tableOutput("anovaSummary")
              ),
              tabPanel(
                'Plot',
                plotOutput("anovaPlot", height="100%")
              ),
              tabPanel(
                'Tukey HSD',
                plotOutput("TukeyHSD", height="100%")
              )
            )
          ),
          
          tabPanel('Brondata',
                   dataTableOutput('tabel')),
          id = "conditionedPanels"
        )))
)))
