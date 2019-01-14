#lang racket
(define (check-this l)
  (define (check-tail l stack num)
    (if (null? l)
        num
        (let [(x (car l))
              (xs (cdr l))]
          (cond
            [(eq? x 'a)
             (check-tail xs (cons 'b stack) num)]
            [(eq? x 1)
             (check-tail xs (cons 2 stack) num)]
            [(eq? x 'b)
             (if (or (null? stack) (not (eq? 'b (car stack))))
                 #f
                 (check-tail xs (cdr stack) (+ 1 num)))]
            [(eq? x 2)
             (if (or (null? stack) (not (eq? 2 (car stack))))
                 #f
                 (check-tail xs (cdr stack) (+ 1 num)))]
            [else
             (check-tail xs stack num)]))))
  (check-tail l '() 0))

(check-this '(a b a b))
(check-this '(h e l l o))
(check-this '(6 h a b a 1 h h i 2 b z)) ; 3
(check-this '(6 h a b a 1 h h i b z 2)) ; #f