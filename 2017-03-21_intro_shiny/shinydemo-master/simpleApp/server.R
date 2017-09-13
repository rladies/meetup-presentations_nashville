#Simple

# Necessary packages - load outside of the `server` function
library('shiny')
library('shinydashboard')
library('rhandsontable')
library('ggplot2')

#################################
# Define helper functions outside the shiny `ui` and `server` objects
# Alternatively, if you have a large amount of external code, you can
#    source a separate R file (e.g. `source('demo.R')`)

#Function to produce blank ggplot window
ggblank <- function(data, title = "all the animals"){
  ggplot(data, aes(x, y)) + 
    geom_rect(aes(xmax = 1.1, xmin = -0.1, ymax = 1.1, ymin = -0.1, fill = 'none'), 
              color = 'black', alpha = 0) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.x=element_blank(),
          axis.ticks.y=element_blank(),
          plot.title = element_text(hjust = 0.5),
          legend.position = 'none') +
    xlab("") + ylab("") + ggtitle(title)
}
#################################

# SERVER: TELLING THE APP WHAT TO DO WITH THE INPUTS/OUTPUTS WE MADE IN THE `UI` FILE

# SHINY COMMENTS ARE IN CAPS
# Comments on other things I'm doing to make plots, table, etc. are in normal writing
server <- function(input, output) {
  
  # `eventReactive` REACTS TO CLICK OF UPDATE BUTTON CALLED `go`
  # THESE DATA WILL BE USED FOR PLOT/TABLE GENERATION
  # VALUES WILL NOT BE UPDATED UNLESS THE 'UPDATE' BUTTON IS CLICKED
  anTab <- eventReactive(input$go, {
    # CALLS INPUTS TO GET THE NUMBER OF EACH TYPE OF ANIMAL
    # INPUTS ARE CALLED USING WHATEVER ID YOU GAVE IT (FIRST ARGUMENT IN, E.G., `sliderInput`)
    animal.df <- data.frame(animal = c("Chicken", "Bee", "Pig", "Cow"),
                            n  = c(input$chicken, as.numeric(as.character(input$bee)), 
                                   as.numeric(as.character(input$pig)), input$cow))
    
    # Total number of animals
    total <- sum(animal.df$n)
    # Add some random location data
    data.df <- data.frame(x = runif(total), y = runif(total),
                          animal = rep(animal.df$animal, animal.df$n))
    
    # Return the data we will need later
    return(list("animals" = animal.df, "data" = data.df))
  })
  
  # CODE TO BE EXECUTED WHERE WE WANT OUR PLOT
  output$animalPlot <- renderPlot({
    if(input$go == 0){ # IF THE UPDATE BUTTON HAS NOT BEEN CLICKED YET
      # Generate blank plotting window
      data <- data.frame(x = runif(1), y = runif(1))
      ggblank(data)
    }else{ # IF THE UPDATE BUTTON HAS BEEN CLICKED
      
      # GET THE MOST UP-TO-DATE INFORMATION FROM `eventReactive`
      anDat <- anTab()$animals
      data <- anTab()$data
      
      ##############################################################################
      # Junk to create the plot - not relevant to shiny at all
      # Not very pretty but it works
      ind <- cumsum(anDat$n)
      data <- data[, c("x", "y")]
      p <- ggblank(data)
      if(anDat[anDat$animal == 'Chicken','n'] > 0){
        p <- p + emoGG::geom_emoji(data = data[1:ind[1],], emoji='1f414')
      }
      if(anDat[anDat$animal == 'Bee','n'] > 0){
        p <- p + emoGG::geom_emoji(data = data[(ind[1] + 1):ind[2],], emoji='1f41d')
      }
      if(anDat[anDat$animal == 'Pig','n'] > 0){
        p <- p + emoGG::geom_emoji(data = data[(ind[2] + 1):ind[3],], emoji='1f437')
      }
      if(anDat[anDat$animal == 'Cow','n'] > 0){
        p <- p + emoGG::geom_emoji(data = data[(ind[3] + 1):ind[4],], emoji='1f42e')
      }
      p # DON'T FORGET TO PRINT THE PLOT
    }
    ##############################################################################
  }, height = 500, width = 500) # <- ARGUMENTS TO `renderPlot`, MANUALLY DEFINE SIZE OF THE FIGURE (IN PIXELS)
  
  
  # CODE TO BE EXECUTED WHERE WE WANT OUR TABLE
  # All shiny code here is similar to that for the plot, except now using `renderTable`
  output$animalTable <- renderTable({
    if(input$go == 0){ # IF THE UPDATE BUTTON HAS NOT BEEN CLICKED YET
      # No data yet
      data.frame("Animal" = c("Chicken", "Bee", "Pig", "Cow"),
                 "Proportion of Total" = rep(0, 4),
                 check.names = FALSE)
    }else{
      # MOST UP-TO-DATE INFORMATION
      anDat <- anTab()$animals
      
      # Calculate proportion of total
      data.frame("Animal" = anDat$animal,
                 "Proportion of Total" = round(anDat$n/sum(anDat$n), 2),
                 check.names = FALSE)
    }
  })
  
  # CODE TO BE EXECUTED FOR TEXT OUTPUT
  output$info <- renderText({
    # MOST UP TO DATE INFORMATION
    data <- anTab()$data
    
    # GETS THE LOCATION OF YOUR CURSOR AS IT HOVERS OVER THE PLOT 
    # SYNTAX: input$hover_name$coordinate_direction
    # Figures out which animal is closest to your cursor
    paste("Closest animal = ", data$animal[which.min(sqrt((data$x - input$plot_hover$x)^2 +
                                                          (data$y - input$plot_hover$y)^2))])
  })
}