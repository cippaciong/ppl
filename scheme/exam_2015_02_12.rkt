#lang racket
#|
Define a tail-recursive function split, which, given a list L and a number n, returns a vector of two elements:
the prefix sublist of L, with elements up to the n-th, and the remaining suffix.
E.g.
> (split ’(0 1 2 3 4) 2)
’#((0 1) (2 3 4))
|#

(define (split l n)
  (let [(subl (take l n))]
    (define (split-tail l n r)
      (cond
        [(eq? (length r) (- (length l) n))
         r]
        [else
         (split-tail l n (cdr r))]))
    (vector subl (split-tail l n l))))
  

(split '(0 1 2 3 4) 2)
(split '(0 1 2 3 4) 3)
(split '(0 1 2 3 4) 4)
(split '(3 4) 1)

#|
Use split to define the function 3-factors, which, given a list L, returns all the possible contiguous sublists
A, B, C, such that (equal? L (append A B C)). A,B,C, cannot be empty.
E.g.
> (3-factors ’(0 1 2 3 4))
’(((0 1 2) (3) (4))
((0 1) (2 3) (4))
((0 1) (2) (3 4))
((0) (1 2 3) (4))
((0) (1 2) (3 4))
((0) (1) (2 3 4)))
|#

(define (3-factors l)
  (let [(max (- (length l) 2))
        (cont '())]
    (set! cont (cons (vector-ref (split l max) 0) cont))
    cont))
    
(3-factors '(0 1 2 3 4))