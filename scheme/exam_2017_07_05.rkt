#lang racket
#| (struct bintree
  [(value #:mutable)
   (left #:mutable)
   (right #:mutable)])

(define t1 (bintree 3
                 (bintree 1
                       (bintree 0 null null)
                       (bintree 2 null null))
                 (bintree 4 null null)))

;(displayln (bintree-value (bintree-left t1))) ; display the value of the left child of root node

(define (tmap! fn bt)
  (unless (null? bt)
    (set-bintree-value! bt (fn (bintree-value bt)))
    (tmap! fn (bintree-left bt))
    (tmap! fn (bintree-right bt))))

;(tmap! (lambda (x) (+ 1 x)) t1)
;(displayln (bintree-value (bintree-left (bintree-left t1)))) ; display the value of the left child of root node

#|(define (reverse-visit bt)
  (let [(l '())]
    (displayln (bintree-value bt))
    (displayln (bintree-left bt))
    (when (and (null? (bintree-left bt)) (null? (bintree-right bt)))
      (cons (bintree-value bt) l))
    (when (null? (bintree-right bt))
      (reverse-visit (bintree-left bt)))
    (when (null? (bintree-left bt))
      (reverse-visit (bintree-right bt)))
    (unless (null? bt)
      (reverse-visit (bintree-left bt))
      (reverse-visit (bintree-right bt))
      (displayln l))))|#

(define (reverse-visit bt)
  (cond
    [(null? bt) '()]
    [(append (list (bintree-value bt))
             (reverse-visit (bintree-left bt))
             (reverse-visit (bintree-right bt)))]))

(reverse-visit t1) |#
                   
#| SOLUTIONS |#

(struct branch ((left #:mutable)
                (right #:mutable)))

(struct leaf ((val #:mutable)))

(define (tmap! fn node)
  (cond
    [(leaf? node) (set-leaf-val! node (fn (leaf-val node)))]
    [(branch? node) (begin
                      (tmap! fn (branch-left node))
                      (tmap! fn (branch-right node)))]))

(define t1 (branch (branch (leaf 1)(leaf 2))(leaf 3)))
(leaf-val (branch-left (branch-left t1)))
(leaf-val (branch-right (branch-left t1)))
(leaf-val (branch-right t1))

;(tmap! (lambda (x) (+ x 1)) t1)
;(leaf-val (branch-right t1))

(define (reverse-visit tree)
  (cond
    [(leaf? tree) (list (leaf-val tree))]
    [(branch? tree) (append (reverse-visit (branch-right tree))
                            (reverse-visit (branch-left tree)))]))
(reverse-visit t1)

(define (reverse! tree)
  (let [(vals (reverse-visit tree))]
    (tmap! (lambda (x)
             (let [(v (car vals))]
               (set! vals (cdr vals))
               v))
           tree)))

(reverse! t1)
(leaf-val (branch-left (branch-left t1)))
(leaf-val (branch-right (branch-left t1)))
(leaf-val (branch-right t1))