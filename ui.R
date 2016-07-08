

library(shiny)

shinyUI(fluidPage(
  titlePanel(title=h4("Modeling Stock Price with Quadratic Discriminant Analysis")),

  sidebarLayout(
    sidebarPanel(
                 textInput("Stock","Stock Symbol","BA"),
                 textInput("start","Date Start","2012-01-01"),
                 textInput("finish","Date End","2016-06-01"),

                 sliderInput("slider","% of Data for Training",min=10,max = 100,value =10,step = 10 )

                 ),

   mainPanel(

     p("The application is built for Developing Data Products class
from Coursera. This application allows determinate if Quadratic Discriminant Analysis can predict
       the actual direction of price using lag1 and lag2."),

     h5("References"),

     a(href="http://finance.yahoo.com/lookup","Find a symbol"),p("On Yahoo"),

     a(href="https://github.com/RanjanParida/DevelopingDataProd",
       "SourceCode"), p("On GITHUB"),

     a(href="http://rpubs.com/rparida/DDP_PA",
       "Course Presentation"), p("On RPUBs"),

     tabsetPanel(type="tab",

                 tabPanel("QDA",p(""),textOutput("text1")),
                 tabPanel("Plot",plotOutput("plot1")),
                 tabPanel("Data",tableOutput("data")),
                 tabPanel("Help",p(""),p("-Example of Symbols:KO - Coca-cola,AAPL - Apple Inc, JNJ -Johnson & Johnson...etc"),p("-lag1 y lag2: Change of price time -1 and -2"))

               )

     )## fin main panel



)
))
