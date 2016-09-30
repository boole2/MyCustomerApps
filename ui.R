library(shiny)


shinyUI(
        pageWithSidebar(  headerPanel("Customer Analysis "),
        sidebarPanel(
                helpText("Data Relative to  500 Customers of a Food & Beverage Retailer. you can move the slide to select",
                         " the Range of Spending for Individuals  based on their ticket avarage value.",
                         "1.Output In first Diagram the Distribution of Customer based on their avarage Ticket value",
                         "2.In the Second Histogram is shown the distribution of Age's Customer in the selected Ticket Range",
                         "3.In the pie chart the relative frequency of Presence of customer in Weekdays vs Weekends"),
                sliderInput('mu1', 'Spending Max threshold in Euro',value = 0.5, min = 5.5, max = 17, step = 0.5 ),
                sliderInput('mu2', 'Spending Min threshold in Euro',value = 0.5, min = 0.5, max = 17, step = 0.5 )


                ),
        mainPanel(

                plotOutput('SpendingHist')
        )
))
