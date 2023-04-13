require 'net/http'
require 'json'

class DecksController < ApplicationController
  def shuffle
      # Get the deck ID from the URL parameter, if present
      deck_id = params[:deck_id]

      # If a deck ID is present, make a request to shuffle that deck
      # Otherwise, make a request to shuffle a new deck
      if deck_id
        url = "https://deckofcardsapi.com/api/deck/#{deck_id}/shuffle/"
      else
        url = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
      end
  
      # Make the API request
      uri = URI(url)
      response = Net::HTTP.get(uri)
  
      # Parse the JSON response and return it
      render json: JSON.parse(response)
  end

  def reshuffle
    # Get the deck ID from the URL parameter
    deck_id = params[:deck_id]

    # Make the API request to reshuffle the deck
    url = "https://deckofcardsapi.com/api/deck/#{deck_id}/shuffle/"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    # Parse the JSON response and return it
    render json: JSON.parse(response)
  end
end
