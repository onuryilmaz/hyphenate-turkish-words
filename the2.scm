; METU CENG 111 
; Take Home Exam 2

; Turkish hyphenation function named as "hyphenate"

; The algorithm used in this process:
; 1. Execute 2-6 on a given word 
; 2. Check two consequent letters in a word beginning from the end of a word
; 	3. If vowel-vowel, hyphenate in the middle of them, print and continue
; 	4. If consonant-consonant, print and continue
;	5. If vowel-consonant, print and and continue
;	6. If consonant-vowel, hyphenate at the beginning of that two letters, print and continue
; 7. Check if there are any dashes in the first character of output
;	8. If yes, remove. If no, continue
; 9. Check if the output is exception
;	10. If yes, combine the left consonants at the beginning with the first syllable. If no, print.
; 11. End.


; "unlu" function which checks whether the given input is
; vowel or not.
(define (unlu x) 
		
		(member? x '(a e o u i)))


; "hyphenate-control" function which checks the given two
; letters and applies the rule of Turkish hyphenation and 
; associates (-) dashes with the start of each syllable.
(define (hyphenate-control x y) 
(cond
(   (and (unlu x) (unlu (first y))) 									 	(word x '- y)) 
(   (and (not (unlu x)) (not(unlu (first y)))) 								(word x y))
(   (and (unlu x) (or (not (unlu (first y))) (not (equal? (first y) '-)))) 	(word x y))
(   (and (not (unlu x)) (unlu (first y)) ) 									(word '- x y))
(   (and (unlu x) (equal? (first y) '-)) 									(word x y))
(   (and (not (unlu x)) (equal? (first y) '-)) 								(word x y))
(	 else 																	'())
))


; "accumulate-and-correct" function, which accumulates 
; "hyphenate-control" function on the given list and 
; and checks and deletes if there are any dashes (-) in the 
; beginning of output.
(define (accumulate-and-correct y) 
			(if (equal? (first (accumulate hyphenate-control y) ) '-) 
			(butfirst (accumulate hyphenate-control y)) 
			(accumulate hyphenate-control y)))
			

; "hyphenate" function, which is the main function ends this 
; process by checking if the input one of the exceptions in 
; Turkish language. Mentioned exceptions are the expressions
; like 'tren' 'strateji' which start with more than one consonant.
(define (hyphenate girdi)
(cond
		((and (not (unlu (first (accumulate-and-correct girdi)))) 
		(equal? (first (bf (accumulate-and-correct girdi))) '-))
							
							(word (first (accumulate-and-correct girdi)) 
							(bf (bf (accumulate-and-correct girdi)))))
			  
		((and (not (unlu (first (accumulate-and-correct girdi)))) 
		(not (unlu (first (bf (accumulate-and-correct girdi)))))
		(equal? (first (bf (bf(accumulate-and-correct girdi)))) '-) ) 
							
							(word (first (accumulate-and-correct girdi)) 
							(first (bf (accumulate-and-correct girdi))) 
							(bf (bf (bf (accumulate-and-correct girdi)))) ))		
							
		(else (accumulate-and-correct girdi))))

