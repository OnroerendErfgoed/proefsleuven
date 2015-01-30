library(shinydashboard)

dashboardPage(
  
  dashboardHeader(title='Simulaties'),
  dashboardSidebar(
                      selectInput("dataset", "Kies een dataset", choices = list.files("./data", full.names=TRUE)),
                      radioButtons(
                        "explanatory", 
                        "Verklarende variabele",
                        choices = list("Aantal" = 1, "Oppervlakte" = 2),
                        selected = 1
                      ),
                      sidebarMenu(
                        menuItem('Histogram', tabName='histogram'),
                        menuItem('Anova', tabName='anova'),
                        menuItem('Boxplot', tabName='boxplot'),
                        menuItem('Brondata', tabName='brondata')
                      ),
                      downloadButton('downloadData', 'Download brondata')
                      ),
  dashboardBody(
                tabItems(
                  tabItem(tabName='histogram',
                          fluidRow(
                            box(title='QQ-plot', solidHeader=TRUE, status = "primary", plotOutput("qqPlot")),
                            box(title='Histogram', solidHeader=TRUE, status = "primary", plotOutput("histPlot", height = '100%'),
                                checkboxInput("normaal", "Normaalverdeling weergeven", TRUE),
                                checkboxInput("densiteit", "Densiteitscurve weergeven", TRUE))
                          )
                  ),
                  
                  tabItem(tabName='boxplot',
                          fluidRow(
                          box(title='Boxplot', solidHeader=TRUE, status = "primary", width=12, 
                              plotOutput("boxPlot", height='100%'), 
                              sliderInput("rotatiegroepgrootte", 
                                          "Grootte van de roatatiegroepen", 5, 60, 10, step=5)))
                  ),
                  tabItem(tabName='anova',
                          fluidRow(
                                column(width=6,
                                        box(
                                         title='Anova samenvatting',
                                         width=NULL,
                                         solidHeader=TRUE, 
                                         status='primary',
                                         tableOutput("anovaSummary")),
                                        box(title='Anova plot',
                                            width=NULL,
                                            solidHeader=TRUE,
                                            status='primary',
                                            plotOutput("anovaPlot"))
                                    ),
                                column(width=6,
                                        box(title="Tukey's Honest Significant Difference", 
                                            width=NULL,
                                            solidHeader=TRUE, 
                                            status='primary', 
                                            plotOutput("TukeyHSD"))
                                )
                          )
                  ),
                  tabItem(tabName='brondata',
                        fluidRow(
                          box(title='Brondata', 
                              width=NULL,
                              solidHeader=TRUE, 
                              status='primary', dataTableOutput('tabel'))
                        )
                     )
                )                
  )
)
  
  
