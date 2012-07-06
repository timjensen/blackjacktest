class GameController < ApplicationController
  
  # Index action used for root
  def index
  end
  
  # Deal action called by initial 'Play' button
  def deal
    # Shuffle deck
    Card.shuffle
    
    # Players initial two cards
    hand = Hand.new
    hand.cards << Card.new << Card.new
    # Calculate score of initial hand
    hand.score = Hand.score_of(hand)
    # Set session variable for players hand
    session[:player_hand] = hand

    # Dealers initial two cards
    dhand = Hand.new
    dhand.cards << Card.new
    # Only show value of one card total value hidden from player
    dhand.score = Hand.score_of(dhand)
    dhand.cards << Card.new
    # Set session variable for dealers hand 
    session[:dealer_hand] = dhand
    
    check_for_bj
  end
  
  # Hit action called by 'Hit' button
  def hit
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

    check_if_bust
  end
  
  # Stay action called by 'Stay' button
  def stay
     dhand = session[:dealer_hand]
    
    # don't bother if the player busted or got blackjack
    if session[:player_hand].score < 21
      dhand.cards << Card.new while(Hand.score_of(dhand) < 17)
    end
    
    dhand.score = Hand.score_of(dhand)
    session[:dealer_hand] = dhand
  
    find_winner
  end
  
  def split
  end
  
  def double
  end
  
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
