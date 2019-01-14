#lang racket
#|
Consider a procedure p that receives as input a list. Elements in the list are either numbers or strings, together with the two special
separators * and $.
For instance, L = (* 1 2 3 * $ “hello” * 1 * 7 “my” * 1 2 * “world” $).
Implement p as a tail recursive function that sums all the numbers found between two occurrences of * symbols, and concatenates
all the strings between occurrences of $, then returns the list of the resulting elements. Numbers and strings that are not between
the correct pair of separators are discarded.
E.g., in the case of L, the result should be (6 1 3 “hellomyworld”).
|#
(define (p l)
  (define (inner-p lst activesum activeconc summed conc res)
    (cond
      [(null? lst) res]
      [else
       (let [(x (car lst))
             (xs (cdr lst))]
         (cond
           [(and (eq? '* x) (not activesum))
            (inner-p xs (not activesum) activeconc 0 conc res)]
           [(and (eq? '* x) activesum)
            (inner-p xs (not activesum) activeconc 0 conc (append res (list summed)))]
           [(and (eq? '$ x) (not activeconc))
            (inner-p xs activesum (not activeconc) summed "" res)]
           [(and (eq? '$ x) activeconc)
            (inner-p xs activesum (not activeconc) summed "" (append res (list conc)))]
           [(and (number? x) (not activesum))
            (inner-p xs activesum activeconc summed conc res)]
           [(and (number? x) activesum)
            (inner-p xs activesum activeconc (+ x summed) conc res)]
           [(and (string? x) (not activeconc))
            (inner-p xs activesum activeconc summed conc res)]
           [(and (string? x) activeconc)
            (inner-p xs activesum activeconc summed (string-append conc x) res)]))]))
  (inner-p l #f #f 0 "" '()))

(define L '(* 1 2 3 * $ "hello" * 1 * 7 "my" * 1 2 * "world" $))
(p L) ;(6 1 3 “hellomyworld”)