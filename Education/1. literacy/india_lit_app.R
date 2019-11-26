library(shiny)
library(ggplot2)
#library(rsconnect)

# setwd("~/Documents/South Asia /IND_NSS_75_2017/Education/1. literacy")
Literacy_wide <- read.csv(file="tableau_literacy_wide.csv", header=TRUE, sep=",")

ui <- fluidPage(
  titlePanel("Gaps in Literacy Rates by Gender"),
  
  sidebarLayout(
    
    sidebarPanel("Description: Key indicators of household social consumption on education in India NSS 75th round (July 2017- June 2018)", 
    helpText("Literacy rates among people of 7 years of age and above was 77.7%. It was 73.5% in rural areas and 87.7% in urban areas. Source: Literacy rate among persons of age 7 years and above for NSS 75th round for different states given in Table 2.1."),
    includeHTML("Numbers.html"),
    selectInput("var", label = "Choose a variable to display",
                choices = c("Rural", "Urban","Total"), selected = "Rural")),
    mainPanel(plotOutput("hist"))
    
    ),
  )

server <- function(input, output){

  output$hist = renderPlot({
    Literacy <- switch(input$var, 
                   "Rural" = Literacy_wide[which(Literacy_wide$urban == "Rural"),],
                   "Urban" = Literacy_wide[which(Literacy_wide$urban == "Urban"),],
                   "Total" = Literacy_wide[which(Literacy_wide$urban == "Total"),])
                   
    
    title <- "100 random normal values"
    
    ggplot(data = na.omit(Literacy), 
           aes(lit_total,reorder(state,lit_female))) + 
      geom_point() + 
      geom_errorbarh(aes(xmax = lit_male, xmin =lit_female)) + ggtitle('Range between male and female literacy rate')+xlim(c(50,100))+labs(x="Literacy rate %", y="State")+ 
      theme(text = element_text(size=20))
    
  })
}
shinyApp(ui=ui , server=server)


