#Fade in page when refreshing
if !nav then $("body").hide().fadeIn(1000)

#Init responsive nav menu
nav = responsiveNav(".nav-collapse", {label: ""})

#Close responsive nav on window resize if its open
$(window).on resize: =>
  if $('.nav-collapse.opened').length then nav.toggle()