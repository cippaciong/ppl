#lang slideshow
(define c (circle 10))
(define r (rectangle 10 20))
(define (square n)
  (filled-rectangle n n))

; define the checker function
(define (checker p1 p2)
  (let ((p12 (hc-append p1 p2))
        [p21 (hc-append p2 p1)])
    (vc-append p12 p21)))

; invoke the checker funcion to creare a 2x2 red and black checker
;(checker (colorize (square 10) "red")
;         (colorize (square 10) "black"))

; create a full fledged check board
; let's begin defining a board block
(define block (checker (colorize (square 10) "WhiteSmoke")
                       (colorize (square 10) "Black")))
; now let's put them together appending them horizontally and vertically
(vc-append (checker (hc-append block block)
                      (hc-append block block))
             (checker (hc-append block block)
                      (hc-append block block)))