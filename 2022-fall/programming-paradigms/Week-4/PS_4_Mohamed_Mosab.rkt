#lang slideshow
;exercise 1.a
(define (replicate count expr)
  (cond
    [(= 1 count) (list expr)]
    [else (cons expr (replicate (- count 1) expr))]))

(replicate 10 'a)
;'(a a a a a a a a a a)
(replicate 3 '(1 . 2))
;'((1 . 2) (1 . 2) (1 . 2))

;exercise 1.b
;This produces a pair of 2 lists but not in the intended format
;"That is because '((a b) . (c d)) renders as '((a b) c d)" -Professor Kudasov (23/09/2022 19:32) Source:[F22] Programming Paradigms Telegram Group Chat
(define (split lst size) 
  (define (helper lst current size)
    (cond
      [(= size 0) (cons current lst)]
      [else (helper (rest lst) (append current (list (first lst))) (- size 1))]))
  (cond
    [(> size (length lst)) (helper lst '() (length lst))]
    [else (helper lst '() size)]))
(split '(1 2 3 4 5) 2)
;'((1 2) . (3 4 5))
(split '(a b c d) 4)
;'((a b c d) . ())
(split '(a b c) 4)
;'((a b c) . ())
(split '(a b c) 0)
;'(() . (a b c))

;exercise 1.c
(define (chunks lst chunk-size)
  (define (helper lst current chunk-size)
    (cond
      [(<= (length lst) chunk-size) (append current (list lst))]
      [else (helper (cdr (split lst chunk-size)) (append current (list (car (split lst chunk-size)))) chunk-size)]))
  (helper lst '() chunk-size))
(chunks '(1 2 3 4 5) 2)
; '((1 2) (3 4) (5))
(chunks '(a b c d e f) 3)
; '((a b c) (d e f))

;exercise 1.d
(define (windows lst size)
  (define (helper lst current size)
    (cond
      [(= (length lst) size) (append current (list lst))]
      [else (helper (rest lst) (append current (list (car (split lst size)))) size)]))
  (helper lst '() size))
(windows '(1 2 3 4 5) 2)
; '((1 2) (2 3) (3 4) (4 5))
(windows '(a b c d e) 3)
; '((a b c) (b c d) (c d e))


;exercise 2.a
(define (pairs lst)
  (first (foldl
        (lambda (x y)
          (cond
            [(empty? (rest y)) y]
            [else (cons  (append (first y) (map (lambda (z) (cons x z)) (rest y))) (rest (rest y)) )]))
        (cons '() (rest lst)) lst)))

(pairs '(a b c d))
'((a . b) (a . c) (a . d) (b . c) (b . d) (c . d))

;exercise 2.b
;please refer to the note written in exercise 1.b
(define (splits lst)
  (map
   (lambda (x) (split lst x)) (inclusive-range 0 (length lst))))

(splits '(a b c))
'(((a b c) . ()) ((a b) . (c)) ((a) . (b c)) (() . (b c)))

;exercise 2.c
(define (pair-product p)
  (* (car p) (cdr p)))

(define (max-product lst)
  (foldl
   (lambda (x y)
     (cond
       [(or (empty? y)(> (pair-product x) (pair-product y))) x]
       [else y]))
   '() (pairs lst)))

(max-product '(1 2 3 4 3 2 1))
'(3 . 4)

;exercise 2.d
(define (binary-op op p)
  (op (car p) (cdr p)))

(define (max-binary-op op lst)
  (foldl
   (lambda (x y)
     (cond
       [(or (empty? y)(> (binary-op op x) (binary-op op y))) x]
       [else y]))
   '() (pairs lst)))

(max-binary-op * '(1 2 3 4 3 2 1))
'(3 . 4)
(max-binary-op - '(1 2 3 4 3 2 1))
'(4 . 1)

;exercise 2.e
(define (combine element lst)
  (append lst (map
               (lambda (x) (append x (list element)))
               lst)))

(define (combinations lst size)
  (filter (lambda (x) (= (length x) size))
          (foldl
           (lambda (x y) (combine x y))
           '(()) lst)))

(combinations '(a b c d) 3)
'((a b c) (a b d) (a c d) (b c d))

;exercise 3.a
(define (max lst)
  (foldl
   (lambda (x state)
     (cond
       [(> x state) x]
       [else state]))
     0 lst))

(max '(1 5 3 6 2 0))
6

;exercise 3.b
(define (second-max lst)
  (cdr (foldl
   (lambda (x state)
     (cond
       [(> x (car state)) (cons x (car state))]
       [(> x (cdr state)) (cons (car state) x)]
       [else state]))
     '(0 0) lst)))
(second-max '(1 5 3 6 2 0))
5

;exercise 3.c
(define (third-max lst)
  (cdr (cdr (foldl
   (lambda (x state)
     (cond
       [(> x (car state)) (cons x (cons (car state) (car (cdr state))))]
       [(> x (car (cdr state))) (cons (car state) (cons x (car (cdr state))))]
       [(> x (cdr (cdr state))) (cons (car state) (cons (car (cdr state)) x))]
       [else state]))
     '(0 0 0) lst))))

;we use previous 2 functions because they use foldl
(define (top-3 lst)
  (cond
    [(= (length lst) 1) (max lst)]
    [(= (length lst) 2) (list (max lst) (second-max lst))]
    [else (list (max lst) (second-max lst) (third-max lst))]))
(top-3 '(5 3 6 2 8 1 0))
'(5 6 8)

;exercise 3.d
(define (group lst)
  (foldl
   (lambda (curr state)
     (cond
       [(empty? (first state)) (list (cons curr '()))]
       [(eq? (first (first (reverse state))) curr)
        (append
         (reverse (rest (reverse state)))
         (list (reverse (append (list curr) (first (reverse state))))))]
       [else (append state (list (list curr)))]))
   '(()) lst))

(group '(a b b c c c b a a))

;exercise 3.e
(define (cumulative-sums lst)
  (car (foldl
   (lambda (curr state)
     (list (append (first state) (list (+ curr (second state)))) (+ curr (second state))))
   '((0) 0) lst)))

(cumulative-sums '(1 2 3 4 5))
'(0 1 3 6 10 15)
