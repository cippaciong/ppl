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

(+ 3
   (call/cc
    (lambda (exit)
      (for-each (lambda (x)
                  (when (negative? x)
                    (exit x)))
                '(0 1 2 3 -4 5))
      10)))
-1

(define saved-cont #f) ; place to save the continuation
(define (test-cont)
  (let ([x 0])
    (call/cc (lambda (k)
               (set! saved-cont k))) ; we save this point of execution in saved-cont
    (set! x (+ x 1))
    (displayln x)))
(test-cont) ;1
(saved-cont) ;2
(saved-cont) ;3

(call/cc (lambda (_) (+ 3 4))) ;7
(call/cc (lambda (cc) cc)) ;#<continuation>
(+ 2 (call/cc (lambda (cc) (+ 30 (cc 10))))) ;12
(+ 2 (call/cc (lambda (cc) (+ 30 (cc (+ 2 10)))))) ;14
(+ 2 (call/cc (lambda (cc) (cc (+ 30 10))))) ;42
(+ 2 (call/cc (lambda (cc) (+ 30 (cc 10) 2)))) ;12

(define (save! x)
  (call/cc (lambda (cc) (set! sc cc) x)))
(define sc #f)
(+ 1 (+ (+ (save! 3)) 2)) ;6
(sc 10) ;13
(sc) ;. . result arity mismatch;
(sc 1) ;4
(sc (+ 10 1)) ;14
(sc (+ 10 (sc 1))) ;4
(define *handlers* (list))


;; Exceptions
(define (push-handler proc)
  (set! *handlers* (cons proc *handlers*)))
(define (pop-handler)
  (let ([h (car *handlers*)])
    (set! *handlers* (cdr *handlers*))
    h))
(define (throw x)
  (cond
    [(pair? *handlers*) ((pop-handler) x)]
    [else (apply error x)]))
(define-syntax try
  (syntax-rules (catch)
    ((_ exp1 ...
        (catch what hndlr ...))
     (call/cc (lambda (exit)
                ; install the handler
                (push-handler (lambda (x)
                                (cond
                                  [(equal? x what) (exit (begin hndlr ...))]
                                  [else (throw x)])))
                (let ((res ;; evaluate the body
                       (begin exp1 ...)))
                  ; ok: discard the handler
                  (pop-handler)
                  res))))))

; Define a function throwing the hello exception
(define (foo x)
  (display x) (newline)
  (throw "hello"))

; Single catch for hello
(try
 (displayln "Before foo")
 (foo "hi!")
 (displayln "After foo")
 (catch "hello"
   (displayln "I caught a throw")
   #f))
; Before foo
; hi!
; I caught a throw
; #f

; Single catch that doesn't catch hello gives an error
; because we don't handle the exception properly
(try
 (displayln "Before foo")
 (foo "hi!")
 (displayln "After foo")
 (catch "hell"
   (displayln "I caught a throw")
   #f))
; Before foo
; hi!
; . . apply: contract violation
  ; expected: list?
  ; given: "hello"
  ; argument position: 2nd
  ; other arguments...:

; Catch the "hell" exception before the "hello" one
(try
 (displayln "Before foo")
 (foo "hi!")
 (displayln "After foo")
 (catch "hell"
   (displayln "I caught a throw")
   #f)
 (catch "hello"
   (displayln "I caugth an hello throw")
   #f))
; Before foo
; hi!
; I caugth an hello throw
; #f