format = (->
  '%a, %B %e %Y' + '\n' +'%H:%M'
)()

#brightness 0 - 10
brightness = 0

command: "whoami;date +\"#{format}\";pmset -g batt | grep -o '[0-9]*%'"

refreshFrequency: 10000

render: (output) -> """
  <div id='terminal'>#{output}</div>
"""

update: (output) ->
    #output = "vecnehladny\nMon April 13 2020\n15:02\n70%"
    data = output.split('\n')
    
    hashCount = data[3].replace("%", '')/10
    dotCount = 10 - hashCount
    user = data[0]

    html = "<div class='wrapper'><div class='watch'><div class='bash'>#{user}@macbookpro: ~ $ now</div><div class='time'>TIME:<span class='timeData'>"
    html += data[2]
    html += "</span></div><div class='date'>DATE:<span class='dateData'>"
    html += data[1]
    html += "</span></div><div class='batt'><span>BATT:</span><span class='battData'>"
    html += "["
    for i in [0...hashCount]
      html += "#"
    for i in [0...dotCount]
      html += "."   
    html += "] "
    html += data[3]
    

    $(terminal).html(html)
  

style: (->
  return """
    font-size: 14px
    background-color: #111516;
    color: #bdaca8;
    line-height: 25px
    width: 20%
    border-style: solid;
    border-color: #bdaca8;
    border-width: 1px;
    left: 77%;
    top: 77%
    height: 20%
    white-space: nowrap;
    padding: -10%;
    box-shadow:inset 0 1px 0 rgba(255,255,255,.6), 0 22px 70px 4px rgba(0,0,0,0.56), 0 0 0 1px rgba(0, 0, 0, 0.0);
    text-shadow: 0 0 #{brightness}px rgba(255,255,255,0.8)

    #terminal
      width: 100%
      height: 100%

    .wrapper
      font-family: Menlo
      position: absolute
      width: auto
      top: 50%
      left: 50%
      transform: translate(-50%, -50%)

    .watch
      position: absolute
      top: 50%
      transform: translate(-50%, -50%)

    .bash
      font-weight: bold

    .timeData, .dateData, .battData
      margin-left: 10px

    .timeData
      color: #bdaca8
      text-shadow: 0 0 #{brightness}px rgba(0, 255, 0,1)

    .dateData
      color: #bdaca8
      text-shadow: 0 0 #{brightness}px rgba(255, 0, 255,1)

    .battData
      margin-left: 6px
      color: #bdaca8
      text-shadow: 0 0 #{brightness}px rgba(255, 0, 0,1)

  """
)()
