;Example from PAIP for GPS
(load "gps.scm")

(define op1 (make-op))
(op1 'set-action! 'drive-son-to-school)
(op1 'set-preconds! '(son-at-home car-works))
(op1 'set-add-list! '(son-at-school))
(op1 'set-del-list! '(son-at-home))

(define op2 (make-op))
(op2 'set-action! 'shop-installs-battery)
(op2 'set-preconds! '(car-needs-battery shop-knows-problem shop-has-money))
(op2 'set-add-list! '(car-works))

(define op3 (make-op))
(op3 'set-action! 'tell-shop-problem)
(op3 'set-preconds! '(in-communication-with-shop))
(op3 'set-add-list! '(shop-knows-problem))

(define op4 (make-op))
(op4 'set-action! 'telephone-shop)
(op4 'set-preconds! '(know-phone-number))
(op4 'set-add-list! '(in-communication-with-shop))

(define op5 (make-op))
(op5 'set-action! 'look-up-number)
(op5 'set-preconds! '(have-phone-book))
(op5 'set-add-list! '(know-phone-number))

(define op6 (make-op))
(op6 'set-action! 'give-shop-money)
(op6 'set-add-list! '(shop-has-money))
(op6 'set-del-list! '(have-money))

(set! state '(son-at-home car-needs-battery have-money have-phone-book))
(set! goals '(son-at-school))
(set! ops (list op1 op2 op3 op4 op5 op6))

