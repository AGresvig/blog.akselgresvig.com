#Init responsive nav menu
#nav = responsiveNav(".nav-collapse", {label: ""})

#Close responsive nav on window resize if its open
#$(window).on resize: =>
#  if $('.nav-collapse.opened').length then nav.toggle()