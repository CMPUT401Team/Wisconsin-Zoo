translate = require 't7e'
enUs = require './lib/en-us'
translate.load enUs

Notifier = require './lib/notifier'

$ = window.jQuery

require 'spine'
Route = require 'spine/lib/route'
{ Stack } = require 'spine/lib/manager'

Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'

api = new Api project: 'wisconsin'

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar
topBar.el.appendTo 'body'

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.appendTo  'body'

ContentPage = require './controllers/content-page'
stack = new Stack
  className: "main #{Stack::className}"

  controllers:
    home: require './controllers/home'
    classify: require './controllers/classifier'
    science: (class extends ContentPage then template: require './views/science')
    education: (class extends ContentPage then template: require './views/education')
    team: (class extends ContentPage then template: require './views/team')
    profile: require './controllers/profile'

  routes:
    '/': 'home'
    '/classify': 'classify'
    '/science': 'science'
    '/education': 'education'
    '/team': 'team'
    '/profile': 'profile'

  default: 'home'

stack.el.appendTo  'body'

Footer = require 'zooniverse/controllers/footer'
footer = new Footer
siteFooter = $('<div class="site-footer"></div>').append footer.el
siteFooter.appendTo 'body'

Notifier.init()
Route.setup()
User.fetch()

window.app = { stack, api }
