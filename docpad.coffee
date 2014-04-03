# DocPad Configuration File
# http://docpad.org/docs/config

hl = require('highlight.js')

# Define the DocPad Configuration
docpadConfig = {
    templateData:
        site:
            # The production url of our website
            url: "http://blog.akselgresvig.com"

            # Here are some old site urls that you would like to redirect from
            oldUrls: [
                'blog.agresvig.com'
            ]

            # The default title of our website
            title: "Aksel Gresvig's blog"

            # The website description (for SEO)
            description: """
                The personal blog of developer Aksel Gresvig. A technical oriented blog on frontend, web technologies, innovation & creativity.
                """

            # The website author's name
            author: "Aksel Gresvig"

            # The website author's email
            email: "aksel@agresvig.com"

            # Author google plus profile
            googlePlus: "https://plus.google.com/+AkselGresvig/posts"

            # Your company's name
            copyright: "© AGresvig 2013"

            # Styles
            styles: [
                "/styles/vendor/normalize.css",
                "/styles/vendor/highlightjs/solarized_light.css",
                "/styles/responsive-nav.css",
                "/styles/icomoon.css",
                "/styles/vendor/initializr.css",
                "/styles/main.css",
                "/styles/fonts.css"
            ]

            # Scripts
            scripts: [
                "/vendor/jquery-1.10.1.min.js",
                "/vendor/modernizr-2.6.2-respond-1.1.0.min.js",
                "/vendor/responsive-nav.js",
                "/scripts/main.js",
                "/scripts/disqus.js",
                "/scripts/addthis.js",
                "/scripts/ga.js"
            ]

        getPreparedTitle: -> if @document.title then "#{@document.title} | #{@site.title}" else @site.title

        # Get the prepared site/document description
        getPreparedDescription: ->
            # if we have a document description, then we should use that, otherwise use the site's description
            @document.summary or @site.description

        # Get the prepared site/document keywords
        getPreparedKeywords: ->
            # Merge the document keywords with the site keywords
            @site.keywords.concat(@document.tags or []).join(', ')

        # Get the prepared site/document description
        getPreparedAuthor: ->
            # if we have a document description, then we should use that, otherwise use the site's description
            @document.author or @site.author

        getGooglePlusLink: ->
            @site.googlePlus

        getTagUrl: (tag) ->
            doc = docpad.getFile({tag:tag})
            return doc?.get('url') or ''

    collections:
        pages: ->
            @getCollection("html").findAllLive({
            relativeOutDirPath: 'pages', isPage:true})
        posts: ->
            @getCollection("html").findAllLive({relativeOutDirPath: 'posts', ignored: {$ne: true}}, [{date:-1}])

    # =================================
    # Plugin Configuration
	plugins:
        robotskirt:
            inline: (src, hash)->
                out = src

                # Twitter  link rewrites
                ##for people
                out = out.replace /(^|[ \t]+)@([a-zA-Z0-9]+)/g, (whole, m1, m2) ->
                    hash m1 + '<a href="https://twitter.com/' + m2 + '" target="_blank">@' + m2 + '</a>'

                ##for hash tag·
                out = out.replace /(^|[ \t]+)#([ㄱ-ㅎ가-힣a-zA-Z0-9]+)/g, (whole, m1, m2) ->
                    hash m1 + '<a href="https://twitter.com/search?q=%23' + m2 + '&src=hash"  target="_blank">#' + m2 + '</a>'

                return out

            #highlight.js code highlighting
            highlight: (code, lang)->
                has = lang && hl.LANGUAGES.hasOwnProperty(lang.trim())
                console.log(lang)
                open = if has then '<pre><code class="language-'+lang.trim()+'">' else '<pre><code>'
                body = if has then hl.highlight(lang, code).value else hl.highlightAuto(code).value
                close = '</code></pre>'

                return open + body + close

        thumbnails:
            imageMagick: true

        tags:
            extension: '.html'
            injectDocumentHelper: (document) ->
                document.setMeta(
                    layout: 'tags'
                    data: " "
                )
}

# Export the DocPad Configuration
module.exports = docpadConfig
