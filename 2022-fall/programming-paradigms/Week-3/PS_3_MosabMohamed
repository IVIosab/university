#lang slideshow

;Exercise 1.a
(define (binary-to-decimal bits)
  (foldl 
   (lambda (bit res) 
     (+ bit (* 2 res))) 
   0
   bits))

(binary-to-decimal '(1 0 1 1 0))
22

;Exercise 1.b
(define (remove-leading-zeros bits)
  (reverse
   (foldl 
    (lambda (bit res) 
      (cond
        [(and (= 0 bit) 
              (empty? res)) 
         res] 
        [else 
         (cons bit res)])) 
    '()
    bits)))

(remove-leading-zeros '(0 0 0 1 0 1 1 0))
'(1 0 1 1 0)

;Exercise 1.c
(define (count-zeros bits)
  (apply + 
         (map (lambda (x) (- 1 x)) 
              (remove-leading-zeros bits))))

(count-zeros '(0 0 0 1 0 1 1 0)) 
2

;Exercise 1.d
(define (group-consecutive bits)
  (reverse
   (foldl 
    (lambda (bit groups) 
      (cond
        [(empty? groups) 
         (list (list bit))]
        [(equal? bit 
                 (first (first groups)))
         (cons (cons bit (first groups))
               (rest groups))]
        [else
         (cons (list bit) groups)]))
    '()
    bits)))

(group-consecutive '(0 0 0 1 0 1 1 0))
'((0 0 0) (1) (0) (1 1) (0))

;Exercise 1.e
(define (encode-with-lengths bits)
  (map length 
       (group-consecutive 
        (remove-leading-zeros bits))))

(encode-with-lengths '(0 0 0 1 1 0 1 1 1 0 0)) 
 '(2 1 3 2)

;Exercise 1.f
(define (decode-with-lengths lengths)
  (cdr 
   (foldl 
    (lambda (n state) 
      (cons (- 1 (car state)) 
            (append (cdr state)       
                    (make-list n (car state)))))
    '(1 . ()) 
    lengths)))

(decode-with-lengths '(2 1 3 2))
'(1 1 0 1 1 1 0 0)

;Exercise 2.a
(define employees
  '(("John" "Malkovich" . 29)
    ("Anna" "Petrova" . 22)
    ("Ivan" "Ivanov" . 23)
    ("Anna" "Karenina" . 40)))

(define (fullname employee)
  (cons (car employee)
        (car (cdr employee))))

(fullname '("John" "Malkovich" . 29))
'("John" . "Malkovich")

;Exercise 2.b
(define (annas employees)
  (filter
   (lambda (employee)
     (equal? "Anna" (car employee)))
   employees))

(annas employees)
'(("Anna" "Petrova" . 22) ("Anna" "Karenina" . 40))

;Exercise 2.c
(define (age employee) 
    (cdr (cdr employee))) 

(define (over-25 employee) 
    (> (age employee) 25))   

(define (employees-over-25 employees)
  (map fullname 
       (filter over-25 employees))) 

(employees-over-25 employees)
'(("John" . "Malkovich") ("Anna" . "Karenina"))

;Exercise 3
;(define (remove-odd values) (filter even? values))
;(define (sum-even values)
;  (cond
;    [(empty? values) 0]
;    [(even? (first values))
;     (+ (first values) (sum (rest values)))]
;    [else
;     (sum (rest values))]))

;(a) (apply + (remove-odd xs)) ≡ (sum-even xs) (inductive hypothesis)
;(b) for all p, y, ys, the following expressions are equivalent:
;      • (filter p (cons y ys))
;      • (cond
;          [(p y) (cons y (filter p ys))]
;          [else (filter p ys)])
;(c) for all y, ys, (apply + (cons y ys)) ≡ (+ y (apply + ys))
;(d) for all f, c1, c2, e1, e2, the following expressions are equivalent:
;      • (f (cond [c1 e1] [c2 e2]))
;      • (cond [c1 (f e1)] [c2 (f e2)])

;  (apply + (remove-odd (cons x xs)))
;= (apply + (filter even? (cons x xs)))
;
;reference: (b) 
;= (apply + (cond [(even? x)
;                  (cons x (filter even? xs))]
;                 [else (filter even? xs)]))
;
;= (apply + (cond [(even? x)
;                  (cons x (remove-odd xs))]
;                 [else (remove-odd xs)]))
;
;reference: (d)
;= (cond [(even? x)
;         (apply + (cons x (remove-odd xs)))]
;        [else (apply + (remove-odd xs))])
;
;reference: (c)
;= (cond [(even? x)
;         (+ x (apply + (remove-odd xs)))]
;        [else (apply + (remove-odd xs))])
;
;reference: (a)
;= (cond [(even? x)
;         (+ x (sum-even xs))]
;        [else (sum-even xs)])
;
;= (cond 
;    [(empty? (cons x xs)) 0]
;    [(even? (first (cons x xs)))
;     (+ (first (cons x xs)) (sum (rest (cons x xs))))]
;    [else
;     (sum (rest (cons x xs)))])
;
;= (sum-even (cons x xs)) 