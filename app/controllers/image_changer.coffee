{Controller} = require 'spine'

class ImageChanger extends Controller
  sources: null

  active: NaN

  className: 'image-changer'
  template: require '../views/image_changer'

  events:
    'click button[name="toggle"]': 'onClickToggle'

  elements:
    '.images figure': 'images'
    '.toggles button': 'toggles'

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

  activate: (@active) ->
    @active = +@active %% @sources.length

    @setActiveClasses image,  i, @active for image,  i in @images
    @setActiveClasses button, i, @active for button, i in @toggles

  setActiveClasses: (el, elIndex, activeIndex) ->
    el = $(el)
    el.toggleClass 'before', +elIndex < +activeIndex
    el.toggleClass 'active', +elIndex is +activeIndex
    el.toggleClass 'after', +elIndex > +activeIndex

module.exports = ImageChanger
