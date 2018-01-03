library(shiny)
library(DT)
library(dplyr)
options(shiny.sanitize.errors = TRUE)

data <- read.csv("clean.csv", stringsAsFactors = TRUE, check.names=FALSE) %>%
  select(-1,-4,-5) 
data$YearStart <- as.factor(data$YearStart)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  



    output$table <- DT::renderDataTable(DT::datatable({

    
   if (input$category1 != "All") {
      data <- filter(data, YearStart == input$category1 )
    }

    if (input$category2 != "All") {
      data <- filter(data, StratificationCategory1 == input$category2)
    }
    
    if (input$category3 != "All") {
      data <- filter(data, Stratification1 == input$category3)
    }

    data
  }))
   
  output$plot1 <- renderPlot({
    a <- if (input$category1 != "All") {
      data <- filter(data, YearStart == input$category1)
      if (input$category2 != "All") {
        data <- filter(data, StratificationCategory1 == input$category2)
        if (input$category3 != "All") {
          data <- filter(data, Stratification1 == input$category3)
        
    }}}
    
    g <- ggplot(data = a, aes(x=LocationDesc, y=Data_Value))+
      geom_point(shape=21)+
      ggtitle("Obesity In Each State")+
      xlab("State")+
      ylab("Obesity Value (%)")+
      theme(axis.text.x=element_text(angle=90,hjust=1))
    g
    
  })
  
})
