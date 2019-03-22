Naive scheme implementation of the general problem solver in Chapter 4 of Peter Norvigs Pragmatics of AI Programming

state, goals, and ops are global variables

Define state as a list of current conditions

Ex: `(define state '(son-at-home car-needs-battery have-money have-phone-book))

Define goals as a list of conditions for the solved state

Ex: `(define goals '(son-at-school))`

Define ops as a list of operations created using the make-op function

Ex:
```
(define op1 (make-op))
(op1 'set-action! 'drive-son-to-school)
(op1 'set-preconds! '(son-at-home car-works))
(op1 'set-add-list! '(son-at-school))
(op1 'set-del-list! '(son-at-home))
(define ops (list op1 .... opn))
```

Finally call the main gps method to solve

Ex: `(gps state goals ops)`

Output from problem in example.scm
```
>(gps state goals ops)
(executing look-up-number)
(executing telephone-shop)
(executing tell-shop-problem)
(executing give-shop-money)
(executing shop-installs-battery)
(executing drive-son-to-school)
=> solved
```
