(setq val-list '((?1 "Default" (lambda () (customize-set-variable 'helm-locate-command "locate %s -d /home/robban/.config/locatedb/rootdb -e -A --regex %s") 'def))
                 (?2 "Aptiv"   (lambda () (customize-set-variable 'helm-locate-command "locate %s -d /home/robban/.config/locatedb/ihudb -e -A --regex %s") 'apt))))

(defun robb-choose-locatedb ()
  "Lets the user choose the database for locate"
  (interactive)
  (let ((choice (read-char-choice (mapconcat (lambda (item) (format "%c: %s " (car item) (cadr item))) val-list "; ")
                  (mapcar #'car val-list))))
    (funcall (nth 2 (assoc choice val-list)))))



;;(defun setlocate-aptiv () (interactive) (customize-set-variable 'helm-locate-command "locate %s -d /home/robban/.config/dbfile_aptiv -e -A --regex %s"))

;;(defun setlocate-default () (interactive) (customize-set-variable 'helm-locate-command "locate %s -d /home/robban/.config/dbfile -e -A --regex %s"))


