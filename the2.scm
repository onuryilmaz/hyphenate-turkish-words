; "vowel" function which checks whether the given input is
; vowel or not.
(define (vowel x) 
		
		(member? x '(a e o u i)))


; "hyphenate-control" function which checks the given two
; letters and applies the rule of Turkish hyphenation and 
; associates (-) dashes with the start of each syllable.
(define (hyphenate-control x y) 
(cond
(   (and (vowel x) (vowel (first y))) 						(word x '- y)) 
(   (and (not (vowel x)) (not(vowel (first y)))) 				(word x y))
(   (and (vowel x) (or (not (vowel (first y))) (not (equal? (first y) '-)))) 	(word x y))
(   (and (not (vowel x)) (vowel (first y)) ) 					(word '- x y))
(   (and (vowel x) (equal? (first y) '-)) 					(word x y))
(   (and (not (vowel x)) (equal? (first y) '-)) 				(word x y))
(	 else 																		'())
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
(define (hyphenate input)
(cond
		((and (not (vowel (first (accumulate-and-correct input)))) 
		(equal? (first (bf (accumulate-and-correct input))) '-))
							
							(word (first (accumulate-and-correct input)) 
							(bf (bf (accumulate-and-correct input)))))
			  
		((and (not (vowel (first (accumulate-and-correct input)))) 
		(not (vowel (first (bf (accumulate-and-correct input)))))
		(equal? (first (bf (bf(accumulate-and-correct input)))) '-) ) 
							
							(word (first (accumulate-and-correct input)) 
							(first (bf (accumulate-and-correct input))) 
							(bf (bf (bf (accumulate-and-correct input)))) ))		
							
		(else (accumulate-and-correct input))))
