#Simple

# Necessary packages - load outside of the `ui`` object
library('shiny')
library('shinydashboard')


ui <- dashboardPage(
  skin = "yellow",
  
  # Widths are in pixels
  dashboardHeader(
    titleWidth = 250,
    title = "R-Ladies Shiny Demo"
  ),
  
  # Sidebar panel area
  dashboardSidebar(
    width = 250,
    # HTML/CSS code for some formatting: Creates a little space on the left side
    #    so text/inputs aren't flush with the browser edge
    # HTML tags help with formatting and media
    # All `tags` options: https://shiny.rstudio.com/articles/tag-glossary.html
    tags$head(tags$style(HTML(".sidebar { margin-left: 5px; }"), 
                         # Sidebar is longer than main panel
                         HTML(".wrapper {overflow: visible !important;}"))),
    
    # Creates a little area with menu items
    sidebarMenu(
      # Used `HTML` function to insert a line break <br> so the text would wrap
      menuItem(HTML("Click here to learn more<br>about shinydashboard"), 
               icon = icon("book"), badgeColor = "yellow",
               # Link to another website
               href = "https://rstudio.github.io/shinydashboard/structure.html"),
      # Link to my github repo for this application
      menuItem("Source code", icon = icon("file-code-o"), 
               href = "https://github.com/hlweeks/shinydemo/tree/master/simpleApp")
      ),
    
    # Plain text ('p' means new paragraph)
    p("Choose some animals"),
    
    # Various types of input widgets to put in the sidebar
    # Inputs appear in the same order as they are written here
    # The first input is an ID - this is how you will extract 
    #    information from the input in the `server` file
    numericInput("chicken", "Chickens", value = 0, min = 0, step = 1),
    selectInput("bee", "Bees", choices = c(0, 10, 50, 100), selected = 0),
    radioButtons("pig", "Pigs", choices = c(0, 5, 10, 20), selected = 0),
    sliderInput("cow", "Cows", value = 0, min = 0, max = 10, step = 1),
    
    # Action button called "go": make events react whenever you click this button 
    actionButton("go", "Update")
  ),
  
  # Main panel area
  dashboardBody(
    
    # Another type of input: when checked, returns a value of true
    checkboxInput("manyChickens", "Check box to see all those chickens"),
    # Italicized text
    em("(May be incompatible with some browsers.)"),
    
    # Conditional panel: this will only appear when the condition is met
    conditionalPanel(
      # Condition under which this panel will appear (HTML)
      condition = "input.manyChickens == true",
      # When the condition is met, insert this video
      # tags$video calls an HTML tag
      # src calls the file named, must be in 'www' folder within the same directory as the app
      # `controls` enables things like volume and full-screen
      tags$video(src = "allthosechickens.mp4", type = "video/mp4",
                 width = "350px", height = "350px", controls = "controls")
    ),
    
    # Now specify a row of outputs, split into two columns
    fluidRow(
      # In the first column, insert a plot
      column(width = 8, # Width varies from 1 to 12
             # `hover` allows you to get the coordinates when your cursor hovers over the plot
             plotOutput("animalPlot", hover = "plot_hover")),
      # In the second column, insert a table and a text box
      column(width = 4,
             tableOutput("animalTable"),
             # In the `server` file, we will print information using the plot `hover` coordinates
             verbatimTextOutput("info"))
    ),
    # Insert some extra space at the bottom using HTML code,
    #     otherwise my plot looks like it's running off the page
    # Also, the sidebar panel was longer than the main panel 
    #     so there was awkward white space and this prevents that
    HTML("<div style='height: 150px;'>")
  )
)