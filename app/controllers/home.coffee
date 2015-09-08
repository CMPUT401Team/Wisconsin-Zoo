{Controller} = require 'spine'
formatNumber =  require '../lib/format-number'
{ isDev, refreshInterval } = require '../lib/config'
Api = require 'zooniverse/lib/api'

class HomePage extends Controller
  className: 'home-page'
  template: require '../views/home_page'

  elements:
    '#user-count': 'userCount'
    '#classification-count': 'classificationCount'
    '#total-images': 'totalImages'
    '#percent-complete': 'percentComplete'

  constructor: ->
    super
    @html @template @

    @fetchProject()
    setInterval @fetchProject, REFRESH_INTERVAL

    unless isDev
      @fetchProjectStats()
      setInterval @fetchProjectStats, REFRESH_INTERVAL

  fetchProject: =>
    Api.current.get '/projects/wisconsin', (project) =>
      @userCount.html formatNumber project.user_count || 0
      @classificationCount.html formatNumber project.classification_count || 0

  fetchProjectStats: =>
    Api.current.get '/projects/wisconsin/status?status_type=subjects', (subjectStatus) =>
      total = subjectStatus.reduce (pv, cv, i, arr) ->
        pv + cv.count
      , 0

      complete = 0
      for status in subjectStatus
        continue unless status is 'complete'
        complete = status.count

      @totalImages.html formatNumber total
      @percentComplete.html "#{ Math.ceil(complete / total) * 100 }%"

module.exports = HomePage
