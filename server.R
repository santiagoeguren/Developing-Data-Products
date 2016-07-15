library(UsingR)
library(ISLR)
library(MASS)
library(quantmod)
library(ggplot2)
library(plotly)


shinyServer(

  function(input, output){

    output$text1 <- renderText({

      sy=input$Stock

      start=input$start
      finish=input$finish


      Data_1 <- new.env()
      getSymbols(Symbols = sy[1], src = 'yahoo', from =start ,
                 to =finish , env = Data_1)

      #Varible para descargar de env data


      Equity_1 <- as.data.frame(Data_1[[sy[1]]])


      # serie log

      serie_1<-log10(Equity_1[,6])

      #Armar los distintos valores

      #Armar los distintos valores

      serie_1_2<-serie_1[-1]
      serie_1_1<-serie_1[-length(serie_1)]


      today_bruto<-serie_1_2-serie_1_1

      today<-today_bruto[-c(1,2)]
      lag_1<-today_bruto[-c(1,length(today_bruto))]
      lag_2<-today_bruto[-c(length(today_bruto),length(today_bruto)-1)]

      direction<-today
      direction[direction<0]<-"Down"
      direction[direction!="Down"]<-"Up"

      Year<-c(1:length(direction))

      ### Armar el data frame

      Smarket_s<- data.frame(Year,direction, today, lag_1,lag_2)
      colnames(Smarket_s) <- c("Year", "Direction", "Today","Lag1","Lag2")


      ## ## cuadratico

      attach(Smarket_s)

      potrs<-input$slider/100

      train=(Year<length(direction)*potrs)
      Smarket.2005=Smarket[!train,]
      Direction.2005=Direction[!train]

      qda.fit=qda(Direction~Lag1+Lag2, data = Smarket_s, subset = train)
      qda.fit

      qda.pred=predict(qda.fit, Smarket.2005)

      qda.class=qda.pred$class

      table(qda.class)
      table(Direction.2005)


      rez<-mean(qda.class==Direction.2005)
      rez<-paste(round(100*rez, 2), "%", sep="")
      paste("The QDA predictions are accurate almost: ",rez)

      })

    output$plot1<-renderPlot({



      sy=input$Stock

      start=input$start
      finish=input$finish




      Data_1 <- new.env()
      getSymbols(Symbols = sy[1], src = 'yahoo', from =start ,
                 to =finish , env = Data_1)

      #Varible para descargar de env data


      Equity_1 <- as.data.frame(Data_1[[sy[1]]])


      # serie log

      serie_1<-log10(Equity_1[,6])

      #Armar los distintos valores

      #Armar los distintos valores

      serie_1_2<-serie_1[-1]
      serie_1_1<-serie_1[-length(serie_1)]


      today_bruto<-serie_1_2-serie_1_1

      today<-today_bruto[-c(1,2)]
      lag_1<-today_bruto[-c(1,length(today_bruto))]
      lag_2<-today_bruto[-c(length(today_bruto),length(today_bruto)-1)]

      direction<-today
      direction[direction<0]<-"Down"
      direction[direction!="Down"]<-"Up"

      Year<-c(1:length(direction))

      ### Armar el data frame

      Smarket_s<- data.frame(Year,direction, today, lag_1,lag_2)
      colnames(Smarket_s) <- c("Year", "Direction", "Today","Lag1","Lag2")


      g<-ggplot(data.frame(x=Lag1,y=Lag2),aes(x=Lag1, y=Lag2))
      g<-g+geom_point(aes(colour = Direction), alpha = 0.5)
      g<-g+theme(legend.key = element_blank())
      g<-g+scale_color_manual(values = c("Up" = "Blue", "Down" = "red"))
      g<-g+ theme_bw()
      g





    })## fin render plot1


    output$plot2<-renderPlotly({



      sy=input$Stock

      start=input$start
      finish=input$finish




      Data_1 <- new.env()
      getSymbols(Symbols = sy[1], src = 'yahoo', from =start ,
                 to =finish , env = Data_1)

      #Varible para descargar de env data


      Equity_1 <- as.data.frame(Data_1[[sy[1]]])



      Close_price<-Equity_1[,6]

      potrsp<-input$slider/100
      tran_1<-rep("Training",length(Equity_1[,6])*potrsp)
      tran_2<-rep("Test",length(Close_price)-length(tran_1))

      traning<-c(tran_1,tran_2)
      time_t<-c(1:length(Close_price))

      Smarket_ploty<- data.frame(time_t,Close_price, traning)
      colnames(Smarket_ploty) <- c("time_t", "Close_price", "traning")




      plot_ly(Smarket_ploty, x = time_t, y = Close_price, text = paste("Close Price: ",Close_price ),
              color = traning, mode = "markers")


    })## fin render plot2

    output$data<-renderTable({

      sy=input$Stock

      start=input$start
      finish=input$finish




      Data_1 <- new.env()
      getSymbols(Symbols = sy[1], src = 'yahoo', from =start ,
                 to =finish , env = Data_1)

      #Varible para descargar de env data


      Equity_1 <- as.data.frame(Data_1[[sy[1]]])


      # serie log

      serie_1<-log10(Equity_1[,6])

      #Armar los distintos valores

      #Armar los distintos valores

      serie_1_2<-serie_1[-1]
      serie_1_1<-serie_1[-length(serie_1)]


      today_bruto<-serie_1_2-serie_1_1

      today<-today_bruto[-c(1,2)]
      lag_1<-today_bruto[-c(1,length(today_bruto))]
      lag_2<-today_bruto[-c(length(today_bruto),length(today_bruto)-1)]

      direction<-today
      direction[direction<0]<-"Down"
      direction[direction!="Down"]<-"Up"

      Year<-c(1:length(direction))

      ### Armar el data frame

      Smarket_s<- data.frame(Year,direction, today, lag_1,lag_2)
      colnames(Smarket_s) <- c("Year", "Direction", "Today","Lag1","Lag2")

      Smarket_s



    })## data
    output$img <- renderImage({list(src = 'imagen1.png')}, deleteFile = FALSE)

  }

)



