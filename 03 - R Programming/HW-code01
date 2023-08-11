##    Chat bot สั่ง Pizza    ##


menu <- c("Pepperoni", "Cheese", "Ham", "Bacon")
price <- c(200, 180, 200, 200)
menus <- data.frame(menu_id = 1:4, menu, price)

chatbot <- function() {
  username <- readline("Please enter your name: ")
  print(paste("Welcome", username, "to Judy's Pizza. This is all ours menus today."))
  print(menus)
  selected_menu <- c()
  total <- 0
  
  
  while (TRUE) {
    is_order <- readline("Can I get somethings for you? Press any key to continue or 'x' to exit: ")
   
    if (is_order == "x") {
      print("Thank you, see you next time.")
      break
    }
    
    else {
      selected_id <- as.numeric(readline("Please enter menu id: "))
      print(paste("Your order:", menus[selected_id, 2], "pizza"))
      print(paste("Price:", menus[selected_id, 3], "฿"))
      is_cf <- readline("Will you confirm your order? (type 'cf' to confirm or press any key to cancel):")
      
      if (is_cf == "cf"){
        selected_menu <- append(selected_menu, menus[selected_id, 2])
        total <- total + as.numeric(menus[selected_id, 3])
        print("You have comfirmed your order!")
        print("Order summary:")
        for (i in selected_menu){
          print(paste(i, "pizza"))
        }
        print(paste("Total:", total, "฿"))
      }
      
      else {
        print("Your order has been canceled!")
      }
    }
  }
}

chatbot()
