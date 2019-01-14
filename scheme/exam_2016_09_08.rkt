#lang racket
; Define a procedure, called genFig, which takes a natural number n and returns the picture of L with side n.

'((1 0) (0 1))

(define (genRow pos len)
  (let [(ret (foldl
              (lambda (i v)
                (cond
                  [(eq? pos (- len (+ 1 i)))
                   (cons 1 v)]
                  [else
                   (cons 0 v)])) '() (range len)))]
    ret))
  

(define (genFig n)
  (map (lambda (x)
         (genRow x n)) (range n)))

(genFig 2)
(genFig 3)
(genFig 5)

