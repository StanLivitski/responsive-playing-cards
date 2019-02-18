SVG Playing Cards
=================

tldr; Front images of SVG Playing Cards adapted from the Responsive SVG playing cards project and an XSL transformation that applies changes to the upstream card images.

LGPL licensed.

Introduction
------------
This is a deck of SVG playing cards which was created in January 2015. The upstream project was targeted specifically at Chromium, but the adapted images were tested with Firefox.

The cards are based on the deck produced by [Chris Aguilar](https://code.google.com/p/vectorized-playing-cards/), hosted over at Google Code, with the exception of the Ace of Spades, which was taken from [Byron Knoll](https://code.google.com/p/vector-playing-cards/)’s public domain cards also at Google Code.

The `cards.webapp` folder contains an XSL transformation that changes the upstream image files as follows:

 - Small version of the card image is removed.
 - Height of the image is reset using the `height` parameter that defaults
   to 318, which results in aspect ratio of the image of 1:sqrt(2).
 - The image is centered within the new canvas by applying SVG transformation
   from the `image-transform` parameter, which by default moves it down 2
   pixels.
 - White rectangular frame is replaced with a shape and style specified by
   the `frame-path-data` and `frame-style` parameters. Defaults create a
   frame with smooth corners and a thin black border.

The same folder contains all the upstream image files with the above changes applied.

What do you get?
----------------
Each card has been hand-optimized to reduce the file size as far as possible, by re-using and transforming paths. This takes the size of a normal card down from ~6.5k to about ~2.5k (~1.7k minified).  Picture cards are obviously more complex, at ~90k (~65k minified).

The original cards also had embedded media queries, which displayed a simpler layout if the card was scaled below 75px wide. That feature was removed from the images in `cards.webapp` folder.

Platforms
---------
The upstream card images are specified in SVG Tiny 1.2, and have been tested on Chrome 40, Firefox 35, Safari 8, Mobile Safari 8, Opera 11, Opera Classic for Android, Windows Phone 8.1, Internet Explorer 11 (Windows 7) and Internet Explorer 11 (Windows RT 8.1).

Bugs
----
The “mini” versions of the cards from the upstream project won’t render on Firefox for Android, Mobile Safari 6, and Android Browser 4.1, because they don’t support media queries inside SVG. But the big cards are displayed instead, so at least it fails nicely!

Credits
-------

The original cards were created by Chris Aguilar. The Ace of Spades was by Byron Knoll.<br>
They were optimized by Mike Hall with help from Warren Lockhart. The XSL transformation in `cards.webapp` folder was written and applied by Stan Livitski.

License
-------

 - LGPL 3.0 - _applies to all SVG files and examples;_
 - LGPL 3.0 or any later version published by the FSF - _applies to XSL transformation(s) in `cards.webapp` directory._
