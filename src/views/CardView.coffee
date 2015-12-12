class window.CardView extends Backbone.View

  el:'<img class="card" />'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    #@$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    
    rank = @model.get('rankName')
    suit = @model.get('suitName')

    if @model.get 'revealed'
      @$el.attr('src', 'img/cards/' + rank + '-' + suit + '.png')
    else 
      @$el.attr('src', 'img/card-back.png')


#'<img src="img/cards/<%= rankName %>-<%= suitName %>.png"/>'/