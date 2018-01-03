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
(define (checkerboard p)
  ; use let* to define bindings sequentially and not in parallel like the
  ; normal let otherwise bindings cannot refer to each other
  (let* ((whitecell (colorize p "WhiteSmoke"))
         (blackcell (colorize p "Black"))
         (block (checker whitecell blackcell))
         (block4 (four block)))
    (four block4)))
(checkerboard (square 10))
(checkerboard (filled-ellipse 10 10))

; functions are values just like numbers and pictures
; hence functions can accept other functions as argument
(define (series mk)
  (hc-append 4 (mk 5) (mk 10) (mk 20)))
; pass a picture to (serie)
(series circle)
; pass a function to (series)
(series square)
; passing anonymous functions as arguments is quite handy
(series (lambda (size) (checkerboard (square size))))
