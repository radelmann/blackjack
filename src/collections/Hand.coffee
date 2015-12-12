class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()

  currentScore:0

  stand: ->
    # only called for dealer
      # flip first card in collection
      # trigger game end event on view 
    @first().flip()
    #if dealer has less than 17, hit until => 17
    while (@scores()[0] < 17) 
      @hit()

    @trigger('decide-winner', @)
    

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    curscore = [@minScore(), @minScore() + 10 * @hasAce()]
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    @currentScore = curscore[0]  
    
    if (@currentScore > 21)
      @trigger('bust', @)

    curscore
