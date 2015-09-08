# Used a couple of places to determine what environment the site is running in
isDev = if !!~location.host.indexOf('demo') or +location.port > 1000 then true else false

# Used to determine how often to refresh stats from the API
refreshInterval = 1000 * 60 * 5

module.exports = { isDev, refreshInterval }
