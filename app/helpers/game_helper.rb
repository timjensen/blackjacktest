module GameHelper
  # Helper to check if player has gone bust
  def check_if_bust
    if (session[:player_hand].score > 21)
    # Set variables
    @result = "You Have Gone Bust"
    # Sets chippy variable to unlock betting
    @chippy = "unlocked"
    end
  end
  
  # Helper to check if player has hit blackjack
  def check_for_bj
    # If player hits blackJack
    if (session[:player_hand].score == 21)
      # Set bet variable using session
      bet = session[:bet].to_f
      # Set dollars variable using users bankroll
      dollars = current_user.bankroll.to_f
      # Set result variables 
      @result = "Congratulations BlackJack!"
      # Sets chippy variable to unlock betting
      @chippy = "unlocked"
      # Increase dollar variable in accordience to blackjack payout
      dollars += (bet * 3.5)
      # Update users rank roll
      current_user.bankroll = dollars
      # Save updated user
      current_user.save
    end
  end
  
  def find_winner
    # Set users score variable using session
    score = session[:player_hand].score
    # Set dealers score variable using session
    d_score = session[:dealer_hand].score
    # Set bet variable using session
    bet = session[:bet].to_f
    # Set dollars variable using users bankroll
    dollars = current_user.bankroll.to_f
    # If score is greater than 21   
    if (score > 21)
      @result = "Dealer Wins"
    # If users score matches dealers score
    elsif (score == d_score)
      @result = "Push"
      dollars += bet
    # If delaers score is greater than 21 or users score is greater than dealers score
    elsif (d_score > 21 or (score > d_score))
      @result = "You Win!"
      dollars += (bet * 2)
    else
      @result = "Dealer Wins"
    end
    @chippy = "unlocked"
    current_user.bankroll = dollars
    current_user.save
  end
  
  def deduction
    bet = session[:bet].to_f
    dollars = current_user.bankroll.to_f
    dollars -= bet
    current_user.bankroll = dollars
    current_user.save
  end
    
  def next_card
     # Set hand variable using session variable
    hand = session[:player_hand]
    # Create new card
    @card = Card.new
    # Add new card to players hand
    hand.cards << @card
    # Calculate players new hand score
    hand.score = Hand.score_of(hand)
    # Update session variable to updated hand
    session[:player_hand] = hand
  end
  
  def dealer_ftw
     # Get session hand
      dhand = session[:dealer_hand]
     # Add new cards to dealers hand untill dealers score exceeds 16
      dhand.cards << Card.new while(Hand.score_of(dhand) < 17)
     # Update dealers hand score    
      dhand.score = Hand.score_of(dhand)
      # Update session variable
      session[:dealer_hand] = dhand
  end
end
