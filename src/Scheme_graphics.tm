<TeXmacs|1.99.14>

<style|<tuple|notes|old-lengths>>

<\body>
  Let us generate a drawing with TeXmacs graphic primitives using Scheme. In
  this note, we assume that the reader is familiar with simple Scheme syntax.
  Two possible web sources for learning Scheme are the Wikipedia book
  <hlink|Scheme programming|https://en.wikibooks.org/wiki/Scheme_Programming>
  and <hlink|Yet Another Scheme Tutorial|http://www.shido.info/lisp/idx_scm_e.html>
  by Takafumi Shido.

  We want to draw a triangle inscribed inside a semicircle, mark its vertices
  with letters and decorate the drawing with the text <TeXmacs>.

  The most comfortable way of generating a drawing is in a Scheme session, so
  that is the first way we'll take. Once we have our graphics through a
  Scheme session, we'll see as well how to blend it in a document.

  The first step is opening the session, with
  <menu|Insert-\<gtr\>Session-\<gtr\>Scheme>. It is convenient to select
  <menu|Program bracket matching> in the preferences box under
  <menu|Edit-\<gtr\>Preferences-\<gtr\>Other>; this helps coding in Scheme by
  highlighting the parenthesis that matches the one next to the cursor.

  Now we will insert our commands at the prompt and comment them within text
  fields inserted by choosing <menu|Insert text field below> in the
  contextual menu.

  <\session|scheme|default>
    <\input|Scheme] >
      (define pi (acos -1))
    </input>

    <\textput>
      We will work with a circle so we need \<pi\>!
    </textput>

    <\input|Scheme] >
      (define (pt x y)

      \ \ `(point ,(number-\<gtr\>string x) ,(number-\<gtr\>string y)))
    </input>

    <\textput>
      We have defined a TeXmacs graphics point as a function of its x- and y-
      coordinates.

      <inactive|<point|>> is a TeXmacs graphics primitive that represents a
      point and expects two strings<todo|which types does TeXmacs expect?
      Maybe the conversion to string in Scheme is necessary only because of
      the subsequent stree-\<gtr\>tree?>. It is represented in Scheme with a
      list of three elements the first one of which is the symbol
      <verbatim|point> (since <verbatim|point> is a symbol, it fits well
      within the quasiquote that also defines the list).

      Now we shall define a few points.

      The Scheme interpreter expects one expression per prompt (evaluates
      only the first one it finds in each prompt), so we enter the
      expressions we need in separate prompts; the code in external Scheme
      programs is\Vof course\Vmore compact.

      First of all, coordinates for the end points of the diameter, which is
      4 units long while the center of the circle is at the origin:
    </textput>

    <\input|Scheme] >
      (define pA (pt -2 0))
    </input>

    <\input|Scheme] >
      (define pB (pt 2 0))
    </input>

    <\input|Scheme] >
      (define xC (- (* 2 (cos (/ pi 3)))))
    </input>

    <\input|Scheme] >
      (define yC (* 2 (sin (/ pi 3))))
    </input>

    <\input|Scheme] >
      (define pC (pt xC yC))
    </input>

    <\input|Scheme] >
      (define tA (pt -2.3 -0.5))
    </input>

    <\input|Scheme] >
      (define tB (pt 2.1 -0.5))
    </input>

    <\input|Scheme] >
      (define tC (pt (- xC 0.2) (+ yC 0.2)))
    </input>

    <\textput>
      \;
    </textput>
  </session>

  <\session|scheme|default>
    <\input|Scheme] >
      (define (pt x y) `(point ,(number-\<gtr\>string x)
      ,(number-\<gtr\>string y)))
    </input>

    <\input|Scheme] >
      (define (shiftX p deltaX)

      \ \ (pt (+ (coordX p) deltaX) (coordY p)))
    </input>

    <\input|Scheme] >
      (define (shiftY p deltaY)

      \ \ (pt (coordX p) \ (+(coordY p) deltaY)))
    </input>

    <\input|Scheme] >
      (define (shift p vct)

      \ \ (shiftY (shiftX p (car vct)) (cadr vct)))
    </input>

    <\input|Scheme] >
      (define (diagram p1A p1B p2A p2B p3A p3B)

      \ \ `( \ 

      (with\ 

      \ \ \ \ "color" "blue"\ 

      \ \ "line-width" "2ln"

      \ \ "arrow-end" "\|\<less\>gtr\<gtr\>"

      \ \ (line ,p1A ,p1B))

      (with\ 

      \ \ \ \ "color" "blue"

      \ \ "line-width" "2ln"

      \ \ "arrow-end" "\|\<less\>gtr\<gtr\>"

      \ \ (line ,p2A ,p2B))

      (with\ 

      \ \ \ \ "color" "red"

      \ \ "line-width" "2ln"\ 

      \ \ "dash-style" "11100"

      \ \ "arrow-end" "\|\<less\>gtr\<gtr\>"

      \ \ (line ,p3A ,p3B))))
    </input>

    <\input|Scheme] >
      (define (dgrPoints start vStart vEnd shft)

      \ \ (let*

      \ \ \ \ \ \ (

      (p1A (pt (car start) (cadr start)))

      \ \ (p1B (shift p1A vStart))

      \ \ (p2A (shiftX p1A shft))

      \ \ (p2B (shift p2A vEnd))

      \ \ (p3A (shiftX p1B (/ shft 2)))

      \ \ (p3B (shiftX p2B (* -1 (/ shft 2)))))

      \ \ \ \ (diagram p1A p1B p2A p2B p3A p3B)))
    </input>

    <\unfolded-io|Scheme] >
      (stree-\<gtr\>tree

      `(with "gr-geometry" (tuple "geometry" "14cm" "9cm" "center") \ \ 

      ,(append\ 

      \ \ `(graphics)

      \ \ (dgrPoints `(-4 0) `(0 -2) `(0 -4) .4)

      \ \ (dgrPoints `(4 0) `(0 1) `(0 -1) .4)

      \ \ (dgrPoints `(0 0) `(0 4) `(0 2) .4)

      )))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|14cm|9cm|center>|<graphics|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|-4|0>|<point|-4|-2>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|-3.6|0>|<point|-3.6|-4>>>|<with|color|red|line-width|2ln|dash-style|11100|arrow-end|\|\<gtr\>|<line|<point|-3.8|-2>|<point|-3.8|-4>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|4|0>|<point|4|1>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|4.4|0>|<point|4.4|-1>>>|<with|color|red|line-width|2ln|dash-style|11100|arrow-end|\|\<gtr\>|<line|<point|4.2|1>|<point|4.2|-1>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|0|0>|<point|0|4>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|0.4|0>|<point|0.4|2>>>|<with|color|red|line-width|2ln|dash-style|11100|arrow-end|\|\<gtr\>|<line|<point|0.2|4>|<point|0.2|2>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <\script-output|scheme|default>
    (stree-\<gtr\>tree

    `(with "gr-geometry" (tuple "geometry" "14cm" "9cm" "center") \ \ 

    ,(append\ 

    \ \ `(graphics)

    \ \ (dgrPoints `(-4 0) `(0 -2) `(0 -4) .4)

    \ \ (dgrPoints `(4 0) `(0 1) `(0 -1) .4)

    \ \ (dgrPoints `(0 0) `(0 4) `(0 2) .4)

    )))
  </script-output|<text|<with|gr-geometry|<tuple|geometry|14cm|9cm|center>|<graphics|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|-4|0>|<point|-4|-2>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|-3.6|0>|<point|-3.6|-4>>>|<with|color|red|line-width|2ln|dash-style|11100|arrow-end|\|\<gtr\>|<line|<point|-3.8|-2>|<point|-3.8|-4>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|4|0>|<point|4|1>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|4.4|0>|<point|4.4|-1>>>|<with|color|red|line-width|2ln|dash-style|11100|arrow-end|\|\<gtr\>|<line|<point|4.2|1>|<point|4.2|-1>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|0|0>|<point|0|4>>>|<with|color|blue|line-width|2ln|arrow-end|\|\<gtr\>|<line|<point|0.4|0>|<point|0.4|2>>>|<with|color|red|line-width|2ln|dash-style|11100|arrow-end|\|\<gtr\>|<line|<point|0.2|4>|<point|0.2|2>>>>>>>

  <with|gr-mode|<tuple|group-edit|move>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>45|<graphics|<\document-at>
    <rotate|45|linee>

    testo

    multilinea
  </document-at|<point|3.91686187855536|2.66778808493186>>|<point|-5.81987|3.09112>|<line|<point|-6.1162|1.99044>|<point|-3.7455185871147|1.99044185738854>|<point|-2.09450654848525|2.51961238259029>>|<cline|<point|-5.69287|0.318263>|<point|-4.06302090223575|-0.295574811483>|<point|-5.2906965207038|-0.930579441725096>|<point|-6.22203664505887|-0.761244873660537>>|<spline|<point|-5.50236|-1.84075>|<point|-2.58134343167086|-1.58675089297526>|<point|-1.71350377033999|-0.210907527450721>|<point|-1.45950191824315|-0.295574811483>>|<cspline|<point|0.640072419501616|2.97694937121585>|<point|0.44063081569717|0.83552077293348>|<point|1.7500743167287|1.74000719130103>|<point|2.48612943100676|1.96478314344897>>|<arc|<point|-0.231826|-2.49692>|<point|0.382011509458923|-1.54441725095912>|<point|-0.274159941791242|-1.14224765180579>>|<carc|<point|1.3133556158222|-1.33274516920228>|<point|2.13886073951581|-2.07358797645192>|<point|3.40887|-0.888246>>|<text-at|<rotate|45|text>text|<point|-5.5447|-3.2166>>|<math-at|<rotate|45|\<alpha\>+\<beta\>=\<gamma\>>\<alpha\>+\<beta\>=\<gamma\>|<point|-2.81418|-3.25893>>>>
</body>

<\initial>
  <\collection>
    <associate|page-screen-margin|false>
    <associate|preamble|false>
    <associate|src-compact|normal>
    <associate|src-style|functional>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|?|?|../../../../../../../media/giovanni/Windows
    - Data/Varie/Lezioni di Fisica - ETess/2020-04-23/2020-04-24
    esercizi/2020-04-24 esercizi inviati da Eleonora/diagrammi_caduta.tm>>
    <associate|auto-2|<tuple|?|?|../../../../../../../media/giovanni/Windows
    - Data/Varie/Lezioni di Fisica - ETess/2020-04-23/2020-04-24
    esercizi/2020-04-24 esercizi inviati da Eleonora/diagrammi_caduta.tm>>
    <associate|auto-3|<tuple|?|?|../../../../../../../media/giovanni/Windows
    - Data/Varie/Lezioni di Fisica - ETess/2020-04-23/2020-04-24
    esercizi/2020-04-24 esercizi inviati da Eleonora/diagrammi_caduta.tm>>
    <associate|auto-4|<tuple|?|?|../../../../../../../media/giovanni/Windows
    - Data/Varie/Lezioni di Fisica - ETess/2020-04-23/2020-04-24
    esercizi/2020-04-24 esercizi inviati da Eleonora/diagrammi_caduta.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|idx>
      <tuple|<tuple|<with|font-family|<quote|ss>|Insert-\<gtr\>Session-\<gtr\>Scheme>>|<pageref|auto-1>>

      <tuple|<tuple|<with|font-family|<quote|ss>|Program bracket
      matching>>|<pageref|auto-2>>

      <tuple|<tuple|<with|font-family|<quote|ss>|Edit-\<gtr\>Preferences-\<gtr\>Other>>|<pageref|auto-3>>

      <tuple|<tuple|<with|font-family|<quote|ss>|Insert text field
      below>>|<pageref|auto-4>>
    </associate>
  </collection>
</auxiliary>