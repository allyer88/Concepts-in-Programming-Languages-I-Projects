(defun MY-LENGTH (x)
	(cond ((null x) 0)
		(t (+ 1 (MY-LENGTH (cdr x))))
	)
)
(defun MY-MEMQ (x y)
	(cond ((null y) nil)
                ((equal x (car y)) y)
                (t (MY-MEMQ x (cdr y)))
        )
)
(defun MY-APPEND (x y)
	(cond ((null x) y)
		(t (cons (car x) (MY-APPEND (cdr x) y)))
	)
)
(defun MY-REVERSE (x)
	(cond ((null x) nil)
		(t (MY-APPEND (MY-REVERSE (cdr x)) (cons (car x) nil)))
	)
)
(defun MY-MAPCAR (x y)
	(cond ((null y) nil)
		(t (cons (apply x (list (car y)))(MY-MAPCAR x (cdr y))))
	)
)
(defun MY-COPY (x)
	(cond ((atom x) x)
		(t (cons (MY-COPY (car x)) (MY-COPY (cdr x))))
	)
)
(defun MY-NTH (x y)
	(cond ((equal y 1) x)
 		((equal y 0) (cons nil x))
		(t (MY-NTH (cdr x) (- y 1)))
	)
)
(defun MY-REMOVE (x y)
	(cond ((null y) nil)
		((equal x (car y)) (MY-REMOVE x (cdr y)))
		(t (cons (car y) (MY-REMOVE x (cdr y))))
	)
)
(defun MY-SUBST (x y z)
	(cond ((null z) nil)
		((equal x (car z)) (cons y (MY-SUBST x y (cdr z))))
		(t (cond ((listp (car z)) (cons (MY-SUBST x y (car z)) (MY-SUBST x y (cdr z))))
			(t (cons (car z) (MY-SUBST x y (cdr z))))
		   )
		)
	)
)
(defun MY-SUBSET (fn l)
	(cond ((null l) nil)
		((funcall fn (car l)) (cons (car l) (MY-SUBSET fn (cdr l))))
		(t (MY-SUBSET fn (cdr l)))
	)
)
(defun MY-ADD (x y)
	(cond ((> (MY-LENGTH x) (MY-LENGTH y)) (MY-ADD-HELPER y x 0))
		(t (MY-ADD-HELPER x y 0))
	)
)
(defun MY-ADD-HELPER (x y z)  
	(cond ((and (null x) (null y)) 
		(cond ((equal z 0) nil)
			(t '(1))
		)
	       )
		((and (null x) (not (null y))) 
		  (cond ((equal z 0) y)
			(t (cond ((>= (+ 1 (car y)) 10)
				(cons (- (+ 1 (car y)) 10) (MY-ADD-HELPER x (cdr y) 1)))
				(t (cons (+ 1 (car y)) (MY-ADD-HELPER x (cdr y) 0)))
			   )
			)
		  )
		)
		(t (cond ((equal z 0) 
			(cond ((>= (+ (car x) (car y)) 10) (cons (- (+ (car x) (car y)) 10) (MY-ADD-HELPER (cdr x) (cdr y) 1)))
			 	(t (cons (+ (car x) (car y)) (MY-ADD-HELPER (cdr x) (cdr y) 0)))
		   	)
		   )
		   (t (cond ((>= (+ (car x) (car y) 1) 10) (cons (- (+ (car x) (car y) 1) 10) (MY-ADD-HELPER (cdr x) (cdr y) 1)))
				 (t (cons (+ (car x) (car y) 1) (MY-ADD-HELPER (cdr x) (cdr y) 0)))
			   )
		   ))
		)		
	)
)
(defun MY-MERGE (x y)
	(cond ((null x) y)
    		((null y) x)
		((< (car x) (car y)) (cons (car x) (MY-MERGE (cdr x) y)))
		(t (cons (car y) (MY-MERGE x (cdr y))))
	)
)
(defun MY-SUBLIST (x y)
	(MY-SUBLIST-HELPER x y T)
)
(defun MY-SUBLIST-HELPER (x y z)
	(cond ((null x) T)
		((null y) nil)
		((eq (car x) (car y)) (MY-SUBLIST-HELPER (cdr x) (cdr y) nil))
		(t (cond ((eq z T) (MY-SUBLIST-HELPER x (cdr y) T))
			 (t nil)
		   )
		)
	)
)
(defun MY-ASSOC (x y)
	(cond ((null y) nil)
		((eq x (car (car y))) (car y))
		(t (MY-ASSOC x (cdr y)))
	)
)
(defun MY-REPLACE (x y)
	(cond ((null y) nil)
		((eq (MY-ASSOC (car y) x) nil) (cons (car y) (MY-REPLACE x (cdr y))))
		(t (cons (cdr (MY-ASSOC (car y) x)) (MY-REPLACE x (cdr y))))
	)
)
