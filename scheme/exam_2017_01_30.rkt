#lang racket

#| 1) Consider a list L and a natural number k. Define an iterator with a closure, which returns, in turn, all the
      contiguous sublists of L of length k, and a symbol 'end at the end. It is possible to use the function take
      provided by Racket, e.g. (take '(a b c) 2) is '(a b).
|#
(define (kiterator l k)
  (let [(curr l)
        (size (length l))]
    (lambda()
      (if (< size k)
          'end
          (begin
            (let [(s (take curr k))]
              (set! size (- size 1))
              (set! curr (cdr curr))
              s))))))

(define (checklist lst factors)
  (define k (length (car factors)))
  (define iter (kiterator lst k))
  (foldl
   (lambda (x r)
     (let ((curr (iter)))
       (if (member curr (cons 'end factors))
           r
           (cons curr r))))
   '()
   lst))
  