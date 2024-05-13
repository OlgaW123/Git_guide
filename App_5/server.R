library(shiny)
library(ggplot2)
library(reshape2)

#load data fro file in the directory
tpm_data <- read.csv("TPMs_table_100genes.csv")

#for ggplot2 we need to change format to long so we use melt form reshape2 <- this was done with help of ChatGPT
#     GeneID    Sample    TPM
#1  FBgn0000003 Control_1 373.92
tpm_long <- melt(tpm_data, id.vars = "GeneID", variable.name = "Sample", value.name = "TPM")
print(tpm_long)
shinyServer(function(input, output, session) {
  observe({#if tmp_long changes it updates the data
    gene_ids <- unique(tpm_long$GeneID) 
    updateSelectInput(session, "gene_id", choices = gene_ids)
  })
  
  output$tpmPlot <- renderPlot({ #interactive plot that can change
    req(input$gene_id) #make sure gene_id is selected
    
    gene_data <- tpm_long[tpm_long$GeneID == input$gene_id, ] #filters gene data to match gene_id
    
    ggplot(gene_data, aes(x = Sample, y = TPM)) + #plot 
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(title = paste("TPM Expression for Gene:", input$gene_id),
           x = "Sample",
           y = "TPM") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
})
