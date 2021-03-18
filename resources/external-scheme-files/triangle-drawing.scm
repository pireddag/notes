(define pA (pt -2 0))
  (define pB (pt 2 0))
  (define xC (- (* 2 (cos (/ pi 3)))))
  (define yC (* 2 (sin (/ pi 3))))
  (define pC (pt xC yC))
  (define tA (pt -2.3 -0.5))
  (define tB (pt 2.1 -0.5))
  (define tC (pt (- xC 0.2) (+ yC 0.2)))
  
  (define triangle
    `(with "color" "red" "line-width" "1pt"
           (cline ,pA ,pB ,pC)))
  (define half-circle
    `((with "color" "black" (arc ,pA ,pC ,pB))
      (with "color" "black" (line ,pA ,pB))))
  (define letters 
    `((with "color" "black"  (text-at "A" ,tA))
      (with "color" "black"  (text-at "B" ,tB))
      (with "color" "black"  (text-at "C" ,tC))))
  (define caption
    `((with "color" "blue" "font-shape" "upright"
            (text-at (TeXmacs) ,(pt -0.55 -0.75)))))
  
  (define triangle-drawing
    (scheme-graphics "400px" "300px" "center" 
                     `(,half-circle
                       ,triangle
                       ,letters
                       ,caption)))
