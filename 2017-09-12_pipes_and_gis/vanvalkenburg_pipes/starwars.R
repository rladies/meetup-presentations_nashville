#setwd("~/Desktop/pipes")
library(tidyverse)

#copy the starwars dataset to a local variable so we can view it
starwars <- starwars
View(starwars)

#how many different home worlds do characters come from?
#starwars %>% distinct(homeworld)
distinct(starwars, homeworld)

#how many characters call each of these home?
homeworlds <- 
    starwars %>% 
    filter(!is.na(homeworld)) %>%
    group_by(homeworld) %>%
    summarise(Count = n())

homeworlds %>%
    filter(Count > 1) %>%
    ggplot(aes(reorder(homeworld, Count), Count)) +
    geom_col(fill = "darkblue") +
    scale_y_continuous(breaks = seq(0,12,2)) +
    theme(axis.text.x = element_text(angle = 90, 
                                     hjust = 1)) +
    xlab('Home World') +
    ggtitle("Homeworlds of Star Wars Characters") 

# who is the largest character
starwars %>%
    ggplot(aes(mass, height, label = name)) +
    geom_text(size = 2.5, 
            check_overlap = TRUE, aes(color = gender)) 


# let's use inches and pounds 
starwars %>%
    mutate(mass2 = mass * 2.2 ) %>%
    mutate(height2 = height * 0.393701) %>%
    ggplot(aes(mass2, height2, label = name)) +
    geom_text(size = 2.5, 
              check_overlap = TRUE, aes(color = gender)) +
    xlab("weight (pounds)") +
    ylab("height (inches)")

