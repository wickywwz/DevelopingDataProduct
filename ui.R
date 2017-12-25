library(shiny)

shinyUI( 
        navbarPage("What is your iris species", 
                   tabPanel("Classifier",
                            sidebarPanel( 
                                    width = 8, 
                                    
                                    h3("Your flower measurements against iris dataset"), 
                                    
                                    
                                    fluidRow( 
                                            splitLayout(cellWidths = c("50%", "50%"), 
                                                        plotOutput("sepal_width_plot", height = "200px"), 
                                                        plotOutput("sepal_length_plot", height = "200px") 
                                            )), 
                                    
                                    fluidRow( 
                                            splitLayout(cellWidths = c("50%", "50%"), 
                                                        sliderInput("sepal_width",  
                                                                    "Sepal Width:",  
                                                                    min = round(min(iris$Sepal.Width) * 0.5, 1), 
                                                                    max = round(max(iris$Sepal.Width) * 1.5, 1),
                                                                    round = -2,
                                                                    value = round(mean(iris$Sepal.Width), 1)), 
                                                        sliderInput("sepal_length",  
                                                                    "Sepal Length:", 
                                                                    min = round(min(iris$Sepal.Length) * 0.5, 1), 
                                                                    max = round(max(iris$Sepal.Length) * 1.5, 1), 
                                                                    round = -1,
                                                                    value = round(mean(iris$Sepal.Length), 1)) 
                                            )), 
                                    
                                    fluidRow( 
                                            splitLayout(cellWidths = c("50%", "50%"), 
                                                        plotOutput("petal_width_plot", height = "200px"), 
                                                        plotOutput("petal_length_plot", height = "200px") 
                                            )), 
                                    
                                    fluidRow( 
                                            splitLayout(cellWidths = c("50%", "50%"), 
                                                        sliderInput("petal_width",  
                                                                    "Petal Width:",  
                                                                    min = round(min(iris$Petal.Width) * 0.5, 1), 
                                                                    max = round(max(iris$Petal.Width) * 1.5, 1), 
                                                                    round = -2,
                                                                    value = round(mean(iris$Petal.Width), 1)), 
                                                        sliderInput("petal_length",  
                                                                    "Petal Length:", 
                                                                    min = round(min(iris$Petal.Length) * 0.5, 1), 
                                                                    max = round(max(iris$Petal.Length) * 1.5, 1),
                                                                    round = -1,
                                                                    value = round(mean(iris$Petal.Length ), 1)) 
                                            )), 
                                    
                                    actionButton( 
                                            inputId = "submit", 
                                            label = "Classify My Flower" 
                                    ), 
                                    
                                    actionButton( 
                                            inputId = "reset", 
                                            label = "Reset" 
                                    ) 
                            ), 
                            
                            mainPanel( 
                                    width = 4, 
                                    tabsetPanel( 
                                            tabPanel(p(icon("bar-chart"), "My Flower Type"), 
                                                     h2("Instruction"),
                                                     p("Step 1: Slide the white button below each figure to choose your flower's shape."),
                                                     p("Step 2: Click 'Classify My Iris' button to find out your flower's species"),
                                                     h2("Result"), 
                                                     p("Shown as probabilities for each species according to your input."), 
                                                     tableOutput("prediction") 
                                            ), 
                                            
                                            tabPanel(p(icon("desktop"), "Classification Model"), 
                                                     
                                                     h2("Model Description"), 
                                                     p("Model used in this app is trained on the complete iris dataset. Random forests model is used to form the classifier."),
                                                     p("All files about this app can be accessed on GitHub:"), 
                                                     a(href = "https://github.com/wickywwz/DevelopingDataProduct", 
                                                       "https://github.com/wickywwz/DevelopingDataProduct", 
                                                       target = "_blank"), 
                                                     
                                                     h2("Dataset"), 
                                                     p("The prediction model was trained on the Iris Dataset:"), 
                                                     a(href = "https://en.wikipedia.org/wiki/Iris_flower_data_set", 
                                                       "https://en.wikipedia.org/wiki/Iris_flower_data_set", 
                                                       target = "_blank"), 
                                                     h3("dataset structure:"), 
                                                     tableOutput("str_iris") ,
                                                     h3("dataset summary:"), 
                                                     tableOutput("sum_iris"),
                                                     
                                                     h2("User Guide"), 
                                                     p("A brief presentation about this app is on RPubs:"), 
                                                     a(href = "http://rpubs.com/wickywwz/iris_app", 
                                                       "http://rpubs.com/wickywwz/iris_app", 
                                                       target = "_blank"),
                                                     p("If you have troubles using this app, you can find some useful guidiance in this presentation.")
                                                     
                                                     
                                            ) 
                                    ) 
                            ) 
                   ), 
                   
                   tabPanel(p(icon("info"), "Info"), 
                            mainPanel( 
                                    p("This app is part of the Developing Data Products course project on Coursera"),
                                    a(href="https://www.coursera.org/learn/data-products/",
                                      "https://www.coursera.org/learn/data-products/",
                                      target = "_blank")
                            )
                   ) 
        ) 
)