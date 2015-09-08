# Used a couple of places to determine what environment the site is running in
isDev = if !!~location.host.indexOf('demo') or +location.port > 1000 then true else false

# Used to determine how often to refresh stats from the API
refreshInterval = 1000 * 60 * 5

# For when subjects have no locations. Error on my part.
defaultLocation = [
  'https://placeholdit.imgix.net/~text?txtsize=75&bg=555555&txtclr=ffffff&txt=800%C3%97500&w=800&h=500'
]

module.exports = { isDev, refreshInterval, defaultLocation }
