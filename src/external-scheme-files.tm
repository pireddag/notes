<TeXmacs|1.99.19>

<style|<tuple|notes|framed-session>>

<\body>
  <\hide-preamble>
    Use an environment variable to define the module path to make it easier
    to refer to it in the text of the document

    <assign|graphics-functions|(notes external-scheme-files scheme-graphics)>

    <use-module|<value|graphics-functions>>

    <assign|scheme-guide|<hlink|<name|Scheme>
    guide|http://www.texmacs.org/tmweb/documents/manuals/texmacs-scheme.en.pdf>>

    <assign|modular-graphics|<macro|<hlink|Modular
    graphics|./modular-scheme-graphics.tm>>>

    <assign|mark-date|<macro|body|<arg|body> \U >>

    <assign|todo-blue|<macro|body|<render-todo|dark blue|pastel
    blue|<arg|body>>>>
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

    <item> a function for loading a drawing from a file (probably not, use
    <scm|load> directly)

    <\itemize>
      <item>done\Vuse <scm|load> directly
    </itemize>

    <item>Introduce the <scm|:secure> keyword. Do I have to use it? How is it
    working now? 2021-03-17 I have the security set to \Pprompt on script\Q.
    Does it affect only what I can call from a macro and not what i can call
    from Scheme?

    <item>cite the developer's guide \Pappropriately\Q

    <item>(done) introduce abbreviation <value|scheme-guide>

    <item>is <scm|:use> transitive? (it seems so, and that transitive
    importation is possible)

    <\itemize>
      <item>Asked on TeXmacs-dev on 2021-03-17

      <\itemize>
        <item>Answer received: <scm|define>,
        <scm|define-public>,<scm|tm-define>

        <item>Reorganize modules accordingly

        <item>Further answer in group-chat 2021-13-20: <scm|tm-define> is
        global, once that the definition has been executed. So one file has
        to load the file where the function is <scm|tm-define>d (this settles
        many of the following subpoints)
      </itemize>

      <item>A file sees the functions defined with <scm|tm-define> in the
      modules that it <scm|:use>s, and only them, but these are seen
      transitively

      <item>If transitive import is possible, that is not good, as the
      symbols for hlper functions will be visible in <TeXmacs> documents. I
      have to make it clear in this post (as a small advantage, I can import
      multiple libraries with one <markup|use-modules> command only).

      <item>I have to inform myself on what are the plans on the topic and
      write them in the blog post if necessary

      <item>transitivity is also within modules, or only from a module to a
      document? That is, if in module1 I load a module2 which loads another
      module3, do I see the tm-definitions of module3 in module2?
    </itemize>

    <item>organize the \Phyerarchy\Q of functions and import them in the
    document

    <\itemize>
      <item>partly done, review
    </itemize>

    <item>explain that we change \Pimports\Q in mid blog post (2021-03-17 in
    the document I change the file and then after having finished section
    <reference|sec:a-few-functions> import separately each module that I want
    to use; I need to talk to JvdH about this) (so the functions up to a
    point in the blog post work with the first import, and after that they
    work with the new import)

    <\itemize>
      <item>I have saved the first import as
      <verbatim|scheme-graphics.scm.saved> in the same directory as the other
      files
    </itemize>

    <item>rewrite the post without using environment variables to store the
    modules' names

    <item>Look at <verbatim|test-parsing-points.tm> in the folder
    <verbatim|Working files> to see how we defined the <scm|pt> functions and
    what is the effect of <scm|number-\<gtr\>string> in this context

    <item>put the final example in a executable switch and suggest that
    everything can go into an external file (so one can use emacs with
    paredit for example)

    <\itemize>
      <item>partly done
    </itemize>

    <\itemize>
      <item>the emacs mode for TeXmacs, <scm|tm-mode>, which is in my
      <verbatim|.emacs> file
    </itemize>

    <item>remove the <verbatim|.scm> file from the <verbatim|src> directory
    and place it somewhere sensible

    <\itemize>
      <item>done (it is in <verbatim|resources/external-scheme-files>)
    </itemize>

    <item>link to <hlink|<TeXmacs> forum|http://forum.texmacs.cn/t/are-there-any-good-methods-to-help-developing-scheme-modules/211>
    with techniques for Scheme development (and to Jeroen Wouter's email
    message? \VJolly coders mailing list \PThe videos of the 2012 workshop
    have also been very informative (e.g. I've learnt about using disp* for
    debugging Scheme code and Debug-\<gtr\>io for debugging
    plug-ins).\Q\VPerhaps to the videos only)

    <item>say where to download the files from! (A subdirectory of resources)

    <item>See the Tetris game document for how to load a Scheme file which is
    in the same directory as the document

    <\itemize>
      <item>set a note in this document about the different way of including
      code that is used in the Tetris game document?
    </itemize>

    <item><mark-date|2021-03-22> Do we need <scm|apply-property>? There is
    <scm|gr-group>: do we need the flattening? I need to test to make sure
    that I can apply properties to arbitrarily nested objects (very likely, I
    recall. The code would become much shorter (but still there would be
    submodules), and it would harmonize itself with the <TeXmacs> code. I
    would need to stress that the code in this post is different from the
    code in the previous posts of the series.

    <\itemize>
      <item>Note that with the current code properties can be applied only
      one at a time\V<scm|(apply-property triangle "color" "red" "dash-style"
      "101010")> does not work

      <item>It is better to keep the code consistent with the other posts in
      the same series
    </itemize>

    <item>Mention <TeXmacs> default graphical code (figure out how it
    works/does it work for setting properties?)

    <item>Make the initial function the same in the document and in the code
    and comment the code

    <\itemize>
      <item>I possibly forgot how conditional flattening works; there was a
      \Ppitfall\Q, that I think is implicitly described in the code comments,
      which should be written more clearly
    </itemize>

    <item>At the end, delete empty scheme prompts
  </itemize>

  This post is a part of a series of <name|Scheme> graphics in <TeXmacs>.
  Other posts in the same series are <hlink|Composing <TeXmacs> graphics with
  <name|Scheme>|./scheme-graphics.tm>, <hlink|Embedding graphics composed
  with <name|Scheme> into documents|./scheme-graphics-embedding.tm> and
  <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm>
  (sometimes indicated with <modular-graphics> from now on). Like in the
  other posts of the series, we assume that the reader is familiar with
  simple Scheme syntax. We link again to the <name|Wikipedia> book
  <hlink|Scheme programming|https://en.wikibooks.org/wiki/Scheme_Programming>
  and to <hlink|Yet Another Scheme Tutorial|http://www.shido.info/lisp/idx_scm_e.html>
  by Takafumi Shido as two possible web resources for learning <name|Scheme>.

  In the preceding posts we defined the <scheme> forms for graphics within
  documents, using <scheme> sessions. It would be helpful to define them in
  separate files so that, after pointing <TeXmacs> to them, one would be able
  to use in one's own documents the functionalities they provide.

  We would be able to use <scheme> functions provided by external files
  inside macros (with the <markup|extern> tag), by clicking on hyperlinks
  (with the <markup|action> tag), inside <name|Executable fold> environments
  (a way to embed graphics in documents) or in <name|Scheme> sessions.

  Let's see how to do this; our descriptions repeats the concepts presented
  in the <hlink|<TeXmacs> <name|Scheme> developer
  guide|http://www.texmacs.org/tmweb/documents/manuals/texmacs-scheme.en.pdf>
  (indicated as <value|scheme-guide> from now on, describes how to control
  and extend <TeXmacs> through <scheme>) putting them in the context of our
  graphics example. We are going to use the modules system (whose files are
  stored by convention in the <verbatim|progs> subtree), and leave aside the
  plugin functionality. The modules are included in the <TeXmacs> document
  via the macro <markup|use-module>, that takes as its argument the location
  of the file (path and file name) and can be placed in the preamble.

  Let us see an example, keeping in mind that the location is specified in
  <TeXmacs> relative to the user's <verbatim|progs> directory, which under
  Linux is a subdirectory of <verbatim|~/.TeXmacs/><todo|complete with other
  operating systems>; if the file we want to include is
  <verbatim|notes/external-scheme-files/scheme-graphics.scm>, then the
  <markup|use-module> macro will have to be called with the argument
  <scm|<value|graphics-functions>>; the <TeXmacs> command is

  <inactive|<use-module|<value|graphics-functions>>>.

  This post is accompanied by the <name|Scheme> source files
  <scm|scheme-graphics-single-file.scm> in the directory
  <hlink|<verbatim|resources/<verbatim|external-scheme-files/single-file>>|https://github.com/texmacs/notes/tree/main/resources/external-scheme-files>
  (this first file is for the initial example) and
  <verbatim|scheme-graphics.scm>, <verbatim|basic-objects.scm>,
  <verbatim|graphical-list-processing.scm>,
  <verbatim|object-customization.scm>, <verbatim|geometrical-transformations.scm>
  in the directory <hlink|<verbatim|resources/<verbatim|external-scheme-files>>|https://github.com/texmacs/notes/tree/main/resources/external-scheme-files>.
  To be able to run the examples of this post on your computer, you will have
  to download the <name|Scheme> source files and place them in a place where
  <TeXmacs> can find them; the location will have to match the one set
  through the <markup|use-module> macro that makes the files available to
  <TeXmacs> (and the file itself as well will have to be marked with its own
  location, but we will see that later).

  \ <todo|provide a running document with the same mechanism of the Tetris
  document; the modules too must be slightly different and I will need to
  load correctly the final file too (and explain everything clearly, perhaps
  in a separate section \Phow to start experimenting\Q at the end)>. If you
  place the files in a different folder, please adjust correspondingly both
  the path in the <markup|use-module> macro and inside the <scheme> file
  itself in the instruction that declares its name and possibly imports
  additional modules (we will discuss submodules in Section
  <reference|sec:modularization>).

  For this post, we will re-use some of the code of <modular-graphics>, in
  particular the definitions that allow composing objects, assigning them
  properties, and translating them.<todo|comment relationship to existing
  Scheme graphics code. Can I use it?>

  <section|A few functions in a single file (enough to compose complex
  objects)><label|sec:a-few-functions>

  We start from the symbols (functions and variables) we developed in
  <modular-graphics>. \ Let us list them together with a short description
  (Table <reference|tab:functions-list>); next to each function we note
  whether it serves as a building block for other symbols (\Paux\Q for
  auxiliary) or it is meant for graphics compositions by users (\Puser\Q).
  Please refer to <modular-graphics> and to comments in the code<todo|and to
  comments in the code\Vto add><todo-blue|partly done\Vsee if I want to
  delete some comments in the blog version of the code> for a discussion of
  the code itself (the <scheme> files are more richly commented than the code
  blocks in this post<todo|check if it is true at the end of the work>); in
  this post we will focus on how to make available in <TeXmacs> documents our
  forms with the help of external files.

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
    <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm><label|tab:functions-list>
  </big-table>

  <TeXmacs> has a module system (<value|scheme-guide>, section 1.4), so that
  one can collect <scheme> functions in a file and make them available to a
  document through the <markup|use-module> command. Modules must start with
  the <scm|texmacs-module> form, which states the location of the module in
  the file tree (starting from the <TeXmacs> user home directory) and
  optionally allows inclusion of other code (discussed in Section
  <reference|sec:modularization>); the mandatory argument of the
  <scm|texmacs-module> form is (borrowing one sentence from the
  <value|scheme-guide>) a list which corresponds to the location of the
  corresponding le (an optional argument specifies submodules, again see
  \ Section <reference|sec:modularization>). <todo|There are several possible
  paths TeXmacs is looking the files in, see sect 1.4. Test them. How does it
  work with the file location?>.

  We write up an initial file with the first few functions, enough to draw
  the first example of <modular-graphics>, which is a triangle. We call our
  first file\ 

  Our <verbatim|scheme-graphics.scm> files contains (following code
  block<todo|switch to captioned and numbered code blocks>) the <scm|pt> and
  <scm|scheme-graphics> functions together with the symbol <scm|pi> and the
  helper functions (not accessible to the <TeXmacs> document)
  <scm|objects-list>, <scm|object-test>, <scm|denest-test>, and
  <scm|denestify-conditional>; it starts, as announced, with a
  <scm|texmacs-module> form; the list <scm|(notes external-scheme-files
  scheme-graphics)> corresponds to the path
  <verbatim|notes/external-scheme-files/scheme-graphics> in the
  <verbatim|$TEXMACS_HOME_PATH/progs/> directory:

  <\scm-code>
    (texmacs-module (notes external-scheme-files
    scheme-graphics-single-file))

    \;

    ;; 2021-03-12 define "correctly" in "parse correctly" (pt function)

    \;

    ;;; ======================

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

    \;

    ;;; ====================

    ;;; flattening functions

    \;

    (define objects-list '(point line cline spline arc

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ carc text-at
    math-at document-at))

    \;

    (define (object-test expr)

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

  \;

  We use two variations of the <scm|define> form in <TeXmacs>: the standard
  <scm|define>, which makes functions and variables available within one
  module, and <scm|tm-define> which makes them globally available, as soon as
  they are defined (in particular, they are available within <TeXmacs>
  documents).

  We have now the <scm|pt> and <scm|scheme-graphics> functions and we use
  them to compose the \Ptriangle\Q example of <modular-graphics> in a
  <scheme> session; please refer again to that post for a step-by-step
  discussion of the code.

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
      (scheme-graphics "6cm" "5cm" "center"\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ `(,half-circle

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,triangle

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,letters

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,caption))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|6cm|5cm|center>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  In the next section we will work with several <scheme> files acting as
  submodules, and correspondingly we will have to import them using
  <markup|use-modules>.

  For this document, files are organized in the following way: Since the set
  of functions of the \Pnew\Q modules will include some of the functions we
  have already used <todo|complete explanation>

  <section|Organizing one's own <scheme> files
  (modularization)><label|sec:modularization>

  The functions we wrote in <hlink|Modular graphics with
  <name|Scheme>|./modular-scheme-graphics.tm> can be grouped in a few
  categories: inserting a <TeXmacs> graphics in a drawing
  (<scm|scheme-graphics>), processing <TeXmacs> graphics (<scm|objects-list>,
  <scm|object-test>, <scm|denest-test>, and <scm|denestify-conditional>),
  \ basic graphics object (<scm|pt>), basic mathematical objects (<scm|pi>),
  geometrical transformations of objects (<scm|translate-point> and
  <scm|translate-element>) and object customization (<scm|apply-property>).

  It is useful to place functions belonging to different categories inside
  separated files. In this way, when adding features or otherwise modifying
  the code, it is easier to find the code we want to edit; in addition to
  this, by distributing code in several files one is encouraged to keep
  functions organized by topic, which in turn helps to keep the whole set of
  functions \Peasy to navigate\Q and the relationships between them easy to
  grasp. This is of course an aspect of modularization, which in functional
  languages (like <scheme>) is promoted as well by the \Pinclination\Q that
  one feels, after having made some experience with the language, towards
  organizing one's own program as a composition of functions.

  <todo|Revise next paragraph. The <scm|tm-define> form then makes it
  possible to load functions through apparently \Ptransitive\Q loading of
  modules (harmonize with paragraph after the next) (verify the global
  loading of <scm|tm-define>d functions for documents and for modules; see
  todo note in the following paragraph too, where I state that it does not
  work for a document! Was I right? Maybe I was referring to
  <scm|define-public>)>

  In <TeXmacs> one can add a <scm|:use> form in the <scm|texmacs-module>
  declaration (see <value|scheme-guide>, section 1.4), specifying through it
  modules to import; the specification is done through lists which state the
  path of each module. Functions in <TeXmacs> can be defined through three
  distinct definition forms <todo|are these functions or macros?
  <scm|tm-define> is a macro (defined in <verbatim|prog/kernel/tm-define.scm>)
  and there is a macro definition for <scm|define-public-macro> (in
  <verbatim|prog/kernel/boot.scm>); for <scm|define-public> see
  <hlink|https://www.gnu.org/software/guile/manual/html_node/Creating-Guile-Modules.html|https://www.gnu.org/software/guile/manual/html_node/Creating-Guile-Modules.html>;
  <scm|procedure-source> applied to <scm|define-public> gives an error
  (<scm|Wrong type argument in position 1: #\<less\>macro!
  define-public\<gtr\>>), and in fact <scm|define-public> can be
  macroexpanded; <scm|procedure-source> applied to <scm|define-private> gives
  <scm|Wrong type argument in position 1: #\<less\>primitive-builtin-macro!
  define\<gtr\> >and <scm|(eq? define define-private)> yields <scm|#t>; see
  <hlink|test-function-definitions.tm|/home/giovanni/test/test_TeXmacs/2 -
  Test/Test definitions/test-function-definitions.tm>>, leading to three
  different scoping rules. Functions defined with <scm|define> are local to
  the module in which they are defined; \ functions defined with
  <scm|define-public> are visible both from the module in which they are
  defined and in modules that import that directly <todo-blue|verify whether
  transitive import for <scm|define-public> works within Scheme\Vit does not
  work for a document>(at the moment I am writing, March 2021,
  <scm|define-public> is not yet documented in the
  <value|scheme-guide><todo|it is a Guile function, see link above>);
  functions that are defined with <scm|tm-define> are \Pglobal\Q: once their
  definition form is executed (for example by <scm|:use>ing a module where
  they are defined) they are available to any another module and document
  <todo|I could document this for myself both for documents (try using a
  function in a document without <markup|use-modules>) and for modules (with
  <scm|:use>); the following paragraphs depend on this>.

  The global character of <scm|tm-define>d functions makes it also possible
  to organize \Ppackages\Q of modules that can be used in a document with a
  single <markup|use-modules> command: in fact it is sufficient to collect
  all of the desired modules under a <scm|:use> form in a \Pmaster\Q module
  and then import that<compound|todo-blue|distinguish from \Ptransitive
  importing\Q and review what happens with <scm|define-public>>. We will do
  so in this document<todo| switch the import file, as described at the end
  of the previous section>.

  Let us then organize our functions into five files\Vwe place together
  functions defining basic graphics objects and basic mathematical objects
  since we have only one of each, we could split them when the file becomes
  larger. Here they are. We need to import in our <TeXmacs> document only one
  of them, as we discussed\Vsetting one of them
  (<verbatim|scheme-graphics.scm>) as \Pmaster\Q and importing the rest
  through <scm|:use> <todo|note that all of the <scm|define-public> functions
  are also imported in the master file, but they are not imported in the
  document (2021-03-31 checked with <scm|object-test>, which is defined with
  <scm|define-public in graphical-list-processing.scm> and is not imported in
  the document\VI do not think that I can improve this>.

  <paragraph|scheme-graphics.scm>

  <\scm-code>
    (texmacs-module (notes external-scheme-files scheme-graphics)

    \ \ (:use (notes external-scheme-files graphical-list-processing)

    \ \ \ \ \ \ \ \ (notes external-scheme-files basic-objects)

    \ \ \ \ \ \ \ \ (notes external-scheme-files geometrical-transformations)

    \ \ \ \ \ \ \ \ (notes external-scheme-files object-customization)))

    \;

    \;

    ;;; ================================

    ;;; function for graphic composition

    \;

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

    (define-public (object-test expr)

    \ \ (not (equal?

    \ \ \ \ \ \ \ \ (filter (lambda (x) (equal? x expr)) objects-list)

    \ \ \ \ \ \ \ \ '())))

    \;

    (define (denest-test expr)

    \ \ (or

    \ \ \ (object-test expr)

    \ \ \ (equal? expr 'with)))

    \;

    \;

    ;; start from the answer https://stackoverflow.com/a/33338401\ 

    ;; to the Stack Overflow question

    ;; https://stackoverflow.com/q/33338078/flattening-a-list-in-scheme

    \;

    ;; This function is not tail-recursive;\ 

    ;; see https://stackoverflow.com/a/33338608

    ;; for a tail-recursive function

    (define-public (denestify-conditional lst)

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
    (texmacs-module (notes external-scheme-files object-customization)

    \ \ (:use (notes external-scheme-files graphical-list-processing)))

    \;

    (tm-define (apply-property element name value)

    \ \ (cond\ 

    \ \ \ \ ((list? element)

    \ \ \ \ \ \ \ \ (if (object-test (car element))

    \ \ \ \ \ \ \ \ \ \ \ \ `(with ,name ,value ,element)

    \ \ \ \ \ \ \ \ \ \ \ \ (map (lambda (x) (apply-property x name value))

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ element)))

    \ \ \ \ \ (else element))) \ 
  </scm-code>

  Using the functions we defined, now we can repeat the drawings of
  <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm>.

  The \ <scm|triangle-in-half-circle> (made out of a list of objects we have
  already defined, again parsable by <scm|denestify-conditional>):

  <\session|scheme|default>
    <\input|Scheme] >
      (define triangle-in-half-circle \ 

      \ \ `(,half-circle

      \ \ \ \ ,triangle

      \ \ \ \ ,letters))
    </input>

    <\textput>
      Draw it by placing it in the list argument of the <scm|scheme-graphics>
      function (which expects lists of objects, which will be parsed by
      <scm|denestify-conditional>) together with a translated copy of itself
      (using the the geometrical transformation function
      <scm|translate-element>) and the <TeXmacs> caption (translating that
      too):
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
  customization function <scm|apply-property> on an object we have already
  defined):

  <\session|scheme|default>
    <\input|Scheme] >
      (define translated-triangle-in-half-circle-short-dashes

      \ \ (translate-element

      \ \ \ \ \ (apply-property

      \ \ \ \ \ \ triangle-in-half-circle

      \ \ \ \ \ \ "dash-style" "101010")

      \ \ \ \ \ '(1.0 -1.5)))
    </input>

    <\input|Scheme] >
      (define translated-caption\ 

      \ \ (translate-element caption '(1.0 -1.5)))
    </input>

    <\textput>
      and draw the graphics with the <scm|scheme-graphics> function:
    </textput>

    <\unfolded-io|Scheme] >
      (scheme-graphics "400px" "300px" "center" `(

      ,triangle-in-half-circle

      ,translated-triangle-in-half-circle-short-dashes

      ,translated-caption))
    <|unfolded-io>
      <text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|black|<with|dash-style|101010|<arc|<point|-1.0|-1.5>|<point|0.0|0.23205080756888>|<point|3.0|-1.5>>>>|<with|color|black|<with|dash-style|101010|<line|<point|-1.0|-1.5>|<point|3.0|-1.5>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<cline|<point|-1.0|-1.5>|<point|3.0|-1.5>|<point|0.0|0.23205080756888>>>>|<with|color|black|<with|dash-style|101010|<text-at|A|<point|-1.3|-2.0>>>>|<with|color|black|<with|dash-style|101010|<text-at|B|<point|3.1|-2.0>>>>|<with|color|black|<with|dash-style|101010|<text-at|C|<point|-0.2|0.43205080756888>>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>
    </unfolded-io>

    <\input|Scheme] >
      \;
    </input>
  </session>

  <section|Drawings as part of documents>

  The mechanism of external files helps one to embed drawings in one's
  document, as including the drawing (i.e. <scheme> code) may be \Pcleaner\Q
  than developing it inside the document itself and external applications (I
  am using <name|emacs>) may offer facilities one likes. The key step for
  blending one's drawing into the document is the <name|Executable fold>
  environment (see also <hlink|Embedding graphics composed with <name|Scheme>
  into documents|./scheme-graphics-embedding.tm>).

  Let us illustrate it with the \Pblending in\Q/\Pwaning out\Q triangle of
  <hlink|Modular graphics with <name|Scheme>|./modular-scheme-graphics.tm>.
  As a first step, we place into the <name|Executable fold> environment a
  <scm|begin> form that depends on symbols we have already defined and has a
  last subform (the one that wil be its return value) a <scm|scheme-graphics>
  form.

  <\script-input|scheme|default>
    (begin\ 

    \ \ (define (blend-in-triangle delta)

    \ \ (translate-element \ \ (apply-property

    \ \ \ (apply-property

    \ \ \ triangle

    \ \ "dash-style" "101010")

    \ \ \ "line-width" (string-join\ 

    \ \ \ \ \ \ \ \ \ `(,(number-\<gtr\>string (- 1 delta)) "pt") ""))

    \ \ \ \ \ \ \ \ \ `(,(* 1.0 delta) ,(* -1.5 delta))))

    \ \ (define delta-lst

    \ \ \ \ \ \ \ '(0.2 0.4 0.6 0.8))

    \ \ (define blend-in-triangle-series

    \ \ \ \ (map blend-in-triangle delta-lst))

    \ \ (scheme-graphics "400px" "300px" "center"\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ `(,blend-in-triangle-series

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,triangle-in-half-circle

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,translated-caption)))
  </script-input|<text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|font-shape|italic|<graphics|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.8pt|<cline|<point|-1.8|-0.3>|<point|2.2|-0.3>|<point|-0.8|1.43205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.6pt|<cline|<point|-1.6|-0.6>|<point|2.4|-0.6>|<point|-0.6|1.13205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.4pt|<cline|<point|-1.4|-0.9>|<point|2.6|-0.9>|<point|-0.4|0.83205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.2pt|<cline|<point|-1.2|-1.2>|<point|2.8|-1.2>|<point|-0.2|0.53205080756888>>>>>|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>>

  which will generate the drawing we have already seen in <modular-graphics>
  (Figure <reference|fig:bleding-waning-triangle>).

  <\big-figure>
    <\script-output|scheme|default>
      (begin\ 

      \ \ (define (blend-in-triangle delta)

      \ \ (translate-element \ \ (apply-property

      \ \ \ (apply-property

      \ \ \ triangle

      \ \ "dash-style" "101010")

      \ \ \ "line-width" (string-join\ 

      \ \ \ \ \ \ \ \ \ `(,(number-\<gtr\>string (- 1 delta)) "pt") ""))

      \ \ \ \ \ \ \ \ \ `(,(* 1.0 delta) ,(* -1.5 delta))))

      \ \ (define delta-lst

      \ \ \ \ \ \ \ '(0.2 0.4 0.6 0.8))

      \ \ (define blend-in-triangle-series

      \ \ \ \ (map blend-in-triangle delta-lst))

      \ \ (scheme-graphics "400px" "300px" "center"\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ `(,blend-in-triangle-series

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,triangle-in-half-circle

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,translated-caption)))
    </script-output|<text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|font-shape|italic|<graphics|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.8pt|<cline|<point|-1.8|-0.3>|<point|2.2|-0.3>|<point|-0.8|1.43205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.6pt|<cline|<point|-1.6|-0.6>|<point|2.4|-0.6>|<point|-0.6|1.13205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.4pt|<cline|<point|-1.4|-0.9>|<point|2.6|-0.9>|<point|-0.4|0.83205080756888>>>>>|<with|color|red|line-width|1pt|<with|dash-style|101010|<with|line-width|0.2pt|<cline|<point|-1.2|-1.2>|<point|2.8|-1.2>|<point|-0.2|0.53205080756888>>>>>|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|0.45|-2.25>>>>>>>

    \;
  <|big-figure>
    The \Pblending in\Q/\Pwaning out\Q triangle of <hlink|Modular graphics
    with <name|Scheme>|./modular-scheme-graphics.tm> generated through a
    <name|Executable fold> environment.<label|fig:bleding-waning-triangle>
  </big-figure>

  <name|Executable fold>s are activated by pressing <key|Shift+Return>with
  the cursor positioned inside them, and are disactivated (displaying again
  the code) by positioning the cursor to their immediate right, pressing
  <key|Backspace> once and finally <key|Shift+Return> again<todo|can I
  improve this?>.

  The subsequent step is delegating all of the definitions (the ones we have
  written in <scheme> sessions in this document) to a file, which one can
  then <scm|load> inside an <name|Executable fold>, within a <scm|begin>
  whose last form evaluates to the drawing we want (for example using the
  <scm|scheme-graphics> function we have defined).

  In this way one separates the code into three parts:

  <\itemize>
    <item>the graphical commands, which are defined in <TeXmacs> modules and
    made available through the <markup|use-module> macro

    <item>the drawing itself, with its definitions, which is realized in a
    separate file which includes a symbol (function or variable) which
    evaluates to a <TeXmacs> drawing

    <item>the placement of the drawing into the document, which is realized
    through one of the means that <TeXmacs> provides, for example the
    <name|Executable fold> environment.
  </itemize>

  When applying the <scm|load> command in <scheme> one must be aware that
  <scheme> provides forms which run shell programs, and therefore can damage
  one's computer; because of this it is necessary to be aware of what one is
  <scm|load>ing, since it may not be in front of our eyes when we press the
  <key|return> key! This said, here is how a graphical file may look like (we
  are using the first drawing we made of a triangle, to keep the code short;
  copy the code in a file to use it):

  <\scm-code>
    \ \ (define pA (pt -2 0))

    \ \ (define pB (pt 2 0))

    \ \ (define xC (- (* 2 (cos (/ pi 3)))))

    \ \ (define yC (* 2 (sin (/ pi 3))))

    \ \ (define pC (pt xC yC))

    \ \ (define tA (pt -2.3 -0.5))

    \ \ (define tB (pt 2.1 -0.5))

    \ \ (define tC (pt (- xC 0.2) (+ yC 0.2)))

    \ \ 

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

    \ \ \ \ \ \ \ \ \ \ \ \ (text-at (TeXmacs) ,(pt -0.55 -0.75)))))

    \ \ 

    \ \ (define triangle-drawing

    \ \ \ \ (scheme-graphics "400px" "300px" "center"\ 

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ `(,half-circle

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,triangle

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,letters

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ,caption)))
  </scm-code>

  This defines the symbol <scm|triangle-drawing>, which evaluates to a
  <TeXmacs> drawing using the function <scm|scheme-graphics>\Vand depends on
  other functions which we defined with our modules (making some of them
  globally available). Assuming that the file is called
  <verbatim|triangle-drawing.scm>, and that it is available under that name
  in the document (full file names are advisable), the <name|Executable fold>
  now might be

  <\script-input|scheme|default>
    (begin

    \ \ (load "triangle-drawing.scm")

    \ \ triangle-drawing)
  </script-input|>

  yielding, when activated, our by now familiar drawing of a triangle (Figure
  <reference|fig:triangle-with-external-files>).

  <\big-figure>
    <\script-output|scheme|default>
      (begin

      \ \ (load "resources/external-scheme-files/triangle-drawing.scm")

      \ \ triangle-drawing)
    </script-output|<text|<with|gr-geometry|<tuple|geometry|400px|300px|center>|font-shape|italic|<graphics|<with|color|black|<arc|<point|-2.0|0.0>|<point|-1.0|1.73205080756888>|<point|2.0|0.0>>>|<with|color|black|<line|<point|-2.0|0.0>|<point|2.0|0.0>>>|<with|color|red|line-width|1pt|<cline|<point|-2.0|0.0>|<point|2.0|0.0>|<point|-1.0|1.73205080756888>>>|<with|color|black|<text-at|A|<point|-2.3|-0.5>>>|<with|color|black|<text-at|B|<point|2.1|-0.5>>>|<with|color|black|<text-at|C|<point|-1.2|1.93205080756888>>>|<with|color|blue|font-shape|upright|<text-at|<TeXmacs>|<point|-0.55|-0.75>>>>>>>

    \;
  <|big-figure>
    The \Ptriangle drawing\Q generated with external
    files.<label|fig:triangle-with-external-files>
  </big-figure>

  I myself use <name|emacs> with <name|paredit> for the editing of <TeXmacs>
  <scheme> files. The highlighting of keywords defined by <TeXmacs> is
  possible with the <verbatim|tm-mode.el> file located in
  <verbatim|$TEXMACS_PATH/progs/tm-mode.el>, that can be loaded adding to
  your <verbatim|.emacs> the following line:

  <\scm-code>
    (load (substitute-in-file-name "$TEXMACS_PATH/progs/tm-mode.el"))
  </scm-code>

  It can be loaded unconditionally (as the above command does), as it
  contains the following line

  <\scm-code>
    (add-hook 'scheme-mode-hook '(lambda () (texmacs-style)))
  </scm-code>

  which takes care of the conditional loading of <verbatim|texmacs-style> as
  a minor mode for <scheme> files.<todo|is it a minor mode? Why don't I see
  it in the list of minor modes? is it best to do it in this way? Am I not
  polluting the namespace of .emacs?>

  <todo|more on developing Scheme?>
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
    <associate|auto-2|<tuple|1|?>>
    <associate|auto-3|<tuple|1|?>>
    <associate|auto-4|<tuple|2|?>>
    <associate|auto-5|<tuple|1|?>>
    <associate|auto-6|<tuple|2|?>>
    <associate|auto-7|<tuple|3|?>>
    <associate|auto-8|<tuple|4|?>>
    <associate|auto-9|<tuple|5|?>>
    <associate|fig:bleding-waning-triangle|<tuple|1|?>>
    <associate|fig:triangle-with-external-files|<tuple|2|?>>
    <associate|sec:a-few-functions|<tuple|1|?>>
    <associate|sec:modularization|<tuple|2|?>>
    <associate|tab:functions-list|<tuple|1|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        The \Pblending in\Q/\Pwaning out\Q triangle of
        <locus|<id|%3A2EED8-6DC1AB8>|<link|hyperlink|<id|%3A2EED8-6DC1AB8>|<url|./modular-scheme-graphics.tm>>|Modular
        graphics with <with|font-shape|<quote|small-caps>|Scheme>> generated
        through a <with|font-shape|<quote|small-caps>|Executable fold>
        environment.
      </surround>|<pageref|auto-11>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        The \Ptriangle drawing\Q generated with external files.
      </surround>|<pageref|auto-12>>
    </associate>
    <\associate|table>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        The <with|font-shape|<quote|small-caps>|Scheme> functions for modular
        graphics we defined in <locus|<id|%3A2EED8-6EA0848>|<link|hyperlink|<id|%3A2EED8-6EA0848>|<url|./modular-scheme-graphics.tm>>|Modular
        graphics with <with|font-shape|<quote|small-caps>|Scheme>>
      </surround>|<pageref|auto-3>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|font-shape|<quote|small-caps>|<with|font-shape|<quote|small-caps>|Scheme>
      graphics with external files> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <pageref|auto-1><vspace|0.5fn>

      1.<space|2spc>A few functions in a single file (enough to compose
      complex objects) <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
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

      3.<space|2spc>Drawings as part of documents
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>
    </associate>
  </collection>
</auxiliary>