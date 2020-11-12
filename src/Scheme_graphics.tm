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

  Now we will insert our commands at the prompt. We place small comments them
  within text fields inserted by choosing <menu|Insert text field below> in
  the contextual menu, while longer explanations fit better in breaks between
  sessions.

  <\framed>
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
    </session>
  </framed>

  The Scheme function <verbatim|pt> we just defined generates a TeXmacs
  graphics point parametrized by its x- and y- coordinates.

  <inactive|<point|>> is a TeXmacs graphics primitive that represents a point
  and expects two strings<todo|which types does TeXmacs expect? Maybe the
  conversion to string in Scheme is necessary only because of the subsequent
  stree-\<gtr\>tree?>. It is represented in Scheme with a list of three
  elements, the first element in the list being the symbol <verbatim|point>
  (since <verbatim|point> is a symbol, it fits well within the quasiquote
  that also defines the list).

  Using <verbatim|pt> we shall now define a few points.

  The Scheme interpreter expects one expression per prompt (evaluates only
  the first one it finds in each prompt), so we enter the expressions we need
  in separate prompts; the code in external Scheme programs is\Vof
  course\Vmore compact.

  <\framed>
    <\session|scheme|default>
      <\textput>
        First of all, coordinates for the end points of the diameter, which
        is 4 units long while the center of the circle is at the origin:
      </textput>

      <\input|Scheme] >
        (define pA (pt -2 0))
      </input>

      <\input|Scheme] >
        (define pB (pt 2 0))
      </input>

      <\textput>
        Then the third point of the triangle, on the circumference, defined
        with the help of two variables <verbatim|xC> and <verbatim|yC>:
      </textput>

      <\input|Scheme] >
        (define xC (- (* 2 (cos (/ pi 3)))))
      </input>

      <\input|Scheme] >
        (define yC (* 2 (sin (/ pi 3))))
      </input>

      <\input|Scheme] >
        (define pC (pt xC yC))
      </input>

      <\textput>
        Finally the points at which we will mark the triangle's vertices with
        letters:
      </textput>

      <\input|Scheme] >
        (define tA (pt -2.3 -0.5))
      </input>

      <\input|Scheme] >
        (define tB (pt 2.1 -0.5))
      </input>

      <\input|Scheme] >
        (define tC (pt (- xC 0.2) (+ yC 0.2)))
      </input>
    </session>
  </framed>

  \;

  <\session|scheme|default>
    <\input|Scheme] >
      (define decoration\ 

      \ \ `((with "color" "blue" \ (text-at (TeXmacs) ,(pt -0.55 -0.75)))))
    </input>

    <\input|Scheme] >
      (define semicircle\ 

      \ \ `(

      (with "color" "black" (arc ,pA ,pC ,pB))

      (with "color" "black" (line ,pA ,pB))))
    </input>

    <\input|Scheme] >
      (define triangle

      \ \ `(

      (with "color" "red" \ \ (cline ,pA ,pB ,pC))

      (with "color" "black" (text-at "A" ,tA))

      (with "color" "black" (text-at "B" ,tB))

      (with "color" "black" (text-at "C" ,tC))))
    </input>

    <\unfolded-io|Scheme] >
      (stree-\<gtr\>tree

      `(with "gr-geometry"\ 

      \ \ \ \ \ (tuple "geometry" "400px" "300px" "center")\ 

      ,(append\ 

      \ \ `(graphics)

      \ \ decoration

      \ \ semicircle

      \ \ triangle

      )))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|<graphics|<with|color|blue|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      (define (texmacsGraphics xSize ySize alignment . graphicalObjects)

      \ \ (stree-\<gtr\>tree

      `(with "gr-geometry"\ 

      \ \ \ \ \ (tuple "geometry" ,xSize ,ySize ,alignment)\ 

      ,(append\ 

      \ \ `(graphics)

      \ \ (apply append graphicalObjects)

      ))))
    </input>

    <\input|Scheme] >
      (define dec\ 

      \ \ `(with "color" "blue" \ (text-at (TeXmacs) ,(pt -0.55 -0.75))))
    </input>

    <\input|Scheme] >
      (define semic\ 

      \ \ `(

      (with "color" "black" (arc ,pA ,pC ,pB))

      (with "color" "black" (line ,pA ,pB))))
    </input>

    <\unfolded-io|Scheme] >
      (texmacsGraphics "14cm" "9cm" "center"\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ decoration\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ semicircle\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ triangle)
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|14cm|9cm|center>|<graphics|<with|color|blue|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>>>>
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (append\ 

      \ \ `(graphics)

      \ \ (apply append (list decoration semicircle triangle))

      )
    <|unfolded-io>
      (graphics (with "color" "blue" (text-at (TeXmacs) (point "-0.55"
      "-0.75"))) (with "color" "black" (arc (point "-2" "0") (point "-1.0"
      "1.73205080756888") (point "2" "0"))) (with "color" "black" (line
      (point "-2" "0") (point "2" "0"))) (with "color" "red" (cline (point
      "-2" "0") (point "2" "0") (point "-1.0" "1.73205080756888"))) (with
      "color" "black" (text-at "A" (point "-2.3" "-0.5"))) (with "color"
      "black" (text-at "B" (point "2.1" "-0.5"))) (with "color" "black"
      (text-at "C" (point "-1.2" "1.93205080756888"))))
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (apply append (list decoration semicircle triangle))
    <|unfolded-io>
      ((with "color" "blue" (text-at (TeXmacs) (point "-0.55" "-0.75")))
      (with "color" "black" (arc (point "-2" "0") (point "-1.0"
      "1.73205080756888") (point "2" "0"))) (with "color" "black" (line
      (point "-2" "0") (point "2" "0"))) (with "color" "red" (cline (point
      "-2" "0") (point "2" "0") (point "-1.0" "1.73205080756888"))) (with
      "color" "black" (text-at "A" (point "-2.3" "-0.5"))) (with "color"
      "black" (text-at "B" (point "2.1" "-0.5"))) (with "color" "black"
      (text-at "C" (point "-1.2" "1.93205080756888"))))
    </unfolded-io>

    <\unfolded-io|Scheme] >
      decoration
    <|unfolded-io>
      ((with "color" "blue" (text-at (TeXmacs) (point "-0.55" "-0.75"))))
    </unfolded-io>

    <\unfolded-io|Scheme] >
      semicircle
    <|unfolded-io>
      ((with "color" "black" (arc (point "-2" "0") (point "-1.0"
      "1.73205080756888") (point "2" "0"))) (with "color" "black" (line
      (point "-2" "0") (point "2" "0"))))
    </unfolded-io>

    <\unfolded-io|Scheme] >
      triangle
    <|unfolded-io>
      ((with "color" "red" (cline (point "-2" "0") (point "2" "0") (point
      "-1.0" "1.73205080756888"))) (with "color" "black" (text-at "A" (point
      "-2.3" "-0.5"))) (with "color" "black" (text-at "B" (point "2.1"
      "-0.5"))) (with "color" "black" (text-at "C" (point "-1.2"
      "1.93205080756888"))))
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (stree-\<gtr\>tree `(with "gr-geometry"\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (tuple "geometry" "14cm" "9cm"
      "center")\ 

      ,(append\ 

      \ \ `(graphics)

      \ \ (apply append (list decoration semicircle triangle))

      )))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|14cm|9cm|center>|<graphics|<with|color|blue|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      (define (rep . args) args)
    </input>

    <\unfolded-io|Scheme] >
      (rep 1 2 3)
    <|unfolded-io>
      (1 2 3)
    </unfolded-io>

    <\textput>
      <verbatim|graphicalObjects> are parameters each of which is a
      <strong|list> of graphical objects.

      This allows me to keep objects that consist of more than one
      \Pgraphical unit\Q together; I have then to insert inside a list also
      objects that are made of one \Pgraphical unit\Q only
    </textput>

    <\input|Scheme] >
      (define (texmacsGraphList xSize ySize alignment . graphicalObjects)

      `(with "gr-geometry" (tuple "geometry" ,xSize ,ySize ,alignment)\ 

      ,(append\ 

      \ \ `(graphics)

      \ \ (apply append graphicalObjects) ;; graphicalObjects is a list of
      lists, which we join together with apply append; and we append in front
      of the list we obtain the list consisting of the single symbol graphics

      )))
    </input>

    <\unfolded-io|Scheme] >
      (texmacsGraphList "14cm" "9cm" "center" decoration semicircle triangle)
    <|unfolded-io>
      (with "gr-geometry" (tuple "geometry" "14cm" "9cm" "center") (graphics
      (with "color" "blue" (text-at (TeXmacs) (point "-0.55" "-0.75"))) (with
      "color" "black" (arc (point "-2" "0") (point "-1.0" "1.73205080756888")
      (point "2" "0"))) (with "color" "black" (line (point "-2" "0") (point
      "2" "0"))) (with "color" "red" (cline (point "-2" "0") (point "2" "0")
      (point "-1.0" "1.73205080756888"))) (with "color" "black" (text-at "A"
      (point "-2.3" "-0.5"))) (with "color" "black" (text-at "B" (point "2.1"
      "-0.5"))) (with "color" "black" (text-at "C" (point "-1.2"
      "1.93205080756888")))))
    </unfolded-io>

    <\unfolded-io|Scheme] >
      (stree-\<gtr\>tree\ 

      \ (texmacsGraphList "14cm" "9cm" "center"\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ decoration\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ semicircle\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ triangle))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|14cm|9cm|center>|<graphics|<with|color|blue|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  In <name|Fold> <name|Executable> form:

  <\script-output|scheme|default>
    (texmacsGraphics "14cm" "9cm" "center"\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ decoration\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ semicircle\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ triangle)
  </script-output|<text|<with|gr-geometry|<tuple|geometry|14cm|9cm|center>|<graphics|<with|color|blue|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>>>>>

  A collection of TeXmacs graphical objects

  <with|gr-mode|<tuple|group-edit|edit-props>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>45|<graphics|<\document-at>
    <rotate|45|linee>

    testo

    multilinea
  </document-at|<point|3.91686187855536|2.66778808493186>>|<point|-5.81987|3.09112>|<line|<point|-5.81220898678082|1.98182238174751>|<point|-3.44152757389552|1.98182423913605>|<point|-1.79051553526607|2.5109947643378>>|<with|color|red|<cline|<point|-5.69287|0.318263>|<point|-4.06302090223575|-0.295574811483>|<point|-5.2906965207038|-0.930579441725096>|<point|-6.22203664505887|-0.761244873660537>>>|<with|color|blue|<spline|<point|-5.50236|-1.84075>|<point|-2.58134343167086|-1.58675089297526>|<point|-1.71350377033999|-0.210907527450721>|<point|-1.45950191824315|-0.295574811483>>>|<with|color|orange|fill-color|yellow|line-width|2ln|<cspline|<point|0.640072419501616|2.97694937121585>|<point|0.44063081569717|0.83552077293348>|<point|1.7500743167287|1.74000719130103>|<point|2.48612943100676|1.96478314344897>>>|<with|dash-style|zigzag|color|magenta|<arc|<point|-0.231826|-2.49692>|<point|0.382011509458923|-1.54441725095912>|<point|-0.274159941791242|-1.14224765180579>>>|<with|color|green|line-width|2ln|<carc|<point|1.3133556158222|-1.33274516920228>|<point|2.13886073951581|-2.07358797645192>|<point|3.40887|-0.888246>>>|<text-at|<rotate|45|text>text|<point|-5.5447|-3.2166>>|<math-at|<rotate|45|\<alpha\>+\<beta\>=\<gamma\>>\<alpha\>+\<beta\>=\<gamma\>|<point|-2.81418|-3.25893>>>>
</body>

<\initial>
  <\collection>
    <associate|page-screen-margin|false>
    <associate|preamble|true>
    <associate|src-compact|normal>
    <associate|src-style|functional>
  </collection>
</initial>
