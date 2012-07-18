class GameController < ApplicationController
  
  # Index action used for root
  def index
    # Set default bet amount
    session[:bet] = "25";
    # Use koala and facebook query language to select current users friends who use this app
    friends = current_user.facebook.fql_query("SELECT uid FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")
    # Makes a tidy array of user ids
    uids = friends.collect { |f| f["uid"]}
    # Create variable array of friends player the app
    @friends = User.where(:uid => uids)
    # Paginates friends variable
    @friends = @friends.page(params[:page]).per_page(5)
    # Temp fix to people loggin out of face book and then refreshing page
  rescue Koala::Facebook::APIError => e
    redirect_to root_path
  end
  
  # Login action renders initial login page
  def login
    render :layout => 'login_lay'
  end
  
  # Deal action called by initial 'Play' button
  def deal
    # Check if player has enough money in there bankroll
    if got_the_dollars?
      # Deducted wager from bankroll as soon as deal
      deduction
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
      # Sets chippy variable (which locks betting amount links till hand is complete)
      @chippy = "locked"
    else
      @warning = "Your wallet is lacking the funds!!"
    end
  end
  
  # Hit action called by 'Hit' button
  def hit
    # Produces next card and adds it to players hand
    next_card
    # Set third (removes double button)
    set_third
    # Check player has not gone bust
    check_if_bust
  end
  
  # Stay action called by 'Stay' button
  def stay
    dealer_ftw
    # Calculate winner
    find_winner
  end
  
  # Split is the next feature to be coded
  def split
  end
  
  # Double 
  def double
    if got_the_dollars?
      deduction
      session[:bet] = session[:bet].to_f * 2
      next_card
      # Check if player has hone bust
      check_if_bust
      if (defined?(@result)).nil?
        dealer_ftw
        # Calculate winner
        find_winner
      end
      session[:bet] = session[:bet].to_f / 2
    else
      @warning = "Your wallet is lacking the funds!!"
    end
  end
  
  def wager
    betty = params[:bet].to_f
    session[:bet] = betty
    @bet = betty
  end
  
  def topup
    start = current_user.bankroll.to_f 
    finish = start + 500
    current_user.bankroll = finish
    current_user.save
  end
  
end
