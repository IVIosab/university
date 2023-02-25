#lang racket
(define (attacks? queen1 queen2)
  (or (= (car queen1) (car queen2))
      (= (cdr queen1) (cdr queen2))
      (= (abs (- (car queen1) (car queen2))) (abs (- (cdr queen1) (cdr queen2))))))

(attacks? '(1 . 1) '(2 . 2))
#t

(define (attacks-any? queen other-queens)
  (ormap (lambda (q) (attacks? queen q)) other-queens))

(attacks-any? '(1 . 2) '((2 . 4) (3 . 1) (4 . 3)))
#f


(define (no-attacks? queens)
  (andmap (lambda (q) (not (attacks-any? q (remove q queens)))) queens))

(no-attacks? '((1 . 2) (2 . 4) (3 . 1) (4 . 3)))
#t

(define (for-range f left right) (map f (inclusive-range left right)))

(define (check-queens queens)
  (cond
    [(no-attacks? queens) (list queens)]
    [else '()]))

(define naive-four-queens
  (apply append (for-range (lambda (x1)
    (apply append (for-range (lambda (x2)
      (apply append (for-range (lambda (x3)
        (apply append (for-range (lambda (x4)
          (check-queens (list (cons x1 1) (cons x2 2) (cons x3 3) (cons x4 4)))) 1 4))) 1 4))) 1 4))) 1 4)))
                        

naive-four-queens