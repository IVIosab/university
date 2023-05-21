#lang racket
;Name: Mosab Mohamed
;Date: 21/9/2022
;Homework 1: Symbolic Differentiation
;
;Documentation:
;Table of Contents:
; 1.About the Project
;  a.Description 
;  b.Function and Predicates
;   I. Parameters and Input criteria
;   II. User functions and predicates
;   III. Internal functions and predicates
; 2.Getting Started (User Guide)
; 3.Main Functionality and Examples:
;
; About the Project:
;  Description:
;    This code is an implementation of a Symbolic Differentiator
;    where it consists of multiple functions related to:
;      -Differentation expresions
;      -Simplifying expressions
;      -Mathmatical operations
;      -Output presentation
;      -Error handling 
;    Only a subset of these functions should be used by the user directly.
;
;
;  Functions and Predicates;
;    Parameters and Input criteria:
;      For all functions and predicates we expect valid input for each parameter:
;        expr: an expression paramter that should be in valid racket notation
;        respect/respects: a list or symbol that consist of the variable/s we should derive for
;        operator: a symbol that is a supported operator
;        str: a string
;        var: a variable or a number
;        expected-expr/expected-form/actual-expr: parameters related to error handling that are handled internally
;
;      Since the user might write invalid input, we split the functions and predicates into two catagories:
;        1. User functions and predicates: Where the program validates all inputs before running any operation and raises an error if the input is invalid
;        2. Internal functions an predicates: Where there's no error handling due to the fact that it is impossible to have invalid input
;                                             other than if the user tried to use them directly.
;       
;    User Functions and Predicats:
;      Predicates:
;        -(variable? expr)  : returns boolean value indicating if the expression is a variable or not
;        The following predicates return a boolean value indicating if the expression is a specifc operation expression or not
;        -(sum? expr)       : for sum expressions (supports polyvariadic expressions)
;        -(product? expr)   : for product expressions (supports polyvariadic expressions)
;        -(sub? expr)       : for subtraction expressions
;        -(div? expr)       : for division expressions 
;        -(exp? expr)       : for power expressions
;        -(sin? expr)       : for sin expressions
;        -(cos? expr)       : for cos expressions
;        -(tan? expr)       : for tan expressions
;        -(log? expr)       : for log expressions
;      Functions:
;        -(summand-1 expr)             : returns the first addend of the sum expression (supports polyvariadic expressions)
;        -(summand-2 expr)             : returns the second addend of the sum expression (supports polyvariadic expressions)
;        -(multiplier-1 expr)          : returns the first factor of the product expression (supports polyvariadic expressions)
;        -(multiplier-2 expr)          : returns the second factor of the product expression (supports polyvariadic expressions)
;        -(derivative expr respect)    : returns the symbolic derivative of a given expression in respect to a given variable (note: the derivate won't be in the simplest form)
;        -(simplify expr)              : returns the simplified version of a given expression (note: only simplifies trivial operations like:
;                                        [operations for constants, removal of 0 terms...etc], and does not simplify the expression down to polynomial of its variables)
;        -(to-infix expr)              : returns the infix form of an expression
;        -(variables-of expr)          : returns a list of the variables present in an expression
;        -(gradient expr respects)     : returns a gradient of a multivariable expression given explicity the list of variables
; 
;    Internal Functions and Predicates: (shouldn't be used by the user directly due to the lack of error-handling in them)
;      Predicates:
;        -(is-char? str)                                          ; checks if string starts with an alphabetic letter
;        -(operation? operator expr)                              ; given an operator and an expression, checks if the expression uses that operator
;        -(atomic? expr)                                          ; checks if an expression is not a lits
;        -(valid-expr? expr)                                      ; checks if an expression is syntactically valid 
;        -(atomic-number? expr)                                   ; checks if the expression is atomic and is a number
;      Functions: 
;        -(format-error expected-expr expected-form actual-expr)  ; formats an error message given some variable message parts
;        -(expression-error expr operator)                        ; calls format-error with the variable message parts based on the operation
;        -(derivative-of-atomic var respect)                      ; derives a variable or a number
;        -(derivative-sin expr respect)                           ; derives a sin expression
;        -(derivative-cos expr respect)                           ; derives a cos expression
;        -(derivative-tan expr respect)                           ; derives a tan expression
;        -(simplify-sum expr)                                     ; simplifies a sum expression
;        -(simplify-product expr)                                 ; simplifies a product expression
;        -(simplify-sub expr)                                     ; simplifies a subtraction expression
;        -(simplify-div expr)                                     ; simplifies a division expression
;        -(simplify-exp expr)                                     ; simplifies a power expression
;        -(simplify-sin expr)                                     ; simplifies a sin expression
;        -(simplify-cos expr)                                     ; simplifies a cos expression
;        -(simplify-tan expr)                                     ; simplifies a tan expression
;        -(simplify-log expr)                                     ; simplifies a log expression
;        -(simplify-at-root expr)                                 ; checks the expression type and delegates the simplification to its designated function
;
; Getting started (User Guide):
;  You can test the project by only running the code and using the functions
;  Please keep in mind that if you use Internal functions or predicates you need to make sure that your input is valid beforehand
;
; Main Functionality and Examples:
;  (derivative expr respect) : derivative function allows you to derive an expression in respect to a variable
;    example input:
;     (derivative '(* (+ x y) (+ x (+ x x))) 'x)
;    example output:
;     '(+ (* (+ 1 0) (+ x (+ x x))) (* (+ 1 (+ 1 1)) (+ x y)))
;
;  (simplify expr) : simplify function allows you to simplify an expression
;    example input:
;     (simplify '(+ (* (+ 1 0) (+ x (+ x x))) (* (+ x y) (+ 1 (+ 1 1)))))
;    example output:
;     '(+ (+ x (+ x x)) (* (+ x y) 3))
;
;  (to-infix expr) : to-infix function allows you to get an expression in infix form
;    example input:
;     (to-infix '(+ (+ x (+ x x)) (* (+ x y) 3)))
;    example output:
;     '((x + (x + x)) + ((x + y) * 3))
;
;  (variables-of expr) : variables-of function retrieves a sorted list of the unique variables in a given expression
;    example input:
;     (variables-of '(+ 1 x y (* x y z)))
;    example output:
;     '(x y z)
;
;  (gradient expr respects) : gradient function allows you to calculate gradient of a multivariable expression (given explicitly the list of variables)
;    example input:
;     (gradient '(+ 1 x y (* x y z)) '(x y z))
;    example output:
;     '((+ (* y z) 1) (+ (* x z) 1) (* x y))
;
;
;
;Note: Only the last version of the solution is present here where all problems have been solved including the ones that tell us to modify existing functions



;Exercise 1.1:

;Internal Functions: 
;Checks if str starts with an alphabetic character
(define (is-char? str) 
  (and (non-empty-string? str)
       (char-alphabetic? (string-ref str 0))))

;checks if the given operator is equal to the first element of the expression 
(define (operation? operator expr min-terms max-terms) 
  (and (list? expr)
       (>= (length expr) min-terms)
       (or (<= (length expr) max-terms) (= max-terms 0))
       (equal? operator (first expr))))

;checks if expr is not a list
(define (atomic? expr) 
  (not (list? expr)))

;error handling functions
(define (format-error expected-expr expected-form actual-expr)
  (error (string-append "Expected a/n " expected-expr " expression of the form " expected-form ", but got: ") actual-expr))

(define (expression-error expr operator)
  (cond
    [(equal? operator '+) (format-error "sum" "(+ <expr> <expr>...)" expr)]
    [(equal? operator '*) (format-error "product" "(* <expr> <expr>...)" expr)]
    [(equal? operator '-) (format-error "subtraction" "(- <expr> <expr>)" expr)]
    [(equal? operator '/) (format-error "divison" "(/ <expr> <expr>)" expr)]
    [(equal? operator '^) (format-error "power" "(^ <expr> <expr>)" expr)]
    [(equal? operator 'sin) (format-error "sin" "(sin <expr>)" expr)]
    [(equal? operator 'cos) (format-error "cos" "(cos <expr>)" expr)]
    [(equal? operator 'tan) (format-error "tan" "(tan <expr>)" expr)]
    [(equal? operator 'log) (format-error "log" "(log <expr>)" expr)]
    [else (format-error "operation" "(<operator1> <expr>) operator1=[sin, cos, tan, log] or (<operator2> <expr> <expr>) operator2=[-, /, ^] or (<operator3> <expr> <expr>...) operator3=[+, *]" expr)]))

;User Functions:
;checks if the expression is a variable or not
(define (variable? expr) 
  (and (symbol? expr)
       (is-char? (symbol->string expr))))

;the following functions check if the expression is a specific operation, by calling the operation? predicate with the operator and the expression itself 
(define (sum? expr) (operation? '+ expr 3 0)) 
(define (sub? expr) (operation? '-   expr 3 3)) 
(define (product? expr) (operation? '* expr 3 0))
(define (div? expr) (operation? '/   expr 3 3)) 
(define (exp? expr) (operation? '^   expr 3 3)) 
(define (sin? expr) (operation? 'sin expr 2 2)) 
(define (cos? expr) (operation? 'cos expr 2 2))  
(define (tan? expr) (operation? 'tan expr 2 2)) 
(define (log? expr) (operation? 'log expr 2 2)) 

;the following functions were required to implement, but weren't used anywhere else in the assignment due to the need of supporting polyvariadic expressions 
;returns the first addend
(define (summand-1 expr) 
  (cond
    [(sum? expr) (second expr)]
    [else (expression-error expr '+)]))
;returns the second addend
(define (summand-2 expr) 
  (cond
    [(sum? expr) (third expr)]
    [else (expression-error expr '+)]))
;returns the first factor
(define (multiplier-1 expr) 
  (cond
    [(product? expr) (second expr)]
    [else (expression-error expr '*)]))
;returns the second factor
(define (multiplier-2 expr) 
  (cond
    [(product? expr) (third expr)]
    [else (expression-error expr '*)]))
;End of Exercise 1.1


;Exercise 1.2 & 1.6 & 1.7

;Internal Functions:
;checks if the expression is valid or not by splitting it into smaller expressions an checking if each is valid or not
(define (valid-expr? expr)
  (cond
    [(atomic? expr) #t]
    [(or (sum? expr) (product? expr)) (andmap valid-expr? (rest expr))]
    [(or (sub? expr) (div? expr) (exp? expr)) (and (valid-expr? (second expr)) (valid-expr? (third expr)))]
    [(or (sin? expr) (cos? expr) (tan? expr) (log? expr)) (valid-expr? (second expr))]
    [else (expression-error expr (first expr))]))

;checks if the expr is a number
(define (atomic-number? expr) 
  (and (atomic? expr) (not (variable? expr)) (not (symbol? expr))))     

;derives sin expression, returns cos 
(define (derivative-sin expr respect)
  (list 'cos (rest expr)))

;derives cos expression, returns -sin
(define (derivative-cos expr respect) 
  (list '* -1 (list 'sin (rest expr))))

;derives tan expression, returns 1/cos^2
(define (derivative-tan expr respect) 
  (list '/ 1 (list '^ (list 'cos expr) 2)))

;derives an atomic number or variable by checking if it is equal the respect value or not and returning 1 or 0 accordingly
(define (derivative-of-atomic var respect) 
  (cond
    [(equal? var respect) 1]
    [else 0]))


;User Functions:
;the following functions implement the basic differentation rules for symbolic differentation with the specification provided by the assignment

;derives expressions by splitting big expressions into smaller ones in recursive calls
;while taking into account differentiation rules and then calling derivative-of-atomic for atomic values
(define (derivative expr respect) 
  (cond
    [(not (valid-expr? expr))] ;checks if the expression is not valid, if it is valid we will continue going through the conditions, otherwise the predicate valid-expr? would have already raised an error
    [(atomic? expr) (derivative-of-atomic expr respect)] ;if it is atomic then call derivative-of-atomic
    [(sum? expr) (cons '+ (map (lambda (e) (derivative e respect)) (rest expr)))] ;if it is a sum expression, get the derivative of each term in the expression and return their sum (supports polyvariadic expressions)
    [(sub? expr) (cons '- (map (lambda (e) (derivative e respect)) (rest expr)))] ;if it is a sub expression, get the derivative of each term in the expression and return their difference (supports polyvariadic expressions)
    [(product? expr) (cons '+ (map (lambda (e) (cons '* (cons (derivative e respect) (remove e (rest expr))))) (rest expr)))] ;if it is a product expression, get the derivative of each term multiplied by the rest of the terms and return their sum (supports polyvariadic expressions)
    [(div? expr) (list '/                       ;if it is a div expression, just follow the differential rule for division 
                       (list '-
                             (list '* (derivative (third expr) respect) (second expr))
                             (list '* (third expr) (derivative (second expr) respect)))
                       (list '^ (third expr) 2))] 
    [(exp? expr) (list '*                       ;if it is a power expression, just follow the differential rule for power
                       (list '^ (second expr) (third expr))
                       (list '+
                             (list '/
                                   (list '* (third expr) (derivative (second expr) respect))
                                   (second expr))
                             (list '*
                                   (derivative (third expr) respect)
                                   (list 'log (second expr)))))]
    [(sin? expr) (derivative-sin expr respect)] ;if it is a sin expression, call derivative-sin
    [(cos? expr) (derivative-cos expr respect)] ;if it is a cos expression, call derivative-cos
    [(tan? expr) (derivative-tan expr respect)] ;if it is a tan expression, call derivative-tan
    [(log? expr) (list '/ (derivative expr respect) expr)])) ;if it is a log expression, just follow the differential rule for log
;End of Exercise 1.2 & 1.6 & 1.7

;Exercise 1.3 & 1.6 & 1.7

;Internal Functions:
;simplifies summation expressions
(define (simplify-sum expr) 
  (define (helper expr current sum)
    (cond
      [(empty? expr) (cond
                       [(empty? current) sum] 
                       [(and (= sum 0) (= (length current) 1)) (first current)]
                       [(= sum 0) (append (list '+) current)]
                       [else (append (list '+) current (list sum))])]
      [(atomic-number? (first expr)) (helper (rest expr) current (+ sum (first expr)))]
      [else (helper (rest expr) (append current (list (first expr))) sum)]))
  (helper (rest expr) '() 0))

;simplifies multiplication expressions
(define (simplify-product expr) 
  (define (helper expr current product)
    (cond
      [(empty? expr) (cond
                       [(empty? current) product]
                       [(and (= product 1) (= (length current) 1)) (first current)]
                       [(= product 1) (append (list '*) current)]
                       [(= product 0) 0]
                       [else (append (list '*) current (list product))])]
      [(atomic-number? (first expr)) (helper (rest expr) current (* product (first expr)))]
      [else (helper (rest expr) (append current (list (first expr))) product)]))
  (helper (rest expr) '() 1))

;simplifies subtraction expressions
(define (simplify-sub expr)  
  (cond
    [(and (atomic-number? (second expr)) (atomic-number? (third expr))) (- (second expr) (third expr))] ;if both are numbers then just calculate 
    [(and (atomic-number? (third expr)) (zero? (third expr))) (second expr)] ;if the subtrahend is zero then just return minuend
    [else expr]))

;simplifies division expressions
(define (simplify-div expr) 
  (cond
    [(and (atomic-number? (second expr)) (atomic-number? (third expr))) (/ (second expr) (third expr))] ;if both are numbers then just calculate
    [(and (atomic-number? (second expr)) (zero? (second expr))) 0] ;if the dividend is zero then return zero 
    [(and (atomic-number? (third expr)) (= 1 (third expr))) (second expr)] ;if the divisor is one then return the dividend 
    [else expr]))

;simplifies power expressions
(define (simplify-exp expr) 
  (cond
    [(and (atomic-number? (second expr)) (atomic-number? (third expr))) (expt (second expr) (third expr))] ;if both are numbers then just caculate 
    [(and (atomic-number? (third expr)) (zero? (third expr))) 1] ;if the exponent is zero then return one
    [(and (atomic-number? (third expr)) (= 1 (third expr))) (second expr)] ;if the exponent is one then return the base
    [else expr]))

;simplifies sin expressions
(define (simplify-sin expr) 
  (cond
    [(atomic-number? (second expr)) (sin (second expr))] ;if term is a number then just calculate
    [else expr]))

;simplifies cos expressions
(define (simplify-cos expr) 
  (cond
    [(atomic-number? (second expr)) (cos (second expr))];if term is a number then just calculate
    [else expr]))

;simplifies tan expressions
(define (simplify-tan expr) 
  (cond
    [(atomic-number? (second expr)) (tan (second expr))];if term is a number then just calculate
    [else expr]))

;simplifies log expressions
(define (simplify-log expr) 
  (cond
    [(atomic-number? (second expr)) (log (second expr))];if term is a number then just calculate
    [else expr]))

;checks type of expression then delegates the simplification to the correct function
(define (simplify-at-root expr) 
  (cond
    [(sum? expr) (simplify-sum expr)]
    [(product? expr) (simplify-product expr)]
    [(sub? expr) (simplify-sub expr)]
    [(div? expr) (simplify-div expr)]
    [(exp? expr) (simplify-exp expr)]
    [(sin? expr) (simplify-sin expr)]
    [(cos? expr) (simplify-cos expr)]
    [(tan? expr) (simplify-tan expr)]
    [(log? expr) (simplify-log expr)]))

;User Functions:
;calls simplify-at-root while splitting the original expression into smaller parts to simplify each part of an expression before trying to simplify the expression itself
(define (simplify expr) 
  (cond
    [(not (valid-expr? expr))] ;checks if the expression is not valid, if it is valid we will continue going through the conditions, otherwise the predicate valid-expr? would have already raised an error
    [(atomic? expr) expr]
    [(= (length expr) 2) (simplify-at-root (list (first expr) (simplify (second expr))))]
    [else (simplify-at-root (append (list (first expr)) (map (lambda (e) (simplify e)) (rest expr))))]))
;End of Exercise 1.3 & 1.6 & 1.7

;Exercise 1.5
;User Functions:
;returns the infix form of an expression
(define (to-infix expr)  
  (cond
    [(not (valid-expr? expr))] ;checks if the expression is not valid, if it is valid we will continue going through the conditions, otherwise the predicate valid-expr? would have already raised an error
    [(atomic? expr) expr]
    [else (append (list (to-infix (second expr))) (list (first expr)) (list (to-infix (third expr))))]))
;End of Exercise 1.5

;Exercise 1.8
;User Functions:
;returns the sorted list of unique variables in an expression by putting all atomic varaibles into a list then removing the duplicates then sorting it
(define (variables-of expr) 
  (cond
    [(not (valid-expr? expr))] ;checks if the expression is not valid, if it is valid we will continue going through the conditions, otherwise the predicate valid-expr? would have already raised an error
    [(atomic? expr) (variables-of (list expr))]
    [else
     (sort
      (remove-duplicates
       (append
        (filter variable? expr)
        (apply append (map variables-of (filter list? expr)))))
      #:key symbol->string string<?)]))
;End of Exercise 1.8

;Exercise 1.9
;User Functions: 
;returns a gradient of a multivariable expression given the list of variables by simplifying the derivative of the expression for each variable in respects
(define (gradient expr respects) 
  (cond
    [(not (valid-expr? expr))] ;checks if the expression is not valid, if it is valid we will continue going through the conditions, otherwise the predicate valid-expr? would have already raised an error
    [else (map (lambda (respect) (simplify (derivative expr respect))) respects)]))
;End of Exercise 1.9