
library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel(title=h4("Modeling Stock Price with Quadratic Discriminant Analysis",style = "color:blue" ) ),

  sidebarLayout(
    sidebarPanel(
      #h6(imageOutput("img")),

                 textInput("Stock","Stock Symbol","BA"),
                 textInput("start","Date Start","2012-01-01"),
                 textInput("finish","Date End","2016-06-01"),

                  sliderInput("slider","% of Data for Training",min=10,max = 100,value =10,step = 10 )

                 ),

   mainPanel(


     tabsetPanel(type="tab",

                 tabPanel("QDA",p(""),HTML('<center><img src="i1.jpg" width="300"></center>'), p("The application is built for Developing Data Products class
from Coursera. This application allows determinate if Quadratic Discriminant Analysis can predict
                                                                                                 the actual direction (test price) using past price (training).",style = "color:blue")

                          ),
                 tabPanel("Model",textOutput("text1"),p(""),p(""),p(""),plotlyOutput("plot2")),
                 tabPanel("Plot lag1 vs lag2",plotOutput("plot1")),
                 tabPanel("Data",tableOutput("data")),
                 tabPanel("Help",p(""),HTML('<center><img src="help.png" width="700"></center>'))

     ),


     #p(textOutput("text1"),style = "color:blue"),
     #plotlyOutput("plot2"),

     a(href="http://finance.yahoo.com/lookup","Find a symbol"),p("On Yahoo"),

     a(href="https://github.com/santiagoeguren/Developing-Data-Products",
       "SourceCode"), p("On GITHUB"),

     a(href="http://rpubs.com/santiagoe/DevelopingDataProducts",
       "Course Presentation"), p("On RPUBs")




     )## fin main panel



)
))




