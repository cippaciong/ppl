#lang racket
(define fun (lambda (x) (+ 1 x)))
(map (lambda (x fn) (fn x)) '(1 2 3) (list fun fun fun))

(define (ftree treef tree)
  (cond
    [(null? treef) tree]
    [(cons? treef)
     (cons (ftree (car treef) (car tree))
           (ftree (cdr treef) (cdr tree)))]
    [else (treef tree)]))

(define f1 (lambda (x) (+ 1 x)))
(define f2 (lambda (x) (* 2 x)))
(define f3 (lambda (x) (- x 10)))
(define f4 (lambda (x) (string-append "<<" x ">>")))
(define t1 '(1 (2 3 4) (5 (6)) ("hi!" 8)))
(define o1 `(,f1 (,f1 ,f2 ,f1) (,f3 (,f1)) (,f4 ,f3)))
(define o2 `(,f1 () (,f3 (,f1)) (,f4 ,f3)))
(ftree o1 t1) ; must return (2 (3 6 5) (-5 (7)) (<<hi!>> -2))
(ftree o2 t1) ; must return (2 (2 3 4) (-5 (7)) (<<hi!>> -2))
