#lang racket
; Define a data structure for Clists (hint: use struct), together with a constructor for an empty Clist, and a
; variant of the cons operation for Clists, which adds a new element as the head of the previous Clist.

(struct clist (val ptr) #:mutable)

(define (empty-clist)
  (let [(c (clist '-end- null))]
    (set-clist-ptr! c c)
    c))

(define (ccons e l)
  (let [(x (clist e l))]
    (define (traverse h l)
      (if (eq? '-end- (clist-val l))
          (set-clist-ptr! l x)
          (ccons x (clist-ptr l))))
    (traverse x l)
    x))
        
(define clst (ccons 0 (ccons 1 (empty-clist))))

(displayln (clist-val clst))
(displayln (clist-val (clist-ptr clst)))
(displayln (clist-val (clist-ptr(clist-ptr clst))))

(let* [(end (empty-clist))
       (middle (clist 1 end))
       (head (clist 0 middle))]
  (displayln (clist-val head))
  (displayln (clist-val (clist-ptr head)))
  (displayln (clist-val (clist-ptr(clist-ptr head)))))

(define (cmap fn cl)
  (unless (eq? '-end- (clist-val cl))
    (set-clist-val! cl (fn (clist-val cl)))
    (cmap fn (clist-ptr cl))))

(define clstm (ccons 2 (ccons 4 (empty-clist))))
(cmap (lambda (x) (* x x)) clstm)

(displayln (clist-val clstm))
(displayln (clist-val (clist-ptr clstm)))
(displayln (clist-val (clist-ptr(clist-ptr clstm))))
  