class GameController < ApplicationController
  
  # Index action used for root
  def index
  end
  
  # Deal action called by initial play button
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
  end
  
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

    # Respond to used to call hit.js
    respond_to do |format|
        format.js {}
    end
  end
end
