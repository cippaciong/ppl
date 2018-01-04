#lang racket

(apply + (list 1 2 3 4 5))
(apply + '(1 2 3 4 5))
(list 1 2)

(length (list "hop" "skip" "jump"))

(list-ref (list "hop" "skip" "jump") 0)

(list-ref (list "hop" "skip" "jump") 1)

(append (list "hop" "skip") (list "jump"))

; (append (list "hop" "skip") "jump")

(append (list "hop" "skip") (list "jump") (list "run"))

(member "fall" (list "hop" "skip" "jump"))
; #f

(member "skip" (list "hop" "skip" "jump"))
; '("skip" "jump")

(reverse (list "hop" "skip" "jump"))

; Map
(map sqrt (list 1 4 9 16))
; '(1 2 3 4)

(map (lambda (n) (+ 1 n)) (list 1 2 3 4))
; '(2 3 4 5)

(map (lambda (f s) (+ f s)) (list 1 2 3 4) (list 1 2 3 4))
; '(2 4 6 8)

(map (lambda (f s) (+ f s)) (list 1 2 3 4 5) (list 1 2 3 4 5))
; '(2 4 6 8 10)

(map (lambda (n s) (string-append (~a n) ": " s)) (list 1 2 3) (list "apple" "banana" "coconut"))
; '("1: apple" "2: banana" "3: coconut")

(map (lambda (l e) (list-ref l e)) (list (list "apple" "banana" "coconut") (list "banana" "apple" "coconut") (list "banana" "coconut" "apple")) (list 0 1 2))
; '("apple" "apple" "apple")

;ormap andmap
(andmap positive? (list 1 2 3 -8 4 5 6 -1)) ; #f
(ormap positive? (list 1 2 3 -8 4 5 6 -1)) ; #t
(andmap string? (list "apple" "banana" "coconut")) ; #t

; Filter
(filter positive? (list 1 2 3 -1 -2 42)) ; '(1 2 3 42)
(filter string? (list 1 2 "apple" "banana" #\a)) ; '("apple" "banana")

; Foldl
(foldl (lambda (elem accum)
         (+ accum (* elem elem)))
       0
       (list 1 2 3 4))

; 

; Minimum implementations using first and rest (car and cdr)
(define (minimum list)
  (let ([head (first list)]
        [tail (rest list)])
  (if [empty? tail] ; is tail = ()?
      head          ; then: return head
      (minimum      ; else: call minimum recursively placing the minumim between
                    ; head and (first tail) at the beginning of the new list
       (cons (if [< head (first tail)]
                 head
                 (first tail))
             (rest tail))))))
(minimum (list 3 5 6 73 1 23 4)) ;1
(minimum (list 3 5 6 23 4)) ;3

; another implementation
(define (minimum1 list)
  (let ([head (first list)]
        [tail (rest list)])
  (if [empty? tail] ; is tail = ()?
      head          ; then: return head
      (minimum      ; else: call minimum recursively placing the minumim between
                    ; head and (first tail) at the beginning of the new list
       (if [< head (first tail)]     ; if head < first element of tail
           (cons head (rest tail))   ; then: call recursively replacing the first element of tail with head
           tail)))))                 ; else: discard head and call recusrively with tail
(minimum1 (list 3 5 6 73 1 23 4)) ;1
(minimum1 (list 3 5 6 23 4)) ;3