library('ggplot2')

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



  
