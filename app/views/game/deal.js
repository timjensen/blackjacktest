$("#player").html("<%= escape_javascript( render(:partial => "players_cards") ) %>");
$("#dealer").html("<%= escape_javascript( render(:partial => "dealers_cards") ) %>");