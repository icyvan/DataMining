library(shiny)

# Define UI for application that draws a histogram
makeJoinedRow = function(label, id, min, max, value) {
  fluidRow(
    column(2, h5(label)),
    column(10,
           sliderInput(
             inputId = input$D(x), input$D(y), input$M(x), input$M(y)
             label = NULL,
             min = min,
             max = max,
             value = value
           )
    )
  )
}
   
   # Application title
   titlePanel("Линии уровня нормального распределения"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
             makeJoinedRow("Дисперсия  X", "D(x)", 1, 10, 1),
             makeJoinedRow("Дисперсия  Y", "D(y)", 1, 10, 1),
             makeJoinedRow("Мат. ожидание X", "M(x)", -5, 5, 0),
             makeJoinedRow("Мат. ожидание Y", "M(y)", -5, 5, 0)
           ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput(outputId = "plot", height = "600px")
      )
   )
)

lines_draw = function(x, y, mu, sigma) {
  x = matrix(c(x, y), 1, 2)
  k = 1 / sqrt((2 * pi) ^ 2 * det(sigma))
  e = exp(-0.5 * (x - mu) %*% solve(sigma) %*% t(x - mu))
  return(k * e)
}

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$Plot <- renderPlot({
     
     #Создаем тестовые данные
     par(bg = 'white', fg = 'black')
      
     lines_draw = function(mu, cov, what=1, title) {  
       det = det(cov)
       a = cov[1,1]
       b = cov[1,2]
       c = cov[2,1]
       d = cov[2,2]
       mu1 = mu[1]
       mu2 = mu[2]
       A = d/det
       B = (-b-c)/det
       C = a/det
       D = (-2*d*mu1 + b*mu2 + c*mu2)/det
       E = (b*mu1 + c*mu1 - 2*a*mu2)/det
       f = (d*mu1*mu1-b*mu1*mu2-c*mu1*mu2+a*mu2*mu2)/det
       
       x = y = seq(-4, 4, (8) / 200)
       
       z = outer(x, y, function(x, y) 1/sqrt(2*pi*d) * exp(-1/2 * (A*x*x+B*y*x+C*y*y+D*x+E*y+f)))
       
       if (what == 1) {
         contour(x, y, z, levels=seq(0,1,0.05), main=title, drawlabels=T, asp=1)
       } else {
         mx = max(z)
         pos = 1
         mat = matrix(0, nrow=l1*l2, ncol=3)
         for (i in 1:length(x)) {
           for (j in 1:length(y)) {
             col = rgb(z[i,j] / mx, 0, z[i,j] / mx)
             mat[pos,] = c(x[i], x[j], col)
             pos = pos + 1
           }
         }
         #plot(mat[,1], mat[,2], col=mat[,3], pch=22, main=title, asp=1, xlab="Первый признак", ylab="Второй признак")
       }
     }
      

# Run the application 
shinyApp(ui = ui, server = server)



