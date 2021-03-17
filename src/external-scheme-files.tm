<TeXmacs|1.99.19>

<style|<tuple|notes|framed-session>>

<\body>
  <\hide-preamble>
    <assign|graphics-functions|(notes external-scheme-files scheme-graphics)>

    <assign|geometrical-transformation-functions|(notes external-scheme-files
    geometrical-transformations)>

    <assign|object-customization-functions|(notes external-scheme-files
    object-customization)>

    <assign|basic-objects|(notes external-scheme-files basic-objects)>

    <use-module|<value|graphics-functions>>

    <use-module|<value|geometrical-transformation-functions>>

    <use-module|<value|object-customization-functions>>

    <use-module|<value|basic-objects>>

    <assign|scheme-guide|<hlink|<name|Scheme>
    guide|http://www.texmacs.org/tmweb/documents/manuals/texmacs-scheme.en.pdf>>
  </hide-preamble>

  <notes-header>

  <chapter*|<name|Scheme> graphics with external files>

  <todo|See test-parsing-points.tm in <verbatim|/home/giovanni/test/test
  TeXmacs/4 - Wiki/Working files/>>

  <todo|can I link to the online manual in the html and to the local help
  files in the .tm file? If so, I have to review the document for all links
  to the \ <hlink|<TeXmacs> <scheme> developer
  guide|http://www.texmacs.org/tmweb/documents/manuals/texmacs-scheme.en.pdf>>

  <todo|Do I need a small discussion of the organization of Scheme within
  TeXmacs or do I refer to the developer guide? If the second, then I need to
  say it in the post (together with an extremely synthetic description, i.e.
  \PWhen and how to use Scheme\Q and \PGeneral architecture of the Scheme
  API\Q>

  <todo|indicate that one needs to close TeXmacs and open it again to update
  the Scheme code>

  <todo|indicate post on methods to help developing scheme modules:
  http://forum.texmacs.cn/t/are-there-any-good-methods-to-help-developing-scheme-modules/211/4>

  <\itemize>
    <item>Explain that I am re-using the examples of <hlink|Modular graphics
    with <name|Scheme>|./modular-scheme-graphics.tm> but without re-building
    them step-by-step.

    <item>a function for loading a drawing from a file (probably not, use
    <scm|load> directly)

    <item>Introduce the <scm|:secure> keyword. Do I have to use it? How is it
    working now? 2021-03-17 I have the security set to \Pprompt on script\Q.
    Does it affect only what I can call from a macro and not what i can call
    from Scheme?

    <item>cite the developer's guide \Pappropriately\Q

    <item>(done) introduce abbreviation <value|scheme-guide>

    <item>is <scm|:use> transitive? (it seems so, and that transitive
    importation is possible)

    <\itemize>
      <item>A file sees the functions defined with <scm|tm-define> in the
      modules that it <scm|:use>s, and only them, but these are seen
      transitively

      <item>If transitive import is possible, that is not good, as the
      symbols for hlper functions will be visible in <TeXmacs> documents. I
      have to make it clear in this post (as a small advantage, I can import
      multiple libraries with one <markup|use-modules> command only).

      <item>I have to inform myself on what are the plans on the topic and
      write the blog post
    </itemize>

    <item>organize the \Phyerarchy\Q of functions and import them in the
    document

    <item>explain that we change \Pimports\Q in mid blog post (2021-03-17 in
    the document I change the file and then after having finished section
    <reference|sec:a-few-functions> import separately each module that I want
    to use; I need to talk to JvdH about this) (so the functions up to a
    point int he blog post work with the first import, and after that they
    work with the new import)

    <item>rewrite the post without using environment variables to store the
    modules' names

    <item>Look at <verbatim|test-parsing-points.tm> in the folder
    <verbatim|Working files> to see how we defined the <scm|pt> functions and
    what is the effect of <scm|number-\<gtr\>string> in this context

    <item>put the final example in a executable switch and suggest that
    everything can go into an external file (so one can use emacs with
    paredit for example)

    <\itemize>
      <item>the emacs mode for TeXmacs, <scm|tm-mode>, which is in my
      <verbatim|.emacs> file
    </itemize>
  </itemize>

  This post is a part of a series of <name|Scheme> graphics in <TeXmacs>.
  Other posts in the same series are <hlink|Composing <TeXmacs> graphics with
  <name|Scheme>|./scheme-graphics.tm>, <hlink|Embedding graphics composed
  with <name|Scheme> into documents|./scheme-graphics-embedding.tm> and
  <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm>.

  In this post, we describe how to place the graphical functions we defined
  in the previous posts in <name|Scheme> files and make them available inside
  <TeXmacs> documents; our descriptions repeats the concepts presented in the
  <hlink|<TeXmacs> manual|http://www.texmacs.org/tmweb/documents/manuals/texmacs-manual.en.pdf>
  <todo|do I use concepts described the TeXmacs manual or only in the Scheme
  guide?> and <hlink|<TeXmacs> <name|Scheme> developer
  guide|http://www.texmacs.org/tmweb/documents/manuals/texmacs-scheme.en.pdf>
  (indicated as <value|scheme-guide> from now on, \ describes how to control
  and extend <TeXmacs> through <scheme><todo|improve this text in
  parentheses>) putting them in the context of our graphics example.

  We are going to use the modules system in <verbatim|progs>, and leave aside
  the plugin functionality. Our aim is to have <name|Scheme> forms available
  inside our <TeXmacs> document; we will be able to use them inside macros,
  with the <markup|extern> tag, by clicking on text,<todo|is \Pwith the
  action tag\Q part of the preceding case \Pby clicking on text\Q?> with the
  <markup|action> tag, inside <name|Executable fold> environments (a way to
  embed graphics in documents) or in <name|Scheme> sessions.

  Like in the other posts of the series, we assume that the reader is
  familiar with simple Scheme syntax. We link again to the <name|Wikipedia>
  book <hlink|Scheme programming|https://en.wikibooks.org/wiki/Scheme_Programming>
  and to <hlink|Yet Another Scheme Tutorial|http://www.shido.info/lisp/idx_scm_e.html>
  by Takafumi Shido as two possible web resources for learning <name|Scheme>.

  This post is accompanied by the <name|Scheme> source files <todo|complete>
  in the <verbatim|resources> directory<todo|complete>. To be able to run the
  examples of this post on your computer, you will have to download the
  <name|Scheme> source files <todo|complete> and place them <todo|complete>;
  the location is controlled through the <markup|use-module> macro that is in
  the preamble of the present files, and that I have set to
  <scm|<value|graphics-functions>><todo|defined with a variable to make it
  easy to modify it both here and in use-module; turn to a file path (use
  verbatim tag)>; the <TeXmacs> command is

  <inactive|<use-module|<value|graphics-functions>>>.

  \ The manual placement of <name|Scheme> files is necessary as I did not
  find a way to make the <name|Scheme> files automatically available at the
  download of this file; their location is specified in <TeXmacs> relative to
  the user's <verbatim|prog> directory, and I did not find a way to specify
  their location relative to the location of the file one is editing. If you
  place the files in a different folder, please adjust correspondingly both
  the path in the <markup|use-module> macro and inside the <scheme> file
  itself in the instruction that declares its name and possibly imports
  additional dependencies (more details later)<todo|link to details?>.

  <todo|perhaps here say that I will reuse the code of <hlink|Modular
  graphics with <name|Scheme>|./modular-scheme-graphics.tm> in a shortened
  way>

  <section|A few initial functions - composing complex
  objects><label|sec:a-few-functions>

  We start from the symbols (functions and variables) we developed in the
  post <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm>.
  Let us list them together with a short description; next to each we note
  whether it serves as a building block for other symbols (\Paux\Q for
  auxiliary) or it is meant for graphics compositions by users (\Pusers\Q).

  <\big-table|<tabular|<tformat|<cwith|1|-1|3|3|cell-hyphen|t>|<cwith|1|-1|3|3|cell-hmode|min>|<cwith|1|-1|3|3|cell-hpart|>|<cwith|1|-1|1|-1|cell-bsep|2sep>|<cwith|1|-1|1|-1|cell-tsep|2sep>|<cwith|1|1|1|-1|cell-tborder|1ln>|<cwith|1|1|1|-1|cell-bborder|1ln>|<cwith|2|2|1|-1|cell-tborder|1ln>|<cwith|1|1|1|1|cell-lborder|0ln>|<cwith|1|1|3|3|cell-rborder|0ln>|<cwith|1|1|1|-1|cell-bsep|3sep>|<cwith|1|1|1|-1|cell-tsep|5sep>|<cwith|1|1|1|-1|cell-rsep|1spc>|<cwith|1|-1|1|1|cell-lsep|0spc>|<cwith|1|-1|3|3|cell-rsep|0spc>|<cwith|1|-1|3|3|cell-width|0.5par>|<cwith|1|1|1|-1|cell-halign|c>|<table|<row|<cell|<strong|Function>>|<cell|<strong|Purpose>>|<\cell>
    <strong|Description>
  </cell>>|<row|<cell|<scm|objects-list>>|<cell|aux>|<\cell>
    a list of native graphical objects
  </cell>>|<row|<cell|<scm|object-test>>|<cell|aux>|<\cell>
    tests whether a symbol is a native graphical object\ 
  </cell>>|<row|<cell|<scm|denest-test>>|<cell|aux>|<\cell>
    tests whether flattening must stop (at a native graphical object or at a
    <scm|with> form)
  </cell>>|<row|<cell|<scm|denestify-conditional>>|<cell|aux>|<\cell>
    turns a nested list of graphical objects into a flat one
  </cell>>|<row|<cell|<scm|pt>>|<cell|user>|<\cell>
    defines a <scm|point> graphical object through its coordinates
  </cell>>|<row|<cell|<scm|pi>>|<cell|user>|<\cell>
    <math|\<pi\>>
  </cell>>|<row|<cell|<scm|scheme-graphics>>|<cell|user>|<\cell>
    composes a graphics list, applies to it default properties and turns it
    into a <TeXmacs> tree.
  </cell>>|<row|<cell|<scm|translate-point>>|<cell|aux>|<\cell>
    translates a point
  </cell>>|<row|<cell|<scm|translate-element>>|<cell|user>|<\cell>
    translates any graphical object (either native or list)
  </cell>>|<row|<cell|<scm|apply-property>>|<cell|user>|<\cell>
    applies a property to a graphical object or to all objects in a graphical
    list
  </cell>>>>>>
    The <name|Scheme> functions for modular graphics we defined in
    <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm>
  </big-table>

  We write up an initial file with the first few functions, enough to draw
  the first example of <hlink|Modular graphics with
  <name|Scheme>|./modular-scheme-graphics.tm>, which is a triangle.

  Our <verbatim|scheme-graphics.scm> files contains (following code
  block<todo|switch to captioned and numbered code blocks>) the <scm|pt> and
  <scm|scheme-graphics> functions together with the symbol <scm|pi> and
  helper functions (not accessible to the <TeXmacs> document)
  <scm|objects-list>, <scm|object-test>, <scm|denest-test>, and
  <scm|denestify-conditional>:<todo|place the function for gaphic composition
  at the top>

  <\scm-code>
    (texmacs-module (notes external-scheme-files scheme-graphics))

    \;

    ;;; =====================

    ;;; mathematical constants

    \;

    (tm-define (define pi (acos -1)))

    \;

    ;;; ================================

    ;;; define a point using two numbers

    \;

    ;; exact-\<gtr\>inexact transforms fractions into floats yielding strings
    that are

    ;; parsed correctly by TeXmacs

    (tm-define (pt x y)

    \ \ `(point ,(number-\<gtr\>string (exact-\<gtr\>inexact x))
    ,(number-\<gtr\>string (exact-\<gtr\>inexact y))))

    \;

    ;;; ====================

    ;;; flattening functions

    \;

    (define objects-list\ 

    \ \ '(point line cline spline arc carc text-at math-at document-at))

    \;

    (define (object-test expr) \ \ 

    \ \ (not (equal?\ 

    \ \ \ \ \ \ \ \ (filter (lambda (x) (equal? x expr)) objects-list)

    \ \ \ \ \ \ \ \ '())))

    \;

    (define (denest-test expr)

    \ \ (or

    \ \ \ (object-test expr)

    \ \ \ (equal? expr 'with)))

    \;

    ;; start from the answer https://stackoverflow.com/a/33338401\ 

    ;; to the Stack Overflow question

    ;; https://stackoverflow.com/q/33338078/flattening-a-list-in-scheme

    \;

    ;;(define (denestify lst)

    ;; \ (cond ((null? lst) '())

    ;; \ \ \ \ \ \ \ ((pair? (car lst))

    ;; \ \ \ \ \ \ \ \ (append (denestify (car lst))

    ;; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify (cdr lst))))

    ;; \ \ \ \ \ \ \ (else (cons (car lst) (denestify (cdr lst))))))

    \;

    ;; This function is not tail-recursive;\ 

    ;; see https://stackoverflow.com/a/33338608

    ;; for a tail-recursive function

    (define (denestify-conditional lst)

    \ \ (cond ((null? lst) '())

    \ \ \ \ \ \ \ \ ((pair? (car lst))

    \ \ \ \ \ \ \ \ \ ;; If the car of (car lst) is 'with or another

    \ \ \ \ \ \ \ \ \ ;; of the symbols in denest-test, we cons it

    \ \ \ \ \ \ \ \ \ (if (denest-test (car (car lst)))

    \ \ \ \ \ \ \ \ \ \ \ \ \ (cons (car lst)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify-conditional (cdr lst)))

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; otherwise we flatten it with recursion,

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; obtaining a flat list, and append it to

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; the flattened rest of the list, in this

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; way flattening the combination of the

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; two lists

    \ \ \ \ \ \ \ \ \ \ \ \ \ (append (denestify-conditional (car lst))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify-conditional (cdr
    lst)))))

    \ \ \ \ \ \ \ \ ;; (car lst) is an atom

    \ \ \ \ \ \ \ \ (else (if (denest-test (car lst))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; test presence of (car lst) in the
    list

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; of symbols that stop
    denestification

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ lst ;; we leave lst as it is

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; otherwise we cons (car lst) onto
    the

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; flattened version of (cdr lst)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (cons (car lst)\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify-conditional\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (cdr lst)))))))

    \;

    ;;; ====================

    ;;; function for graphic composition

    \;

    (tm-define (scheme-graphics x-size y-size alignment graphics-list)

    \ \ (stree-\<gtr\>tree

    \ \ \ `(with "gr-geometry"\ 

    \ \ \ \ \ \ \ \ (tuple "geometry" ,x-size ,y-size ,alignment)

    \ \ \ \ \ \ \ \ "font-shape" "italic"

    \ \ \ \ \ \ \ \ ,(denestify-conditional\ 

    \ \ \ \ \ \ \ \ \ \ \ \ `(graphics ,graphics-list)))))
  </scm-code>

  The file\V which is a <TeXmacs> module<todo|introduce in a more \Pupfront\Q
  way the concept of modules>\Vstarts (<hlink|<TeXmacs> <scheme> developer
  guide|http://www.texmacs.org/tmweb/documents/manuals/texmacs-scheme.en.pdf>
  section 1.4) with the <scm|texmacs-module> form that allows <TeXmacs> to
  locate the code <todo|does it do that?> and optionally allows inclusion of
  other code (so implementing a modular system). The argument of the
  <scm|texmacs-module> form is a list which corresponds to the location of
  the corresponding le<todo|these words are copied from the developer
  guide>, starting from the <TeXmacs> user home directory <todo|why
  $<math|TEXMACS_HOME_PATH> is not defined in bash and yet it works? There
  are several possible paths TeXmacs is looking the files in, see sect 1.4>.

  There are two variations of the <scm|define> form in <TeXmacs>: the
  standard <scm|define>, which makes functions and variables available within
  one module, and <scm|tm-define> which makes them available to the calling
  modules <todo|do I have to qualify like in the guide, telling that with the
  current implementation tm-define makes function globally available?> and to
  <TeXmacs> documents in this case.

  We have now the <scm|pt> and <scm|scheme-graphics> functions and we use
  them to compose the \Ptriangle\Q example of <hlink|Modular graphics with
  <name|Scheme>|./modular-scheme-graphics.tm> in a <scheme> session; please
  refer to that post for a step-by-step discussion of the code.

  <\session|scheme|default>
    <\textput>
      Define points for composing the drawing (using the <scm|pt> function)
    </textput>

    <\input|Scheme] >
      (begin

      \ \ (define pA (pt -2 0))

      \ \ (define pB (pt 2 0))

      \ \ (define xC (- (* 2 (cos (/ pi 3)))))

      \ \ (define yC (* 2 (sin (/ pi 3))))

      \ \ (define pC (pt xC yC))

      \ \ (define tA (pt -2.3 -0.5))

      \ \ (define tB (pt 2.1 -0.5))

      \ \ (define tC (pt (- xC 0.2) (+ yC 0.2))))
    </input>

    <\textput>
      Use the points to build up the graphics objects (lists which are
      parsable by \ <scm|denestify-conditional>)\ 
    </textput>

    <\input|Scheme] >
      (begin

      \ \ (define triangle

      \ \ \ \ `(with "color" "red" "line-width" "1pt"

      \ \ \ \ \ \ \ \ \ \ \ (cline ,pA ,pB ,pC)))

      \ \ (define half-circle

      \ \ \ \ `((with "color" "black" (arc ,pA ,pC ,pB))

      \ \ \ \ \ \ (with "color" "black" (line ,pA ,pB))))

      \ \ (define letters\ 

      \ \ \ \ `((with "color" "black" \ (text-at "A" ,tA))

      \ \ \ \ \ \ (with "color" "black" \ (text-at "B" ,tB))

      \ \ \ \ \ \ (with "color" "black" \ (text-at "C" ,tC))))

      \ \ (define caption

      \ \ \ \ `((with "color" "blue" "font-shape" "upright"

      \ \ \ \ \ \ \ \ \ \ \ \ (text-at (TeXmacs) ,(pt -0.55 -0.75))))))
    </input>

    <\textput>
      Finally apply <scm|scheme-graphics> to show the drawing
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center"\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ `(,half-circle

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,triangle

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,letters

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,caption))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <todo|explain that up to here it works with the first import, and from now
  on we need to add imports, as described in the next section>

  <section|Organizing one's own <scheme> files (modularization)>

  The functions we wrote in <hlink|Modular graphics with
  <name|Scheme>|./modular-scheme-graphics.tm> can be grouped in a few
  categories: inserting a <TeXmacs> graphics in a drawing
  (<scm|scheme-graphics>), processing <TeXmacs> graphics (<scm|objects-list>,
  <scm|object-test>, <scm|denest-test>, and <scm|denestify-conditional>),
  \ basic graphics object (<scm|pt>), basic mathematical objects (<scm|pi>),
  geometrical transformations of objects (<scm|translate-point> and
  <scm|translate-element>) and object customization (<scm|apply-property>).

  It is useful to write <todo|can I find a better expression here?> functions
  belonging to different categories inside separated files. In this way, when
  adding features or otherwise modifying the code, it is easier to find the
  functions, and one is encouraged to keep functions organized by topic,
  which in turn helps to keep the whole set of functions \Peasy to navigate\Q
  and the relationships between them easy to grasp. This is of course an
  aspect of modularization, which in functional languages (like <scheme>) is
  promoted as well by the \Pinclination\Q that one feels, after having made
  some experience with the language, towards organizing one's own program as
  a composition of functions.

  In <TeXmacs> one can add a <scm|:use> form in the <scm|texmacs-module>
  declaration (see <value|scheme-guide>, section 1.4), specifying through it
  a module to import and having in this way available all functions that are
  defined using <scm|tm-define>\Vand as well the imported ones
  \Ptransitively\Q.<todo|improve and complete, explaining how we are doing it
  here (as if they are not transitive) and what are TeXmacs plans for this>

  Let us then organize our functions into five files\Vwe place together basic
  graphics object and basic mathematical objects since we have only one of
  each, we can split them when the file becomes larger. Here they are. We
  need to import in our <TeXmacs> document only four of them <todo|again
  explanation of transitivity and plans and show calls to
  <markup|use-modules> in the preamble>

  <paragraph|scheme-graphics.scm>

  <\scm-code>
    (texmacs-module (notes external-scheme-files scheme-graphics)

    \ \ (:use (notes external-scheme-files graphical-list-processing)))

    \;

    ;;; ================================

    ;;; function for graphic composition

    \;

    (tm-define (scheme-graphics x-size y-size alignment graphics-list)

    \ \ (stree-\<gtr\>tree

    \ \ \ `(with "gr-geometry"\ 

    \ \ \ \ \ \ \ \ (tuple "geometry" ,x-size ,y-size ,alignment)

    \ \ \ \ \ \ \ \ "font-shape" "italic"

    \ \ \ \ \ \ \ \ ,(denestify-conditional\ 

    \ \ \ \ \ \ \ \ \ \ \ \ `(graphics ,graphics-list)))))
  </scm-code>

  <paragraph|graphical-list-processing.scm>

  <\scm-code>
    (texmacs-module (notes external-scheme-files graphical-list-processing))

    \;

    ;;; ====================

    ;;; flattening functions

    \;

    (define objects-list '(point line cline spline arc

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ carc text-at
    math-at document-at))

    \;

    ;; used by the function apply-property in the module object-customization

    (tm-define (object-test expr)

    \ \ (not (equal?

    \ \ \ \ \ \ \ \ (filter (lambda (x) (equal? x expr)) objects-list)

    \ \ \ \ \ \ \ \ '())))

    \;

    (define (denest-test expr)

    \ \ (or

    \ \ \ (object-test expr)

    \ \ \ (equal? expr 'with)))

    \;

    ;; start from the answer https://stackoverflow.com/a/33338401\ 

    ;; to the Stack Overflow question

    ;; https://stackoverflow.com/q/33338078/flattening-a-list-in-scheme

    \;

    ;;(define (denestify lst)

    ;; \ (cond ((null? lst) '())

    ;; \ \ \ \ \ \ \ ((pair? (car lst))

    ;; \ \ \ \ \ \ \ \ (append (denestify (car lst))

    ;; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify (cdr lst))))

    ;; \ \ \ \ \ \ \ (else (cons (car lst) (denestify (cdr lst))))))

    \;

    ;; This function is not tail-recursive;\ 

    ;; see https://stackoverflow.com/a/33338608

    ;; for a tail-recursive function

    (tm-define (denestify-conditional lst)

    \ \ (cond ((null? lst) '())

    \ \ \ \ \ \ \ \ ((pair? (car lst))

    \ \ \ \ \ \ \ \ \ ;; If the car of (car lst) is 'with or another

    \ \ \ \ \ \ \ \ \ ;; of the symbols in denest-test, we cons it

    \ \ \ \ \ \ \ \ \ (if (denest-test (car (car lst)))

    \ \ \ \ \ \ \ \ \ \ \ \ \ (cons (car lst)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify-conditional (cdr lst)))

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; otherwise we flatten it with recursion,

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; obtaining a flat list, and append it to

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; the flattened rest of the list, in this

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; way flattening the combination of the

    \ \ \ \ \ \ \ \ \ \ \ \ \ ;; two lists

    \ \ \ \ \ \ \ \ \ \ \ \ \ (append (denestify-conditional (car lst))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify-conditional (cdr
    lst)))))

    \ \ \ \ \ \ \ \ ;; (car lst) is an atom

    \ \ \ \ \ \ \ \ (else (if (denest-test (car lst))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; test presence of (car lst) in the
    list

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; of symbols that stop
    denestification

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ lst ;; we leave lst as it is

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; otherwise we cons (car lst) onto
    the

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ;; flattened version of (cdr lst)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (cons (car lst)\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (denestify-conditional\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (cdr lst)))))))
  </scm-code>

  <paragraph|basic-objects.scm>

  <\scm-code>
    (texmacs-module (notes external-scheme-files basic-objects))

    \;

    ;;; =====================

    ;;; mathematical constants

    \;

    (tm-define \ pi (acos -1))

    \;

    ;;; ================================

    ;;; define a point using two numbers

    \;

    ;; exact-\<gtr\>inexact transforms fractions into floats yielding strings
    that are

    ;; parsed correctly by TeXmacs

    (tm-define (pt x y)

    \ \ `(point ,(number-\<gtr\>string (exact-\<gtr\>inexact x))
    ,(number-\<gtr\>string (exact-\<gtr\>inexact y))))
  </scm-code>

  <paragraph|geometrical-transformations.scm>

  <\scm-code>
    (texmacs-module (notes external-scheme-files
    geometrical-transformations))

    \;

    (define (translate-point point delta-vect)

    \ \ (let ((coord (map string-\<gtr\>number (cdr point))))

    \ \ \ \ (pt (+ (car coord) (car delta-vect))

    \ \ \ \ \ \ \ \ (+ (cadr coord) (cadr delta-vect)))))

    \;

    (tm-define (translate-element element delta-vect)

    \ \ (cond ((list? element)

    \ \ \ \ \ (if (equal? (car element) 'point)

    \ \ \ \ \ \ \ \ (translate-point element delta-vect)

    \ \ \ \ \ \ \ \ (map (lambda (x)\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (translate-element x delta-vect))\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ element)))

    \ \ \ \ \ \ \ \ (else element)))
  </scm-code>

  <paragraph|object-customization.scm>

  <\scm-code>
    (texmacs-module (notes external-scheme-files
    geometrical-transformations))

    \;

    (define (translate-point point delta-vect)

    \ \ (let ((coord (map string-\<gtr\>number (cdr point))))

    \ \ \ \ (pt (+ (car coord) (car delta-vect))

    \ \ \ \ \ \ \ \ (+ (cadr coord) (cadr delta-vect)))))

    \;

    (tm-define (translate-element element delta-vect)

    \ \ (cond ((list? element)

    \ \ \ \ \ (if (equal? (car element) 'point)

    \ \ \ \ \ \ \ \ (translate-point element delta-vect)

    \ \ \ \ \ \ \ \ (map (lambda (x)\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (translate-element x delta-vect))\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ element)))

    \ \ \ \ \ \ \ \ (else element)))
  </scm-code>

  \;

  Using the functions we defined, now we can repeat the drawings of
  <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm>.

  The translated <scm|triangle-in-half-circle> (made out of a list of objects
  we have already defined, uses the geometrical transformation functions):

  <\session|scheme|default>
    <\input|Scheme] >
      (define triangle-in-half-circle \ `(

      \ \ \ ,half-circle

      \ \ \ ,triangle

      \ \ \ ,letters))
    </input>

    <\textput>
      Draw it by placing it in the list argument of the <scm|scheme-graphics>
      function together with a translated copy of itself and the <TeXmacs>
      caption (translating that too):
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center"\ 

      `( ,triangle-in-half-circle

      \ \ \ ,(translate-element triangle-in-half-circle '(1.0 -1.5))

      \ \ \ ,(translate-element caption '(1.0 -1.5))))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|black|<arc|<point|-1.0|-1.5>|<point|0.0|0.23205080756888>|<point|3.0|-1.5>>>|<with|color|black|<line|<point|-1.0|-1.5>|<point|3.0|-1.5>>>|<with|color|red|line-width|1pt|<cline|<point|-1.0|-1.5>|<point|3.0|-1.5>|<point|0.0|0.23205080756888>>>|<with|color|black|<text-at|A|<point|-1.3|-2.0>>>|<with|color|black|<text-at|B|<point|3.1|-2.0>>>|<with|color|black|<text-at|C|<point|-0.2|0.43205080756888>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  The <scm|translated-triangle-in-half-circle-short-dashes> (uses the object
  customization functions<todo|functions (plural) or function (singular)?>):

  <\session|scheme|default>
    <\input|Scheme] >
      (define translated-triangle-in-half-circle-short-dashes

      \ \ (translate-element

      \ \ \ \ \ (apply-property

      \ \ \ \ \ \ \ (apply-property \ triangle-in-half-circle\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ "dash-style" "11100")

      \ \ \ \ \ \ \ \ "dash-style" "101010")

      \ \ \ \ \ '(1.0 -1.5)))
    </input>

    <\input|Scheme] >
      (define translated-caption\ 

      \ \ (translate-element caption '(1.0 -1.5)))
    </input>

    <\textput>
      The drawing is made out of complex objects, but the final expression
      shows what we have in mind: our geometrical construction and a shifted
      replica drawn with short dashes.
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center" `(

      ,triangle-in-half-circle

      ,translated-triangle-in-half-circle-short-dashes

      ,translated-caption))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<arc|<point|-1.0|-1.5>|<point|0.0|0.23205080756888>|<point|3.0|-1.5>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<line|<point|-1.0|-1.5>|<point|3.0|-1.5>>>>>|<with|color|red|line-width|1pt|<with|dash-style|11100|<with|dash-style|101010|<cline|<point|-1.0|-1.5>|<point|3.0|-1.5>|<point|0.0|0.23205080756888>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|A|<point|-1.3|-2.0>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|B|<point|3.1|-2.0>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|C|<point|-0.2|0.43205080756888>>>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <section|Manipulation of complex objects>

  We would like to manipulate complex objects as units. Let's see how to
  translate them; one can in a similar way rotate and stretch them (perhaps
  with respect to reference points which are calculated from the objects
  themselves). We will then see how to apply properties to all of the
  components of an object.

  <paragraph|Translate complex objects>

  Since all objects are made out of points (that is, lists that start with
  the symbol <scm|point>), we need to translate each point which the list is
  composed of.

  We do it by mapping a translation function recursively<\footnote>
    Neither the function for translation nor the one for property-setting are
    tail-recursive, but they are sufficient for our examples. Moreover the
    stack dimension in the calls to these function is determined by how much
    lists are nested, which keeps the stack dimension small.
  </footnote> onto the list that represents a complex object; in this
  recursive mapping we distinguish between expressions that represent points
  (that have to be translated) and expressions that represent something else
  (that have to be left as they are).

  The distinction is made when the recursion either gets to a point or gets
  to an atom: if it does get to an atom, then the translation function acts
  as the identity function. Here is the algorithm applied to a list:

  <\itemize>
    <item>If the list starts with <scm|point>, we apply the function that
    translates the point

    <item>If the list does not start with <scm|point>, we map the translation
    function onto the list

    <item>If while mapping we meet an atom, we leave it as it is
  </itemize>

  <\session|scheme|default>
    <\textput>
      A function to translate points
    </textput>

    <\input|Scheme] >
      (define (translate-point point delta-vect)

      \ \ (let ((coord (map string-\<gtr\>number (cdr point))))

      \ \ \ \ (pt (+ (car coord) (car delta-vect))

      \ \ \ \ \ \ \ \ (+ (cadr coord) (cadr delta-vect)))))
    </input>

    <\textput>
      The general translation function. It is called <scm|translate-element>
      rather than <scm|translate-object> because it applies to all elements,
      including atoms.
    </textput>

    <\input|Scheme] >
      (define (translate-element element delta-vect)

      \ \ (cond ((list? element)

      \ \ \ \ \ (if (equal? (car element) 'point)

      \ \ \ \ \ \ \ \ (translate-point element delta-vect)

      \ \ \ \ \ \ \ \ (map (lambda (x)\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (translate-element x delta-vect))\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ element)))

      \ \ \ \ \ \ \ \ (else element)))
    </input>

    <\textput>
      Let's apply this function to a polyline to see its effect on the
      <name|Scheme> expression:
    </textput>

    <\unfolded-io|Scheme] >
      (translate-element `((line ,(pt 1 2) ,(pt 2 3) ,(pt 3 4))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (text-at TeXmacs ,(pt -1 -1))) '(1
      1))
    <|unfolded-io>
      ((line (point "2" "3") (point "3" "4") (point "4" "5")) (text-at
      TeXmacs (point "0" "0")))
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  Let us now use our translation function on a complex object in a drawing:
  the triangle inscribed in the half-circle we first drew by listing all of
  the elementary objects and then by combining the complex <scm|triangle>,
  <scm|half-circle> and <scm|letter> objects (we are then going to add the
  <TeXmacs> caption!).

  \;

  <paragraph|Manipulate object properties>

  We write a simple function which wraps each elementary object in a
  <scm|with>, placing it inside with respect to any other <scm|with>
  construct the object might be already placed in. This function, applied a
  few times, generates deeply nested lists that may be difficult to read; a
  more refined function would check if the object is already inside a
  <scm|with> construct and if it is, modify the <scm|with> list rather than
  adding another one. We prefer the simple function to the refined one to
  keep this post to the point (\Pmodular graphics\Q).

  The <scm|with> needs to be placed as innermost wrapping construct for each
  element so that the new property will prevail onto pre-existing properties
  (<scm|with>s are scoping constructs).

  The <scm|apply-property> function is built with the same logic as the
  <scm|translate-element> function. When applied to a list, it first checks
  if the list starts with one of the \Pgraphical object\Q symbols; if it
  does, <scm|apply-property> wraps it in a <scm|with> construct; if it does
  not, <scm|apply-property> maps itself onto the list elements. When applied
  to an atom, <scm|apply-property> returns the input.

  In this way the function seeks recursively inside the lists of all the
  graphical objects, and applies the desired property to each.

  <\session|scheme|default>
    <\input|Scheme] >
      (define (apply-property element name value)

      \ \ (cond\ 

      \ \ \ \ ((list? element)

      \ \ \ \ \ \ \ \ (if (object-test (car element))

      \ \ \ \ \ \ \ \ \ \ \ \ `(with ,name ,value ,element)

      \ \ \ \ \ \ \ \ \ \ \ \ (map (lambda (x) (apply-property x name value))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ element)))

      \ \ \ \ \ (else element))) \ \ \ \ \ \ \ 
    </input>

    <\textput>
      Let's apply dashing to the <scm|triangle> object (let us view the
      <name|Scheme> lists):
    </textput>

    <\unfolded-io|Scheme] >
      (apply-property triangle "dash-style" "11100")
    <|unfolded-io>
      (with "color" "red" "line-width" "1pt" (with "dash-style" "11100"
      (cline (point "-2" "0") (point "2" "0") (point "-1.0"
      "1.73205080756888"))))
    </unfolded-io>

    <\textput>
      We act on a more complex object in the same way as we do on a simpler
      object\Vwe now apply dashing to the translated copy of
      <scm|triangle-in-half-circle>:
    </textput>

    <\unfolded-io|Scheme] >
      (apply-property

      \ \ (translate-element triangle-in-half-circle '(1.0 -1.5))

      \ \ "dash-style" "11100")
    <|unfolded-io>
      (((with "color" "black" (with "dash-style" "11100" (arc (point "-1.0"
      "-1.5") (point "0.0" "0.23205080756888") (point "3.0" "-1.5")))) (with
      "color" "black" (with "dash-style" "11100" (line (point "-1.0" "-1.5")
      (point "3.0" "-1.5"))))) (with "color" "red" "line-width" "1pt" (with
      "dash-style" "11100" (cline (point "-1.0" "-1.5") (point "3.0" "-1.5")
      (point "0.0" "0.23205080756888")))) ((with "color" "black" (with
      "dash-style" "11100" (text-at "A" (point "-1.3" "-2.0")))) (with
      "color" "black" (with "dash-style" "11100" (text-at "B" (point "3.1"
      "-2.0")))) (with "color" "black" (with "dash-style" "11100" (text-at
      "C" (point "-0.2" "0.43205080756888"))))))
    </unfolded-io>

    <\textput>
      Placing our objects in the list argument of <scm|scheme-graphics>, we
      obtain the drawing in a modular way:
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center" `(

      ,triangle-in-half-circle

      ,(apply-property

      \ \ (translate-element triangle-in-half-circle '(1.0 -1.5))

      \ \ "dash-style" "11100")

      ,(translate-element caption '(1.0 -1.5))))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|alignment>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|line-width|1pt|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|black|<with|dash-style|11100|<arc|<point|-1.0|-1.5>|<point|0.0|0.23205080756888>|<point|3.0|-1.5>>>>|<with|color|black|<with|dash-style|11100|<line|<point|-1.0|-1.5>|<point|3.0|-1.5>>>>|<with|color|red|line-width|1pt|<with|dash-style|11100|<cline|<point|-1.0|-1.5>|<point|3.0|-1.5>|<point|0.0|0.23205080756888>>>>|<with|color|black|<with|dash-style|11100|<text-at|A|<point|-1.3|-2.0>>>>|<with|color|black|<with|dash-style|11100|<text-at|B|<point|3.1|-2.0>>>>|<with|color|black|<with|dash-style|11100|<text-at|C|<point|-0.2|0.43205080756888>>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>

    <\textput>
      <scm|apply-property> and <scm|translate-element> can be applied in both
      orders. In the previous example we translated first the object, then we
      applied the dashing; here we apply the dashed style first, then we
      translate the object.
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center" `(

      ,triangle-in-half-circle

      ,(translate-element \ \ (apply-property

      \ \ \ triangle-in-half-circle \ \ "dash-style" "11100")

      \ \ '(1.0 -1.5))

      ,(translate-element caption '(1.0 -1.5))))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|alignment>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|line-width|1pt|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|black|<with|dash-style|11100|<arc|<point|-1.0|-1.5>|<point|0.0|0.23205080756888>|<point|3.0|-1.5>>>>|<with|color|black|<with|dash-style|11100|<line|<point|-1.0|-1.5>|<point|3.0|-1.5>>>>|<with|color|red|line-width|1pt|<with|dash-style|11100|<cline|<point|-1.0|-1.5>|<point|3.0|-1.5>|<point|0.0|0.23205080756888>>>>|<with|color|black|<with|dash-style|11100|<text-at|A|<point|-1.3|-2.0>>>>|<with|color|black|<with|dash-style|11100|<text-at|B|<point|3.1|-2.0>>>>|<with|color|black|<with|dash-style|11100|<text-at|C|<point|-0.2|0.43205080756888>>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>

    <\textput>
      The last application of <scm|apply-property> prevails, as it is set in
      the innermost <scm|with> list; subobjects which have individually-set
      values of the property will all be set to the value fixed by the last
      application of <scm|apply-property>. Here we apply a short-dash style
      on an object which has long-dashing throughout:
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center" `(

      ,triangle-in-half-circle

      ,(translate-element (apply-property

      \ \ \ (apply-property

      \ \ \ triangle-in-half-circle \ \ "dash-style" "11100")

      \ \ "dash-style" "101010")

      \ \ '(1.0 -1.5))

      ,(translate-element caption '(1.0 -1.5))))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|alignment>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|line-width|1pt|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<arc|<point|-1.0|-1.5>|<point|0.0|0.23205080756888>|<point|3.0|-1.5>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<line|<point|-1.0|-1.5>|<point|3.0|-1.5>>>>>|<with|color|red|line-width|1pt|<with|dash-style|11100|<with|dash-style|101010|<cline|<point|-1.0|-1.5>|<point|3.0|-1.5>|<point|0.0|0.23205080756888>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|A|<point|-1.3|-2.0>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|B|<point|3.1|-2.0>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|C|<point|-0.2|0.43205080756888>>>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>
  </session>

  <section|<name|Scheme> expressions that show what we mean>

  We apply again the idea of modularity by assigning to a variable the object
  which we obtain after translation and application of dashing, and using the
  variable to build a drawing. Our code again shows that in <name|Scheme>
  building blocks combine together well.

  <\session|scheme|default>
    <\unfolded-io|Scheme] >
      (define translated-triangle-in-half-circle-short-dashes

      \ \ (translate-element

      \ \ \ \ \ (apply-property

      \ \ \ \ \ \ \ (apply-property \ triangle-in-half-circle\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ "dash-style" "11100")

      \ \ \ \ \ \ \ \ "dash-style" "101010")

      \ \ \ \ \ '(1.0 -1.5)))
    <|unfolded-io>
      \;
    </unfolded-io>

    <\input|Scheme] >
      (define translated-caption\ 

      \ \ (translate-element caption '(1.0 -1.5)))
    </input>

    <\textput>
      The drawing is made out of complex objects, but the final expression
      shows what we have in mind: our geometrical construction and a shifted
      replica drawn with short dashes.
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center" `(

      ,triangle-in-half-circle

      ,translated-triangle-in-half-circle-short-dashes

      ,translated-caption))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|alignment>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|line-width|1pt|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<arc|<point|-1.0|-1.5>|<point|0.0|0.23205080756888>|<point|3.0|-1.5>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<line|<point|-1.0|-1.5>|<point|3.0|-1.5>>>>>|<with|color|red|line-width|1pt|<with|dash-style|11100|<with|dash-style|101010|<cline|<point|-1.0|-1.5>|<point|3.0|-1.5>|<point|0.0|0.23205080756888>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|A|<point|-1.3|-2.0>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|B|<point|3.1|-2.0>>>>>|<with|color|black|<with|dash-style|11100|<with|dash-style|101010|<text-at|C|<point|-0.2|0.43205080756888>>>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>
  </session>

  We can play further. Let's blend the triangle inside the half-circle
  stepwise. Our functions are not sophisticated enough to target a subunit of
  a complex object: applying a line-width to the whole drawing of the
  triangle in the half-circle would eliminate the different line-widths for
  the triangle and arc; for this reason, we use as an example of blending in
  the triangle alone, which is one of the units we defined.

  <\session|scheme|default>
    <\textput>
      The <scm|blend-in-triangle> function shifts the triangle by <scm|delta>
      times the vector <scm|(1.0 -1.5)>, applies dashing and a linewidth
      which is thicker as the triangle is closer to being inscribed in the
      half-circle (we are going to use this function for values of
      <scm|delta> which yield positive values of the line thickness).
    </textput>

    <\input|Scheme] >
      (define (blend-in-triangle delta)

      \ \ (translate-element \ \ (apply-property

      \ \ \ (apply-property

      \ \ \ triangle

      \ \ "dash-style" "101010")

      \ \ \ "line-width" (string-join\ 

      \ \ \ \ \ \ \ \ \ `(,(number-\<gtr\>string (- 1 delta)) "pt") ""))

      \ \ \ \ \ \ \ \ \ `(,(* 1.0 delta) ,(* -1.5 delta))))
    </input>

    <\textput>
      Let's map this function on a list of <scm|d> values, and let us name
      the object it returns (all lists of objects will be flattened by the
      conditional flattener) in a meaningful way:
    </textput>

    <\input|Scheme] >
      (define delta-lst

      \ \ \ \ \ \ \ '(0.2 0.4 0.6 0.8)))
    </input>

    <\input|Scheme] >
      (define blend-in-triangle-series

      \ \ (map blend-in-triangle delta-lst))
    </input>

    <\textput>
      Here is the triangle blending in into the half-circle <text-dots> or
      fading away!
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center" `(

      ,blend-in-triangle-series

      ,triangle-in-half-circle

      ,translated-caption))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|alignment>|font-shape|italic|<graphics|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.8pt|<cline|<point|-1.8|-0.3>|<point|2.2|-0.3>|<point|-0.8|1.43205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.6pt|<cline|<point|-1.6|-0.6>|<point|2.4|-0.6>|<point|-0.6|1.13205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.4pt|<cline|<point|-1.4|-0.9>|<point|2.6|-0.9>|<point|-0.4|0.83205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.2pt|<cline|<point|-1.2|-1.2>|<point|2.8|-1.2>|<point|-0.2|0.53205080756888>>>>>|<with|color|black|<arc|<point|-2|0>|<point|-1.0|1.73205080756888>|<point|2|0>>>|<with|color|black|<line|<point|-2|0>|<point|2|0>>>|<with|color|red|line-width|1pt|<cline|<point|-2|0>|<point|2|0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  One could wish for more actions. For example, one could wish to find
  intersections of lines which define objects, and assign them to new
  objects. Another example is to define styles as shortcuts to set several
  properties of a graphical object with a single operation; this is among the
  functions in the yet-to-be completed <TeXmacs> <name|Scheme> graphics code.
  <name|Scheme> is promising for implementing each of them.

  As a sketch of an implementation, styles could be defined as lists of
  name-value pairs, maybe association lists (this might allow easier
  error-checking), which can be inserted into <scm|with> constructs by a
  function which first flattens the pairs then appends the resulting list
  into a <scm|'(with ... object)> list at the position we indicated with the
  dots to apply all of the properties to <scm|object>. Never mind that the
  <name|Scheme> syntax to achieve what we want is slightly different from the
  description I gave, it is close enough that I hope it is convincing.

  About persuasion. I hope that I convinced you that the initial effort of
  setting up <name|Scheme> functions pays off: one constructs a powerful
  graphical language in which arbitrarily complex graphics are treated
  uniformly.
</body>

<\initial>
  <\collection>
    <associate|page-medium|papyrus>
    <associate|page-screen-margin|false>
    <associate|preamble|false>
    <associate|prog-scripts|scheme>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|?|?>>
    <associate|auto-10|<tuple|3|?>>
    <associate|auto-11|<tuple|1|?>>
    <associate|auto-12|<tuple|2|?>>
    <associate|auto-13|<tuple|4|?>>
    <associate|auto-2|<tuple|1|?>>
    <associate|auto-3|<tuple|1|?>>
    <associate|auto-4|<tuple|2|?>>
    <associate|auto-5|<tuple|1|?>>
    <associate|auto-6|<tuple|2|?>>
    <associate|auto-7|<tuple|3|?>>
    <associate|auto-8|<tuple|4|?>>
    <associate|auto-9|<tuple|5|?>>
    <associate|footnote-1|<tuple|1|?>>
    <associate|footnr-1|<tuple|1|?>>
    <associate|sec:a-few-functions|<tuple|1|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|table>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        The <with|font-shape|<quote|small-caps>|Scheme> functions for modular
        graphics we defined in <locus|<id|%3398ED8-5BA4E20>|<link|hyperlink|<id|%3398ED8-5BA4E20>|<url|./modular-scheme-graphics.tm>>|Modular
        graphics with <with|font-shape|<quote|small-caps>|Scheme>>
      </surround>|<pageref|auto-3>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|font-shape|<quote|small-caps>|<with|font-shape|<quote|small-caps>|Scheme>
      graphics with external files> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <pageref|auto-1><vspace|0.5fn>

      1.<space|2spc>A few initial functions - composing complex objects
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>

      2.<space|2spc>Organizing one's own <with|font-shape|<quote|small-caps>|Scheme>
      files (modularization) <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>

      <with|par-left|<quote|4tab>|scheme-graphics.scm
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|graphical-list-processing.scm
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|basic-objects.scm
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|geometrical-transformations.scm
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|object-customization.scm
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.15fn>>

      3.<space|2spc>Manipulation of complex objects
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>

      <with|par-left|<quote|4tab>|Translate complex objects
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Manipulate object properties
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12><vspace|0.15fn>>

      4.<space|2spc><with|font-shape|<quote|small-caps>|Scheme> expressions
      that show what we mean <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>
    </associate>
  </collection>
</auxiliary>