#lang racket
(define (minimum L)
  (let ([x (car L)]
        [xs (cdr L)])
    (if [null? xs]
        x
        (if [< x (car xs)]
            (minimum (cons x (cdr xs)))
            (minimum xs)))))

(define (minimum_varadic x . xs)
  (if [null? xs]
      x
      (if [< x (car xs)]
          (apply minimum_varadic (cons x (cdr xs)))
          (apply minimum_varadic (cons (car xs) (cdr xs))))))

; Not tail-recursive factorial
(define (_factorial n)
  (if [= n 0]
      1
      (* n (_factorial (- n 1)))))

; Tail-recursive factorial
(define (fact n)
  (define (tail-fact n accum)
    (if [= n 0]
        accum
        (tail-fact (- n 1) (* n accum))))
  (tail-fact n 1))
