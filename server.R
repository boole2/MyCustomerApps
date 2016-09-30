library(shiny)
library(ggplot2)
library(dplyr)

customer <- readRDS("data/customerdata.rds")


shinyServer(
        function(input, output) {
                output$SpendingHist <- renderPlot({

                        mu1 <- input$mu1
                        mu2 <- input$mu2
                        if(mu1 < mu2) return()
                        high_spending <- customer[ (customer$ticket_avg > mu2 & customer$ticket_avg <  mu1)  ,]
                        par(mfrow = c(3, 1), mar = rep(2, 4), cex=1)
                         hist(high_spending$ticket_avg, xlim = c(0,18), ylim = c(0,120), xlab='Customer Avarage Tickect', col='lightblue',main='Distribution of Avarge Ticket for selected Population on Range')
                        text(15, 120, paste("Customer  Number of Individuals = ",nrow(high_spending)))
                        text(15, 105, paste("Ticket Euro Upper threshold = ",mu1))
                        text(15, 90, paste("Ticket Euro Lower threshold = ",mu2))
                        text(15, 75, paste("Ticket Avarage for the group = ", round( mean(high_spending$ticket_avg),2) ))

                        hist(high_spending$age, xlim = c(0,120), ylim = c(0,120), xlab='Customer Age for Individuals', col='lightblue',main='Distribution of Age for selected population in Range')
                        text(20, 100, paste("Customer Number of Individuals = ",nrow(high_spending)))
                        text(20, 120, paste("Age Avarage for the group = ", round( mean(high_spending$age),2) ))
                        text(20, 110, paste("Age sd for the group = ",round( sd(high_spending$age),2)))

                      sum_weekday <-   high_spending %>% summarise(
                              i_wend = sum ( ifelse( frq_wend.avg > 0, 1,0  )),
                              i_wday = sum ( ifelse( frq_wday.avg > 0, 1,0  )   ),
                              t_wend = sum ( ifelse( frq_wend.avg > 0, ticket_avg,0  )),
                              t_wday = sum ( ifelse( frq_wday.avg > 0, ticket_avg,0  )   ),
                              t_avg_wend = round(  t_wend /i_wend,2),
                              t_avg_wday = round(  t_wday /i_wday,2))

                        slices <- c(sum_weekday$i_wend, sum_weekday$i_wday )
                        lbls <- c("Number of Individuals  Buying  Weekends", "Number Individuals Buying Weekdays ")
                        pie(slices, labels = lbls, col=rainbow(length(lbls)),  main="Chart of Customer  Presence in Weekdays vs Weekend")
                        legend("topleft", c(paste("Presence Weekend = ", sum_weekday$i_wend),paste("Presence Weekay = ", sum_weekday$i_wday)), cex = 0.8,
                               fill = rainbow(length(lbls)))

                         }, height = 650 , width = 700)
        }
)
