{Controller} = require 'spine'

class ImageChanger extends Controller
  sources: null

  active: NaN

  className: 'image-changer'
  template: require '../views/image_changer'

  interval: null
  delay: 1000

  events:
    'click button[name="toggle"]': 'onClickToggle'
    'click button[name="play"]': 'onClickPlay'
    'click button[name="pause"]': 'onClickPause'

  elements:
    '.images figure': 'images'
    '.toggles button': 'toggles'
    'button[name="play"]': 'playButton'

  constructor: ->
    super
    @sources ||= []

    @setSources @sources

  setSources: (@sources) ->
    @html @template @
    @activate 0

  onClickToggle: ({currentTarget}) =>
    selectedIndex = $(currentTarget).val()
    @activate selectedIndex

  onClickPlay: =>
    @playButton.addClass 'playing'
    @playButton.attr 'disabled', true
    @interval = window.setInterval @moveToNextImage, @delay

  onClickPause: =>
    window.clearInterval @interval
    @playButton.removeClass 'playing'
    @playButton.attr 'disabled', false
    @interval = null

  activate: (@active) ->
    @active = +@active %% @sources.length

    @setActiveClasses image,  i, @active for image,  i in @images
    @setActiveClasses button, i, @active for button, i in @toggles

  moveToNextImage: =>
    nextImage = if @sources[@active + 1]?
      nextImage = @active + 1
    else
      0

    @activate nextImage

  setActiveClasses: (el, elIndex, activeIndex) ->
    el = $(el)
    el.toggleClass 'before', +elIndex < +activeIndex
    el.toggleClass 'active', +elIndex is +activeIndex
    el.toggleClass 'after', +elIndex > +activeIndex

module.exports = ImageChanger
