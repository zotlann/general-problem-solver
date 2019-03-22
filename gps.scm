;global state variable
(define state '())
;global operationss variable
(define ops '())
;global goals variable
(define goals '())

;main general problem solver program
(define gps
  (lambda (state goals ops)
    (if (every achieve goals) 'solved 'unsolveable)))

;achieves a goal if posible
(define achieve
  (lambda (goal)
    (or (member? goal state)
	(some apply-op (find-all goal ops appropriate-p)))))

;returns true if the goal is a member if an operations add list
(define appropriate-p
  (lambda (goal op)
    (member? goal (op 'get-add-list))))

;applies an opperation by displaying the operation, and adding and deliting things from 
;the state list as appropriate
(define apply-op
  (lambda (op)
    (if (every achieve (op 'get-preconds))
	(begin
	  (display (list 'executing (op 'get-action)))(newline)
	  (set! state (set-difference state (op 'get-del-list)))
	  (set! state (union state (op 'get-add-list)))
	  #t))))

;returns true if tar is a member of lst
(define member?
  (lambda (tar lst)
    (cond
      [(null? lst) #f]
      [(eq? (car lst) tar) #t]
      (else (member? tar (cdr lst))))))

;returnsn true if p is true for every value in lst
(define every
  (lambda (p lst)
    (cond
      [(null? lst) #t]
      [(not (p (car lst))) #f]
      (else
	(every p (cdr lst))))))

;returns true if p is true for some value in lst
(define some
  (lambda (p lst)
    (cond
      [(null? lst) #f]
      [(p (car lst)) #t]
      (else (some p (cdr lst))))))

;returns a list of all elements of p for which p is true
(define find-all
  (lambda (lhs lst p)
    (cond
      [(null? lst) '()]
      [(p lhs (car lst)) (cons (car lst) (find-all lhs (cdr lst) p))]
      (else (find-all lhs (cdr lst) p)))))

;returns the set-difference of two sets
(define set-difference
  (lambda (s1 s2)
    (cond
      [(null? s1) '()]
      [(not (member? (car s1) s2)) (cons (car s1) (set-difference (cdr s1) s2))]
      (else
	(set-difference (cdr s1) s2)))))

;returns the union of two sets
(define union
  (lambda (s1 s2)
    (cond
      [(null? s1) s2]
      [(member? (car s1) s2) (union (cdr s1) s2)]
      (else (cons (car s1) (union (cdr s1) s2))))))

;creates an operation closure tha allows you to access it's action
;preconds add-list and del-list elements
(define (make-op)
  (define action '())
  (define preconds '())
  (define add-list '())
  (define del-list '())
  (lambda (method . args)
    (cond
      [(eq? method 'get-action) action]
      [(eq? method 'set-action!) (set! action (car args))]
      [(eq? method 'get-preconds) preconds]
      [(eq? method 'set-preconds!) (set! preconds (car args))]
      [(eq? method 'get-add-list) add-list]
      [(eq? method 'set-add-list!) (set! add-list (car args))]
      [(eq? method 'get-del-list) del-list]
      [(eq? method 'set-del-list!) (set! del-list (car args))]
      (else
	(display "Incorrect operation on op\n")))))
