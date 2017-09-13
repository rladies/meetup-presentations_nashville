library('shiny')
library('shinydashboard')
library('rhandsontable')

source('demo.R')

shinyUI(navbarPage("R-Ladies Shiny Demo", id = "mainPage",
  # CSS file from 'www' folder that contains details for formatting, layout                 
  theme = "bootstrap.css",
  
  # Makes title area a little smaller than the default
  tags$head(tags$style('nav .container:first-child {
                        margin-left:10px; width: 100%;
                        }')),
  # Name of the tab that is selected by default
  selected = "datasets",
  tabPanel("datasets",
           # Prevent error that very briefly appears
           tags$style(type="text/css",
                      ".shiny-output-error { visibility: hidden; }",
                      ".shiny-output-error:before { visibility: hidden; }"),
           
           sidebarLayout(
             sidebarPanel(
               selectInput("data", "Choose a data set", choices = dat_names, selected = "trees"),
               textOutput("data_info"),
               downloadLink("download", "Download as csv")
             ),
             
             mainPanel(
               uiOutput("variables"),
               plotOutput("plot")
             )  
           )
  ),
  
  tabPanel("More Things!",
           sidebarLayout(
             sidebarPanel(
               fileInput('file', 'Choose csv file',
                         accept=c('text/csv', 
                                  'text/comma-separated-values,text/plain', 
                                  '.csv')),
               checkboxInput("header", "Header", TRUE),
               actionButton("wait", "Click to wait 5 seconds")
             ),
             
             mainPanel(
               textOutput("title"),
               tableOutput("summary"),
               rHandsontableOutput("rhot")
             )
           )

  ),
  
  tabPanel("Correlation Example",
           sidebarLayout(
             sidebarPanel(
               numericInput("n_obs", "Number of Observations", min = 0, value = 10),
               sliderInput("corr", "Correlation", min = -1, max = 1, step = .1, value = 0),
               textInput("title", "Plot title")),
             mainPanel(plotOutput("corPlot"))
           )
  )
)
)
