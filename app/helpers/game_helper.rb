module GameHelper
  
  def check_if_bust
    if (session[:player_hand].score > 21)
    @result = "You Have Gone Bust"
    end
  end
  
  def check_for_bj
    if (session[:player_hand].score == 21)
      @result = "Congratulations BlackJack!"
    end
  end
  
  def find_winner
    score = session[:player_hand].score
    d_score = session[:dealer_hand].score
    
    if (score > 21)
      @result = "You Lose"
    elsif (score == d_score)
      @result = "You Push"
    elsif (d_score > 21 or (score > d_score))
      @result = "You Win!"
    else
      @result = "You Lose"
    end
  end
  
end
