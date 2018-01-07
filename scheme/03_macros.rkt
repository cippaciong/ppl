#lang racket

;; Macros

; while loop
(define-syntax while
  (syntax-rules ()
    ((_ condition body ...)
     (let loop ()
       (when condition
         (begin
           body ...
           (loop)))))))

(let ([x 10])
  (while (> x 0) (display x) (newline) (set! x (- x 1))))

; for with break using continuations
(define-syntax For
  (syntax-rules (from to break: do)
    ((_ var from min to max break: break-sym
        do body ...)
     (call/cc
      (lambda (break-sym)
        (let ([inc (if (< min max) + -)])
          (let loop ((var min))
            body ...
            (unless (= var max)
              (loop (inc var 1))))))))))
(For i from 1 to 10 break: stacca-stacca
     do
     (displayln i)
     (when (= i 5)
       (stacca-stacca)))