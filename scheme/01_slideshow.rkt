#lang slideshow
;; define variables or functions
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


;; functions are values just like numbers and pictures
;; hence functions can accept other functions as argument
(define (series mk)
  (hc-append 4 (mk 5) (mk 10) (mk 20)))
; pass a picture to (serie)
(series circle)
; pass a function to (series)
(series square)
; passing anonymous functions as arguments is quite handy
(series (lambda (size) (checkerboard (square size))))


;; Lexical Scope
;; lexical scope of an identifier depends on his textual environment
; the uses mk in each lambda refer to the argument of rgb-series
; since that's the binding that is textually in scope
(define (rgb-series mk)
  (vc-append
   (series (lambda (sz) (colorize (mk sz) "red")))
   (series (lambda (sz) (colorize (mk sz) "green")))
   (series (lambda (sz) (colorize (mk sz) "blue")))))

(rgb-series circle)
(rgb-series square)

; rgb-maker takes a function and returns a new one that
; remembers and uses the original function (the one passed as args)
(define (rgb-maker mk)
  (lambda (sz)
    (vc-append (colorize (mk sz) "red")
               (colorize (mk sz) "green")
               (colorize (mk sz) "blue"))))
(series (rgb-maker circle))
(series (rgb-maker square))

; some intricated examples of lexical scoping using let, let* and display
; (~a x "\n") is to convert x to string and contatenate it to "\n"
(let ((x 1))
  (let ((x 2))
    (let ((x 3) (f (lambda ()
               (display (~a x "\n")))))
      (f)))) ; prints 2

(let ((x 1))
  (let ((x 2))
    (let* ((x 3) (f (lambda ()
               (display (~a x "\n")))))
      (f)))) ; prints 3

(let ((x 1))
  (let ((x 2))
    (let ((x 3) (f (lambda ()
             (display x))))
      (f)
      (let ((g (lambda ()
                 (display (~a x "\n")))))
        (g))))) ; prints 23

;; Lists
(list "red" "green" "blue")
(list (circle 10) (square 10))

; map takes one element of the list at a time and applies a function
(define (rainbow p)
  (map (lambda (color)
         (colorize p color))
       (list "red" "orange" "yellow" "green" "blue" "purple")))
(rainbow (square 15))

; apply takes all the elements of the list and applies a function
; such function must take any number of arguments (like vc-append)
; note that you must use apply because vc-append doeas not accept a list
; as an argument but many arguments
(apply vc-append (rainbow (square 10)))