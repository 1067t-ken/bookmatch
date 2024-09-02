class Public::HomesController < ApplicationController
 def top
   redirect_to current_user if current_user
 end
 
 def about
 end
end
