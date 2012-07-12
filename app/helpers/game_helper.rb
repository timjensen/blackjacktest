module GameHelper
  
  def check_if_bust
    if (session[:player_hand].score > 21)
    @result = "You Have Gone Bust"
    @chippy = "unlocked"
    end
  end
  
  def check_for_bj
    if (session[:player_hand].score == 21)
      @result = "Congratulations BlackJack!"
      @chippy = "unlocked"
    end
  end
  
  def find_winner
    score = session[:player_hand].score
    d_score = session[:dealer_hand].score
    bet = session[:bet].to_f
    dollars = current_user.bankroll.to_f
       
    if (score > 21)
      @result = "You Lose"
    elsif (score == d_score)
      @result = "You Push"
      dollars += bet
    elsif (d_score > 21 or (score > d_score))
      @result = "You Win!"
      dollars += (bet * 2)
    else
      @result = "You Lose"
    end
    @chippy = "unlocked"
    current_user.bankroll = dollars
    current_user.save
  end
  
end
