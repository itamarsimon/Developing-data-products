library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
options(shiny.sanitize.errors = TRUE)

data <- read.csv("clean.csv", stringsAsFactors = TRUE, check.names=FALSE) %>%
  select(-1,-4,-5) 
data$YearStart <- as.factor(data$YearStart)

fluidPage(

  
  headerPanel('Obesity In the USA'),
  tabsetPanel(              
    tabPanel(title = "Table",
             fluidRow(
               
               column(4,
                      selectInput('category1',
                                  'Year',
                                  c("All",
                                    unique(as.character(data$YearStart)))),
                      helpText(tags$span(style="color:red", "You must select from the dropdown menu"))
               ),
               column(4,
                      selectInput('category2',
                                  'Category',
                                  c("All",
                                    unique(as.character(data$StratificationCategory1)))),
                      helpText(tags$span(style="color:red", "You must select from the dropdown menu"))
               ),
               column(4,
                      selectInput('category3',
                                  'Sub category',
                                  c("All",
                                    unique(as.character(data$Stratification1)))),
                      helpText(tags$span(style="color:red", "You must select from the dropdown menu"))
               )
             ),
             fluidRow(
               DT::dataTableOutput("table"),
               
                helpText(tags$span(style="color:red", "This table shows values according to choice made above
                                  resulting in a single value for each USA state according to choice above.")),
               
                helpText("Source code can be found:",
                        a("here", 
                          href = "https://github.com/itamarsimon/Developing-data-products"
                          , target="_blank"))
             
    )

  ),
  tabPanel(title = "Plot",
           plotOutput("plot1")
           
           
  )

  )
)

