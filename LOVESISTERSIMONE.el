;;; package: --- LOVESISTERSIMONELOVESISTERSIMONELOVESISTERSIMONE

;;; Commentary:
;; LOVESISTERSIMONELOVESISTERSIMONELOVESISTERSIMONE

;;; Code:

(defun LOVESISTERSIMONE ()
  "LOVESISTERSIMONELOVESISTERSIMONELOVESISTERSIMONE!"
  (interactive)
  (let ((LOVE (apply #'concat
		     (flatten-list
		      (apply #'-zip
			     (cl-loop for s in '("LOVE" "SISTER" "SIMONE")
				      for c in '("#5bcefa" "#eeeeee" "#f5a8b8")
				      collect (make-list 60 (propertize s 'face (list :foreground c)))))))))
    (with-current-buffer (get-buffer-create LOVE)
      (erase-buffer)
      (cl-loop repeat 20
	       do (mapc #'(lambda (s) (mapc #'insert (make-list 52 s)) (insert "\n"))
			'("LOVE" "SISTER" "SIMONE")))
      (cl-flet ((b (fo to) (add-face-text-property fo to '(:foreground "#5bcefa")))
		(p (fo to) (add-face-text-property fo to '(:foreground "#f5a8b8")))
		(w (fo to) (add-face-text-property fo to '(:foreground "#eeeeee"))))
	(cl-loop for i from 1 to 60
		 do (goto-line i)
		 do (let ((order (pcase (% i 4)
				   (1 (list #'b #'p #'w #'p))
				   (2 (list #'p #'w #'p #'b))
				   (3 (list #'w #'p #'b #'p))
				   (0 (list #'p #'b #'p #'w)))))
		      (cl-loop for j = 0 then (+ 12 j)
			       for l from 1
			       with draw = #'(lambda (k fo to a b c d)
					       (pcase (% k 4)
						 (1 (funcall a fo to))
						 (2 (funcall b fo to))
						 (3 (funcall c fo to))
						 (0 (funcall d fo to))))
			       until (> (+ 12 j) (length (thing-at-point 'line)))
			       do (let ((p (+ (line-beginning-position) j)))
				    (apply draw l p (+ p 12) order))
			       finally (apply draw l
					      (+ (line-beginning-position) j) (line-end-position)
					      order))))))
    (delete-other-windows (select-window (display-buffer LOVE)))
    (goto-char 0)
    (let ((timer (gensym)))
      (setq timer
	    (run-at-time t 0.2 #'(lambda (LOVE)
				   (goto-char 0)
				   (cl-loop for i from 1 to 60
					    for c = (buffer-substring (point) (1+ (point)))
					    do (delete-char 1)
					    do (end-of-line)
					    do (insert c)
					    do (forward-line))
				   (message LOVE)
				   (goto-char 0))
			 LOVE))
      (run-at-time 10 nil #'(lambda (timer) (cancel-timer timer)) timer))))

(provide 'LOVESISTERSIMONE)

;;; LOVESISTERSIMONE.el ends here.
