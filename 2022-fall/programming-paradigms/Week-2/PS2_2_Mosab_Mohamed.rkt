#lang slideshow

;Exercise 1.a
(define (pow n m)
  (define (helper current rem)
    (cond
      [(= rem 0)
       current]
      [else
       (helper (* current n) (- rem 1))]
      )
    )
  (helper 1 m)
  )
(define (binary-to-decimal lst) 
  (define (helper current lst)
    (cond
      [(empty? lst)
       current]
      [(= (first lst) 1)
       (helper (+ current (pow 2 (- (length lst) 1))) (rest lst))]
      [else
       (helper current (rest lst))]
    )
  )
  (helper 0 lst)
)

(binary-to-decimal '(1 0 1 1 0))

;Exercise 1.b
(define (count-zeros lst)
  (define (helper lst flag sum)
    (cond
      [(empty? lst)
       sum]
      [(and (= flag 0) (= 0 (first lst)))
            (helper (rest lst) 0 0)]
      [(and (= flag 0) (= 1 (first lst)))
            (helper (rest lst) 1 0)]
      [(and (= flag 1) (= 0 (first lst)))
            (helper (rest lst) 1 sum)]
      [(and (= flag 1) (= 1 (first lst)))
            (helper (rest lst) 1 (+ sum 1))]
    )
  )
  (helper lst 0 0)
)

(count-zeros '(0 0 0 1 0 1 1 0)) 

;Exercise 1.c
(define (encode-with-lengths lst)
  (define (helper lst current flag sum)
    (cond
      [(empty? lst)
       (reverse (cons sum current))]
      [(and (= flag 0) (= 0 (first lst)))
            (helper (rest lst) current 0 0)]
      [(and (= flag 0) (= 1 (first lst)))
            (helper (rest lst) current 1 1)]
      [(and (= flag 1) (= 0 (first lst)))
            (helper (rest lst) (cons sum current) 2 1)]
      [(and (= flag 1) (= 1 (first lst)))
            (helper (rest lst) current 1 (+ sum 1))]
      [(and (= flag 2) (= 0 (first lst)))
            (helper (rest lst) current 2 (+ sum 1))]
      [(and (= flag 2) (= 1 (first lst)))
            (helper (rest lst) (cons sum current) 1 1)]
    )
  )
  (helper lst '() 0 0)
)

(encode-with-lengths '(0 0 0 1 1 0 1 1 1 0 0))

;Exercise 1.d
(define (binary-odd? lst)
  (= 1 (remainder (binary-to-decimal lst) 2))
)   

(binary-odd? '(1 0 1 1 0))
(binary-odd? '(1 0 1 1 1))

;Exercise 1.e
(define (remove-leading-zeros lst)
  (define (helper current output flag)
    (cond
      [(empty? current)
       (reverse output)]
      [(= flag 0)
       (cond
         [(= (first current) 0)
          (helper (rest current) output 0)]
         [else
          (helper (rest current) (cons (first current) output) 1)]
       )]
      [else
       (helper (rest current) (cons (first current) output) 1)]
    )
  )
  (helper lst '() 0)
)
(define (decrement lst)
  (define (helper current output flag)
    (cond
      [(empty? current)
       (cond
         [(= flag 0)
          '(0)]
         [else
          output]
       )]
      [(= flag 0)
       (cond
         [(= (first current) 0)
          (helper (rest current) (cons 1 output) 0)]
         [else
          (cond
            [(= (length (rest current)) 0)
             (helper (rest current) output 1)]
            [else
             (helper (rest current) (cons 0 output) 1)]
          )]
       )]
      [else
       (cond
         [(= (first current) 1)
          (helper (rest current) (cons 1 output) 1)]
         [else
          (helper (rest current) (cons 0 output) 1)]
       )]
    )
  )
  (helper (reverse (remove-leading-zeros lst)) '() 0)
)

(decrement '(1 0 1 1 0))
(decrement '(1 0 0 0 0))
(decrement '(0)) 

;Exercise 2.a
(define (alternating-sum lst)
  (cond
    [(empty? lst)
     0]
    [(= (length lst) 1)
     (first lst)]
    [else
     (+ (+ (first lst) (* -1 (second lst))) (alternating-sum (rest (rest lst))))]
  )
)

(alternating-sum (list 6 2 4 1 3 9)) 

;Exercise 2.b
(alternating-sum (list 1 2 3 4 5))
; Substitution Model:
; (alternating-sum (list 1 2 3 4 5))
; (alternating-sum '(1 2 3 4 5))
; (+ (+ 1 -2 ) (alternating-sum '(3 4 5)))
; (+ (+ 1 -2 ) (+ (+ 3 -4) (alternating-sum '(5))))
; (+ (+ 1 -2 ) (+ (+ 3 -4) 5))
; (+ -1 (+ -1 5))
; (+ -1 4)
; 3

 
;Exercise 2.c
; First of all using tail recursion is much more intuitive and easier implementation wise.
; Which results in better readability
; Furthermore it will be much more efficient because it will allow us to call the recursive function last and return its value directly
; Which results in avoid extra operations after each recursion call returns
; So essential we're avoiding adding stack frames to the call stack

;Exercise 3
(define (dec n)
  (- n 1))

(define (f n)
  (cond
    [(<= n 2)
     (- 10 n)]
    [else
     (* (f (dec (dec n))) (f (dec n)))]
  )
)

(f 3)
; Substitution Model:
; (f 3)
; (* (f (dec (dec n))) (f (dec n)))
; (* (f (dec (dec 3))) (f (dec 3)))
; (* (f (dec 2)) (f 2))
; (* (f 1) (f 2))
; (* 9 8)
; (* 9 8)
; 72




