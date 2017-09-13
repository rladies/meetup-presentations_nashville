library('shiny')
library('shinydashboard')
library('rhandsontable')
library('mvtnorm')


shinyServer(function(input, output) {
  #######
  #Tab1 #
  #######  
  output$data_info <- renderText({
    dat_titles[which(input$data == dat_names)]
  })
  
  output$variables <- renderUI({
    data(list = input$data)
    
    fluidRow(
      column(4,
             selectInput("xvar", "Variable 1", choices = colnames(get(input$data)))
             ), 
      column(4,
             selectInput("yvar", "Variable 2", choices = colnames(get(input$data)))
             )
      )
  })
  
  output$download <- downloadHandler(
    filename <- function(){paste0(input$data, ".csv")},
    
    content <- function(file){
      data(list = input$data)
      write.csv(get(input$data), file)
    }
  )
  
  output$plot <- renderPlot({
    data(list = input$data)
    
    with(get(input$data), plot(get(input$xvar), get(input$yvar), 
                               xlab = input$xvar, ylab = input$yvar))
  })
  
  #######
  #Tab2 #
  #######
  
  output$rhot <- renderRHandsontable({
    inFile <- input$file
      
    if (is.null(inFile)){return(NULL)}else{
      
    rhandsontable(read.csv(inFile$datapath, header=input$header))
    }
  })
  
  #Get the data from rhandsontable
  getData <- reactive(
    hot_to_r(input$rhot)
  )
  
  output$title <- renderText({
    if(!is.null(input$file)) "Column Means"
  })
  
  output$summary <- renderTable({
    the_data <- getData()
    
    num_index <- sapply(1:ncol(the_data), 
                        function(i) class(the_data[,i]) %in% c('numeric', 'integer'))
    num_data <- the_data[,num_index]
    
    t(data.frame(apply(the_data, MARGIN = 2, mean)))
  })
  
  observeEvent(input$wait, {
    withProgress(message = 'Waiting...', min = 0, max = 1, {
      for(i in 1:5) {Sys.sleep(1); incProgress(.2)}
    })
  })
  
  #######
  #Tab3 #
  #######
  
  output$corPlot <- renderPlot({
    covMat <- diag(2) + matrix(c(0, 1, 1, 0), nrow = 2)*input$corr
    data <- rmvnorm(input$n_obs, sigma = covMat)
    
    # Title won't update as you type, but will update in response to other reactive values
    #    i.e. the title will update once you change the correlation input
    # Could use an action button to update the title without having the data change at all
    plot(data[,1], data[,2], xlab = "x", ylab = "y", main = isolate(input$title))
  })  
  
})


  
  
  