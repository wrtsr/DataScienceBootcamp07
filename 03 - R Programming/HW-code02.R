##    Pao Ying Chub    ##

pyc <- function() {
  
  win <- 0
  lose <- 0
  draw <- 0

  print("--------------- How to play game ---------------")
  print("       There are 3 options you can select       ")
  print("               1. Paper                         ")
  print("               2. Scissor                       ")
  print("               3. Hammer                        ")
  print(" Enter number 1 or 2 or 3 to select your option ")
  
  while(TRUE){
    
    user_select <- as.numeric(readline("Select your option: "))
    
    if (user_select == 1 | user_select == 2 | user_select == 3) {
      
      comp_select <- sample(c(1:3), 1)
      
      if (user_select == comp_select) {
        draw <- draw + 1
        print(paste("Computer select:", comp_select))
        print("Draw!")
        print(paste("win:", win, ", lose:", lose, ", draw:", draw))
      }
      
      else if ((user_select == 1 & comp_select == 2) |
               (user_select == 2 & comp_select == 3) |
               (user_select == 3 & comp_select == 1)){
        lose <- lose + 1
        print(paste("Computer select:", comp_select))
        print("You lose!")
        print(paste("win:", win, ", lose:", lose, ", draw:", draw))
      }
      
      else {
        win <- win + 1
        print(paste("Computer select:", comp_select))
        print("You win!")
        print(paste("win:", win, ", lose:", lose, ", draw:", draw))
      }
      
      is_continue <- readline("Press any key to play again or 'x' to exit: ")
      if (is_continue == "x") {
        print(paste("Summary: ", "win", win, ", lose", lose, ", draw", draw))
        break
      }
    }
    
    else {
      print("Error! Please enter only number 1 or 2 or 3")
    }
  }
  
}

pyc()
