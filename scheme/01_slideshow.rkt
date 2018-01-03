#lang slideshow
(define c (circle 10))
(define r (rectangle 10 20))
(define (square n)
  (filled-rectangle n n))

; define the four function to stack four pictures horizontally and vertically
(define (four p)
  (define two-p (hc-append p p))
  (vc-append two-p two-p))

; define the checker function to stack two figures horizontally and vertically
; swapping them in the bottom row
(define (checker p1 p2)
  (let ((p12 (hc-append p1 p2))
        (p21 (hc-append p2 p1)))
    (vc-append p12 p21)))

; create a full fledged check board
; let's begin defining a board block
(define block (checker (colorize (square 10) "WhiteSmoke")
                       (colorize (square 10) "Black")))
; now let's put them together appending them horizontally and vertically
(vc-append (hc-append block block block)
           (hc-append block block block)
           (hc-append block block block))

; a better implementation is to create a checkboard function using
; previous functions (checker) and (four)
(define (checkboard p)
  (let* ((whitecell (colorize p "WhiteSmoke"))
         (blackcell (colorize p "Black"))
         (block (checker whitecell blackcell))
         (block4 (four block)))
    (four block4)))
(checkboard (square 10))
(checkboard (filled-ellipse 10 10))