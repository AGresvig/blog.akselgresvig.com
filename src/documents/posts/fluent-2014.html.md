---
title: Fluent 2014 in retrospective
layout: post
date: 2014-03-22
tags:
    - fluent2014
    - trends
    - community
summary: "I attended O'Reilly Media's [Fluent 2014](http://fluentconf.com/fluent2014) conference at the Marriot Marquis hotel in San Francisco, California last week. I flew over with 5 web- and frontend-loving colleagues and spent the week there. It was an excellent experience - let me recap the best talks I attended."
draft: false
image: 'fluent_2014.jpeg'

---

## Javascript, VMs, the cloud, the past, present, and the future
In addition to being an excellent speaker and hilariously funny, *Scott Hanselman* from Microsoft (@shanselman) does a *great* job of explaining the cloud, VMs, the past, present and future of the web, and much more.  
I **highly** recommend watching his keynote:

<iframe width="560" height="315" src="//www.youtube.com/embed/UzyoT4DziQ4" frameborder="0" allowfullscreen></iframe>


## Isomorphic Javascript apps
by *Spike Brehm* of airbnb (@spikebrehm). (Slides not up yet).   


Spike spoke about something I think is the way of the future - building apps that can live on both the server and the client. Essentially, code your app in an isomorphic manner and it can be rendered on the server and sent to the client (giving reduced client load, among other things), or in the browser SPA-style (giving a snappier UI, among other things).<br>
Done right, this gives:

* Better performance. Faster initial page load - bootstrapping all the JS of an SPA will always take more time than rendering pure markup
* SEO - crawlable dynamic apps. SPAs aren't crawlable by default
* Maintainability - reduce code duplication

The future, according to Spike: 

     +------------------------------------+
     |Client (Javascript)                 |
     |------------------------------------|
     | DOM Manipulation                   |
     | Animation                          |
     +----------------^-------------------+
                      |
                      +
                      |
     +----------------v-------------------+
     |Shared (Javascript)                 |
     |------------------------------------|
     | Routing                            |
     | View Layer                         |
     | Application Logic                  |
     +----------------^-------------------+
                      |
                      +
                      |
     +----------------v-------------------+
     |Server (Ruby/Python/Java/PHP)       |
     |------------------------------------|
     | Persistence                        |
     +------------------------------------+

See all that shared goodness in the middle? It is isomorphic. Multi-platform.

I talked to Spike after the session and asked him a question that I didn't feel was answered properly in the talk:
Isomorphic code is great, but you'll eventually have to deploy it *somewhere*. Either it lives on the server, or on the client. A view is rendered one place, not two. So how do I know where to deploy my app?

> "It depends, right."
*- Spike* 

And I totally agree. The use-case should dictate where the various moving parts of your application lives. What is the target device? What are we showing? Collecting? That's why you write code that can run where it makes the most sense.

## Delivering the goods
> "Latency is the bottleneck for HTTP"
*- Paul Irish of Google (@paul_irish)*, in his performance-oriented keynote
 
In other words, the primary goal when optimizing web apps for performance should be to **minimize requests**. Protip from Paul: Include CSS (i.e. layout) that is critical for your **above the fold** initial view directly in the first HTML document that is sent over the wire. The goal should be to deliver something that can be rendered to the user in **the first request and make it less than 14KB**. That way, the user will in most cases see something useful on the screen in the first second, which is an important milestone.
Paul's keynote was very informative. You can [watch it here](http://www.youtube.com/embed/R8W_6xWphtw?autoplay=1).

## #FrameworkPride
Tom Dale and Yehuda Katz (@tomdale, @wycats) of *Tilde, Inc.* held a keynote on frameworks vs. libraries, focused on [Ember.JS](http://emberjs.com/). I learned a lot and got a more nuanced perspective on the whole library vs. framework debate in this talk. [Watch it here](https://www.youtube.com/watch?v=jScLjUlLTLI) if you can spare 20 mins.

> "Angular is a toolset for building your own framework. Basically this is saying you should build a custom bespoke one-of-a-lifetime framework every time you're building an app."
*- Tom*

I have spent the last couple years working on apps using Backbone and Angular which, although fundamentally different in what they provide and how they affect (or rather, don't affect) your application architecture, are both extremely flexible and complex tools for building powerful tailored SPAs. Therefore it was interesting to see the focus on simplicity and *inflexibility* that Ember provide and the reasoning behind it. Obviously, inflexibility isn't the goal, but it comes with a lot of out-of-the-box functionality, meaning that choices are made for you. So that you can focus on doing cool stuff that feels right, fast, rather than figuring out how to do the stuff everyone else has done before you. 

> "It's an API that makes doing the wrong thing feeling just as good as doing the right thing."
*- Tom* defining a maximum flexible API

I get the feeling Ember is a great framework if you just want to make a modern, best-practice, modern webapp, that will feel like other webapps. Which is the goal 90%+ of projects, anyway. If you want a lot of very custom functionality, and/or you have very specific requirements for application feel and behavior, then Angular or Backbone may suit your use case better. But keep in mind that the flexibility will cost you effort. 


## Managing Javascript complexity
by *Jarrod Overson* (@jsoverson) of Riot Games, the guys behind League of Legends.[Slides here](http://www.slideshare.net/JarrodOverson/managing-javascript-complexity-in-teams-fluent).  


In the introduction of his talk, Jarrod provided his very interesting thoughts on what the field of web development has become, and where it is going. Some excerpts:

* Dynamic languages are messy - more challenges than "regular" languages.
* The web dev. talent pool is nuts - people have used widely differing tools to build websites. 
* Oh and btw, abandon the atrocities such as the "frontend developer" term, use Web Platform Engineer instead! Who focuses *only* on the frontend anyways? If you have no clue of what goes on at the other side of the wire, you're not a very useful developer. 
* Progress in the field is difficult because *everyone* has an opinion, everyone wants to introduce something new - but the future cannot get here all at once. 
* The web is HARD. Even the giants pivot and backtrack. 
* Why are we even here? Because JS won. Flash, Java, Silverlight - all stuff generated by huge companies with a lot of money. What the hell will JS it be like in three to five years? 
* HTML5 is bullshit. Such an overloaded term.

But the core of the talk focused on what we can do to deal with complexity in large Javascript-based projects. I really recommend zapping through his slides (part 2 and 3) to see what he suggests, it makes sense even without the narrative.


## Automate all the frontend-things!
by *Kitt Hodsden*, @kitt - CodingClan LLC. [Slides here](http://cdn.oreillystatic.com/en/assets/1/event/106/Automate%20All%20the%20Front-End%20Things_%20Presentation%201.pdf).  
  
In this workshop, Kitt took us through a set of tools and utilities that can make your way of working *magical* as she put it, speeding things up and helping your web development workflow stay DRY. 

### Synchronized browser testing
The first task we automated was making sure everything works well in all browsers. Apart from the [LiveReload browser extension](http://livereload.com/) which I've used before, she introduced [BrowserSync](http://browsersync.io/) - a fantastic tool that watches your files or local dev. environments for changes, and essentially broadcasts not only file changes but also *user interaction* to **all connected browsers.** 

In practice this enables you to throw up your site on for example your laptop, iPad, and smartphone simultaneously, then click around the site on your laptop and have the other devices' browser imitate the user actions. Amazing way to cross-test your site! Both LiveReload and BrowserSync can of course be integrated with build tools like Grunt.

### Other cool stuff
She showed us the powerful [Alfred keylauncher for OSX](http://www.alfredapp.com/) (and Windows alternatives), which when supercharged with [workflow plugins](https://github.com/zenorocha/alfred-workflows/) puts all sorts of powerful workflow utilities just a couple keystrokes away. I already use Alfred and I love it, especially the [package managers](https://github.com/willfarrell/alfred-pkgman-workflow) and [encode/decode](https://github.com/willfarrell/alfred-encode-decode-workflow) plugins.

Everyone probably knows [Grunt](http://gruntjs.com/) by know, which is ironic as it's in the process of being superseded by [Gulp](http://gulpjs.com/) these days, a classic JS community move ;). Regardless, Kitt pointed out a set of very handy Grunt plugins for image optimization and generation (which we will see Gulp equivalents of very soon I am sure):

* `grunt-svgmin`  minimizes size etc. 
* `grunt-responsive-images` to retina-optimize images 
* `grunt-grunticon` will generate different size PNGs
* `grunt-montage` creates sprites to reduce number of images
* [`grunt-phantomcss`](https://github.com/chrisgladd/grunt-phantomcss) - CSS regression testing using PhantomJS. Can help you test different viewport sizes by creating screenshots. Like `grunt-photobox` kind of, but cooler.


Lastly, she showed us some ninja [SASS](http://sass-lang.com/) stuff which reminded me of how powerful SASS really is. Like media queries made easy using the `@content` tag:

```scss
    @mixin bp($point) {
      
      $bp-mobile: "(max-width: 600px)";
      $bp-notso:  "(max-width: 1250px)";
      $bp-fullon: "(max-width: 1600px)";
      
      @if $point == mq-fullon {
        @media #{$bp-fullon} { @content; }
      }
      @else if $point == mq-notso {
        @media #{$bp-notso} { @content; }
      }
      @else if $point == mq-mobile {
        @media #{$bp-mobile} { @content; }
      } 
    }
```


## Other trends and things I'll remember
* **Reactive Javascript programming** and Facebook's [React library](http://facebook.github.io/react/) - just UI rendering, done simply. SPA feel without SPA bloat. Or something like that..
* **The [MeteorJS](https://www.meteor.com/) full-stack framework**. I've been paying attention to Meteor for quite some time, but I was amazed at how quickly one can build a working app with it. It resonates with what I learned in the #FrameworkPride keynote - make choices for the developer - increase development speed. But Meteor is thinking differently about the whole webapp thing though. Watch out for this one.
* **[Promises](http://www.promisejs.org/)**. Makes code less error prone. Eliminates need to always explicitly handle error conditions. Use them. 


## In conclusion
Fluent had some technical issues initially - WiFi was pretty much useless the first day, which hurt the workshops. I find it amazing that they didn't get that right when they knew exactly how many people were coming. But I'll give 'em this - it isn't trivial to ensure bandwidth when 1000+ geeks sit down with their laptops and hit NPM with two hundred requests a minute, at the same time, all the time. There was even talk on twitter that Fluent had to apologize to GitHub for what apparently felt like a DoS attack to them.

All in all, it was a great experience and a great conference. The speakers and content really was first class. I highly recommend it. And being in San Francisco never feels wrong, especially when the temperature beats my hometown's by about 20 degrees Celsius. 

Checkout the [speaker slides and videos](http://fluentconf.com/fluent2014/public/schedule/proceedings) for plenty of informative, insightful, and funny material.

