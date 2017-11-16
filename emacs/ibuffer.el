;; IBUFFER
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("test"
		(filename . "\.\*test/"))

	       ("Code"
	       		(or (mode . c-mode)
	       		    (mode . c++-mode)))
	       ("Makefiles" (or
			     (name . "^Makefile\.\*")
			     (name . "^CMakeLists\\.txt\.\*")))
	       ("Directories" (mode . dired-mode))
	       ("Symrefs" (or
			   (name . "^\\*cscope\\*$")
			   (name . "^TAGS\.\*")))

	       ))))

;;(add-to-list 'ibuffer-never-show-regexps "^\\*")
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")
 ;;hide groups with no buffers
(setq ibuffer-show-empty-filter-groups nil)

    (add-hook 'ibuffer-mode-hook
              (lambda ()
                (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-formats
      '( (mark modified read-only " " (name 35 35 :left :elide) " " (filename 9 -1 :right))))
