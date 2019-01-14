#lang racket

(define (urmax l)
  (define (urmax-tail lst index m)
    (cond
      [(null? lst) m]
      [else (let [(x (car lst))
                  (xs (cdr lst))]
              (urmax-tail xs
                          (+ 1 index)
                          (max m (list-ref x index))))]))
  (urmax-tail l 0 (car (car l))))

(urmax '((10)(1 2)(1 2 3)(10 2 3 -4)))

(define (listreflen l)
  (list-ref l (- (length l) 1)))

(define (highermax l)
  (foldl (lambda (lst m)
           (max (listreflen lst) m)) (car (car l)) l))

(highermax '((-1)(1 2)(1 2 3)(10 2 3 -4)))
  