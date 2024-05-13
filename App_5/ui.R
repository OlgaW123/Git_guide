library(shiny)

shinyUI(fluidPage( #set up shiny user interface
  titlePanel("Gene Expression TPM Plotter"), #title
  sidebarLayout( #side and main panel
    sidebarPanel( #on the side panel
      selectInput("gene_id", "Select Gene ID:", choices = NULL) #here user can select input 
    ),
    mainPanel( #on the main panel
      plotOutput("tpmPlot") #the plot for the data
    )
  )
))
