class GameController < ApplicationController
  
  # Index action used for root
  def index
    # Set default bet amount
    session[:bet] = "25";
  end
  
  def login
    render :layout => 'login_lay'
  end
  # Deal action called by initial 'Play' button
  def deal
    # Deducted wager from bankroll as soon as deal
    bet = session[:bet].to_f
    dollars = current_user.bankroll.to_f
    dollars -= bet
    current_user.bankroll = dollars
    current_user.save
    @chippy = "locked";
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
    # Check players hand for blackjack
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
    # Check player has not gone bust
    check_if_bust
  end
  
  # Stay action called by 'Stay' button
  def stay
    # Get session hand
    dhand = session[:dealer_hand]
    # Add new cards to dealers hand untill dealers score exceeds 16
    dhand.cards << Card.new while(Hand.score_of(dhand) < 17)
    # Update dealers hand score    
    dhand.score = Hand.score_of(dhand)
    # Update session variable
    session[:dealer_hand] = dhand
    # Calculate winner
    find_winner
  end
  
  # Split and Hit will be coded once betting has been implimented
  def split
  end
  
  def double
    
    find_winner
  end
  
  def wager
    betty = params[:bet].to_f
    session[:bet] = betty
    @bet = betty
  end
  
  
end
