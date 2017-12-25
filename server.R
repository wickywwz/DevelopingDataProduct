library(shiny)
library(lattice) 
library(ggplot2) 
library(e1071) 
library(caret)
library(randomForest) 

# Training The Random Forest Classifier

set.seed(12306) 

rf_classifier <- function() { 
        fit_method <- trainControl(method = "cv", number = 10) 
        fit_model <- train(Species ~ ., data = iris, 
                       method = "rf", 
                       trControl = fit_method) 
        print(timestamp()) 
        return(fit_model) 
} 


flower_pred <- function(trainedModel, inputs) { 
        prediction <- predict(trainedModel, 
                              newdata = inputs, 
                              type = "prob", 
                              predict.all = TRUE) 
        return(renderTable(prediction)) 
} 


shinyServer( 
        function(input, output, session) { 
                
                data(iris) 
          
                data_sum <- capture.output(summary(iris)) 
                data_sum  <- paste(data_sum , collapse = "<br/>") 
                output$sum_iris <- renderText(data_sum)
                
                data_str <- capture.output(str(iris)) 
                data_str  <- paste(data_str , collapse = "<br/>") 
                output$str_iris <- renderText(data_str)
                
                output$sepal_width <- renderText(input$sepal_width) 
                output$sepal_length <- renderText(input$sepal_length) 
                output$petal_width <- renderText(input$petal_width) 
                output$petal_length <- renderText(input$petal_length) 

                #output$sepal_width_mean <- renderText(mean(iris$Sepal.Width)) 
                #output$sepal_length_mean <- renderText(mean(iris$Sepal.Length)) 
                #output$petal_width_mean <- renderText(mean(iris$Petal.Width)) 
                #output$petal_length_mean <- renderText(mean(iris$Petal.Length)) 
                
                #output$sepal_width_sd <- renderText(sd(iris$Sepal.Width)) 
                #output$sepal_length_sd <- renderText(sd(iris$Sepal.Length)) 
                #output$petal_width_sd <- renderText(sd(iris$Petal.Width)) 
                #output$petal_length_sd <- renderText(sd(iris$Petal.Length)) 
                
                output$sepal_width_plot <- renderPlot({ 
                        ggplot(iris, aes(x = Sepal.Width, 
                                         group = Species, 
                                         fill = as.factor(Species))) +  
                                geom_density(position = "identity", alpha = 0.5) + 
                                scale_fill_discrete(name = "Species") + 
                                theme_bw() + 
                                xlab("Sepal Width") + 
                                geom_vline(xintercept = input$sepal_width, 
                                           color = "green", 
                                           size = 2) + 
                                scale_x_continuous(limits = c(round(min(iris$Sepal.Width) *0.5, 1), 
                                                              round(max(iris$Sepal.Width) *1.5, 1))) 
                        
                }) 
                
                output$sepal_length_plot <- renderPlot({ 
                        ggplot(iris, aes(x = Sepal.Length, 
                                         group = Species, 
                                         fill = as.factor(Species))) +  
                                geom_density(position = "identity", alpha = 0.5) + 
                                scale_fill_discrete(name = "Species") + 
                                theme_bw() + 
                                xlab("Sepal Length") + 
                                geom_vline(xintercept = input$sepal_length, 
                                           color = "green", 
                                           size = 2) + 
                                scale_x_continuous(limits = c(round(min(iris$Sepal.Length) *0.5, 1), 
                                                              round(max(iris$Sepal.Length) *1.5, 1))) 
                        
                }) 
                
                output$petal_width_plot <- renderPlot({ 
                        ggplot(iris, aes(x = Petal.Width, 
                                         group = Species, 
                                         fill = as.factor(Species))) +  
                                geom_density(position = "identity", alpha = 0.5) + 
                                scale_fill_discrete(name = "Species") + 
                                theme_bw() + 
                                xlab("Petal Width") + 
                                geom_vline(xintercept = input$petal_width, 
                                           color = "red", 
                                           size = 2) + 
                                scale_x_continuous(limits = c(round(min(iris$Petal.Width) *0.5, 1), 
                                                              round(max(iris$Petal.Width) *1.5, 1))) 
                        
                }) 
                
                output$petal_length_plot <- renderPlot({ 
                        ggplot(iris, aes(x = Petal.Length, 
                                         group = Species, 
                                         fill = as.factor(Species))) +  
                                geom_density(position = "identity", alpha = 0.5) + 
                                scale_fill_discrete(name = "Species") + 
                                theme_bw() + 
                                xlab("Petal Length") + 
                                geom_vline(xintercept = input$petal_length, 
                                           color = "red", 
                                           size = 2) + 
                                scale_x_continuous(limits = c(round(min(iris$Petal.Length) *0.5, 1), 
                                                              round(max(iris$Petal.Length) *1.5, 1))) 
                        
                }) 
                
                fit_model <- reactive({ 
                        rf_classifier() 
                }) 
                
                observeEvent( 
                        eventExpr = input[["submit"]], 
                        handlerExpr = { 
                                withProgress(message = 'Please wait...', value = 0, { 
                                        my_model <- fit_model() 
                                }) 
                                Sepal.Width <- input$sepal_width 
                                Sepal.Length <- input$sepal_length 
                                Petal.Width <- input$petal_width 
                                Petal.Length <- input$petal_length 
                                
                                my_flower <- data.frame(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) 
                                
                                my_prediction <- flower_pred(my_model, my_flower) 
                                output$prediction <- my_prediction 
                        }) 
                
                observeEvent(input[["reset"]], { 
                        updateNumericInput(session, "sepal_width", value = round(mean(iris$Sepal.Width), 1)) 
                        updateNumericInput(session, "sepal_length", value = round(mean(iris$Sepal.Length), 1)) 
                        updateNumericInput(session, "petal_width", value = round(mean(iris$Petal.Width), 1)) 
                        updateNumericInput(session, "petal_length", value = round(mean(iris$Petal.Length), 1)) 
                }) 
        } 
) 
