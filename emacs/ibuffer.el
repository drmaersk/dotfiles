;; IBUFFER
(require 'ibuffer)
(require 'ibuffer-projectile)
;; (setq ibuffer-saved-filter-groups
;;       (quote (("default"
;; 	       ("test"
;; 		(filename . "\.\*test/"))
;;                ("intel" (filename .   "\.\*vendor\.intel"))
;; 	       ("vcc_ihu" (filename .   "\.\*delphi/vcc_ihu"))
;; 	       ("delphi" (filename .   "\.\*delphi"))
;; 	       ("Code"
;; 	       		(or (mode . c-mode)
;; 	       		    (mode . c++-mode)))
;; 	       ("Makefiles" (or
;; 			     (name . "^Makefile\.\*")
;; 			     (name . "^CMakeLists\\.txt\.\*")))
;; 	       ("Directories" (mode . dired-mode))
;; 	       ("Symrefs" (or
;; 			   (name . "^\\*cscope\\*$")
;; 			   (name . "^TAGS\.\*")))

;; 	       ))))

;; ;;(add-to-list 'ibuffer-never-show-regexps "^\\*")
;; (require 'ibuf-ext)
;; (add-to-list 'ibuffer-never-show-predicates "^\\*")
;;  ;;hide groups with no buffers
;; (setq ibuffer-show-empty-filter-groups nil)

;;     (add-hook 'ibuffer-mode-hook
;;               (lambda ()
;;                 (ibuffer-switch-to-saved-filter-groups "default")))

;;  (setq ibuffer-formats
;;        '( (mark modified read-only " " (name 35 35 :left ) " " (filename 9 30 :right :elide))))


;; (setq ibuffer-formats 
;;       '((mark modified read-only " "
;;               (name 30 30 :left :elide) ; change: 30s were originally 18s
;;               " "
;;               (size 9 -1 :right)
;;               " "
;;               (mode 16 16 :left :elide)
;;               " " filename-and-process)
;;         (mark " "
;;               (name 16 -1)
;;               " " filename)))


(add-to-list 'ibuffer-never-show-predicates "^\\*helm")

(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))



