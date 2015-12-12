# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').on('decide-winner', @decideWinner, @)
    @get('playerHand').on('bust', @playerBust, @)
    @get('dealerHand').on('bust', @dealerBust, @)

  playerBust: ->
    alert ('Busted, dealer wins, game over! Refresh page to play again.')
    $('body').find('.hit-button').prop("disabled",true)
    $('body').find('.stand-button').prop("disabled",true)

  dealerBust: ->
    alert('Dealer busted, player wins! Refresh page to play again.')
    $('body').find('.hit-button').prop("disabled",true)
    $('body').find('.stand-button').prop("disabled",true)

  decideWinner: -> 
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]

    if playerScore > dealerScore 
      alert('Player wins! Refresh page to play again.')

    if playerScore == dealerScore 
      alert('Tie! Refresh page to play again.')

    if playerScore < dealerScore 
      alert ('Dealer wins, game over! Refresh page to play again.')
      
      
