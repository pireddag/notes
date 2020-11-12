<TeXmacs|1.99.14>

<style|<tuple|notes|html-font-size>>

<\body>
  <hrule>

  <\wide-tabular>
    <tformat|<cwith|1|1|1|1|cell-halign|c>|<table|<row|<\cell>
      <image|../resources/texmacs-blog-transparent.png|40pt|||>
    </cell>>>>
  </wide-tabular>

  <chapter*|Notes on TeXmacs>

  This is a blog/wiki about<nbsp><hlink|TeXmacs|http://www.texmacs.org/>. It
  aims to be a container for articles, snippets, comments, developer docs,
  proposals, user's pages, etc<text-dots>\ 

  You can find the <hlink|source repository|https://github.com/texmacs/notes>
  at <tt|github>. Feel free to fork it. Contribution are welcome, please
  check the <hlink|guidelines|editorial-guidelines.tm> before.

  <section*|Collections >

  <with|font-shape|italic|<small|These articles contain collections of stuff,
  additions are welcome.>>

  <hlink|Wishlist and additional functionalities|./wishlist.tm>

  <hlink|Awesome <TeXmacs>|./awesome-texmacs.tm>

  <hlink|Community links|community.tm>

  <section*|Miscellanea>

  <with|font-shape|italic|<small|Self-contained, one shot, material on
  various topics. Roughly, most recent articles on top.>>

  <hlink|An overview of <TeXmacs> from altitude|overview.tm>

  <hlink|Editorial guidelines|editorial-guidelines.tm>

  <hlink|Contribution guide|contribution-guide.tm>

  <hlink|A TikZ example with the <name|Graph> plugin|./a-tikz-example.tm>\ 

  <hlink|Tetris with <TeXmacs> tables|./tetris.tm>\ 

  <hlink|Embedding TikZ figures in a document|./embedding-tikz-figures-short.tm>

  <section*|Developers' notes>

  <hlink|Implementing previews for link targets|./previews.tm>

  <hlink|TeXmacs and HTML|tm-and-html.tm>

  \;

  <section*|Contributing>

  <\small>
    Make a pull request to the <hlink|source
    repository|https://github.com/texmacs/notes>. Typically it should just be
    necessary to modify or add to only the <code*|.tm> sources in the
    <tt|src/> directory and modify accordingly <tt|main.tm> (this document).
    \ This <hlink|template file|./template.tm> can be used for new articles.
    The HTML files are then generated by one of the maintainers after the
    pull request is merged (hopefully this will be automated in the near
    future). Once the changes are pulled in they will become immediately
    publicly visible on the website. Detailed instructions are available
    <hlink|here|./contribution-guide.tm>.
  </small>

  <hrule>

  \;
</body>

<\initial>
  <\collection>
    <associate|font-base-size|12>
    <associate|preamble|false>
  </collection>
</initial>

<\attachments>
  <\collection>
    <\associate|bib-bibliography>
      <\db-entry|+2E9XdEJ4gneMkXs|book|TeXmacs:vdH:book>
        <db-field|contributor|root>

        <db-field|modus|imported>

        <db-field|date|1604849819>
      <|db-entry>
        <db-field|author|J. van der <name|Hoeven>>

        <db-field|title|The Jolly Writer. Your Guide to GNU TeXmacs>

        <db-field|publisher|Scypress>

        <db-field|year|2020>
      </db-entry>
    </associate>
  </collection>
</attachments>

<\references>
  <\collection>
    <associate|auto-1|<tuple|?|?>>
    <associate|auto-2|<tuple|?|?>>
    <associate|auto-3|<tuple|?|?>>
    <associate|auto-4|<tuple|?|?>>
    <associate|auto-5|<tuple|?|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|font-shape|<quote|small-caps>|Notes
      on TeXmacs> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <pageref|auto-1><vspace|0.5fn>

      Collections \ <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>

      Miscellanea <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>

      Developers' notes <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>

      Contributing <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>
    </associate>
  </collection>
</auxiliary>