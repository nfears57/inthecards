require 'net/http'
require 'json'

class CardsController < ApplicationController
  def draw
    # Get the deck ID from the URL parameter
    deck_id = params[:deck_id]

    # Make the API request to draw 2 cards from the deck
    url = "https://deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=2"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    # Parse the JSON response and return it
    render json: JSON.parse(response)
  end
end

