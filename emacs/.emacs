
;; Addedee by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/dotfiles/emacs/001-package.el")
(load "~/dotfiles/emacs/color-theme-settings.el")
(load "~/dotfiles/emacs/keybindings.el")
(load "~/dotfiles/emacs/line-endings.el")

(let ((default-directory  "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))

(delete-selection-mode 1)
(dynamic-completion-mode)
(global-linum-mode 1)



;; (require 'company)
;; (require 'cc-mode)
;; (add-hook 'after-init-hook 'global-company-mode)

;; (setq company-backends (delete 'company-semantic company-backends))
;; (with-eval-after-load (define-key c-mode-map  [(tab)] 'company-complete))
;; (with-eval-after-load (define-key c++-mode-map  [(tab)] 'company-complete))

;; (add-to-list 'company-backends 'company-c-headers)


;; (defun my-c-mode-common-hook ()
;; ; Style settings
;;   ;; Set preferred style to evade from
;;   (c-set-style "Ellemtel")

;;   ;; Change basic offset size
;;   (setq c-basic-offset 2)
;;   ;; No indent before lonely brace on a line
;;   (c-set-offset 'substatement-open 0)
;;   ;; Indent in class/struct/union definition
;;   (c-set-offset 'inclass '+)
;;   ;; Indent after case statement
;;   (c-set-offset 'statement-case-open '+)
;;   (c-set-offset 'case-label 0)

;; ; Behaviour settings
;;   ;; This will make sure spaces are used instead of tabs
;;   (setq	indent-tabs-mode nil)

;;   ;; Tab key now indents when far out on the left and inserts
;;   ;; real tab when inside text.
;;   ;; (setq c-tab-always-indent 'nil)
;;   )

;; (setq c-basic-offset 2)

;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook
;;          '(lambda ()
;;              (define-key c-mode-map "\C-c\C-c" 'recompile)))

;; (require 'helm)
;; (require 'helm-config)
;; (require 'helm-gtags)
;; ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;; (global-set-key (kbd "C-c h") 'helm-command-prefix)
;; (global-unset-key (kbd "C-x c"))

;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; (when (executable-find "curl")
;;   (setq helm-google-suggest-use-curl-p t))

;; (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;       helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;;       helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;;       helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;       helm-ff-file-name-history-use-recentf t
;;       helm-echo-input-in-header-line t)

;; (defun spacemacs//helm-hide-minibuffer-maybe ()
;;   "Hide minibuffer in Helm session if we use the header line as input field."
;;   (when (with-helm-buffer helm-echo-input-in-header-line)
;;     (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
;;       (overlay-put ov 'window (selected-window))
;;       (overlay-put ov 'face
;;                    (let ((bg-color (face-background 'default nil)))
;;                      `(:background ,bg-color :foreground ,bg-color)))
;;       (setq-local cursor-type nil))))


;; (add-hook 'helm-minibuffer-set-up-hook
;;           'spacemacs//helm-hide-minibuffer-maybe)

;; (setq helm-autoresize-max-height 0)
;; (setq helm-autoresize-min-height 20)
;; (helm-autoresize-mode 1)

;; (helm-mode 1)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; IBUFFER
;; (require 'ibuffer)
;; (setq ibuffer-saved-filter-groups
;;       (quote (("default"
;; 	       ("test"
;; 		(filename . "\.\*test/"))

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

;; (setq ibuffer-formats
;;       '( (mark modified read-only " " (name 35 35 :left :elide) " " (filename 9 -1 :right))))


;;ggtags
;; (require 'ggtags)
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;               (ggtags-mode 1))))

;; (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;; (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;; (define-key ggtags-mode-map (kbd "C-c g d") 'ggtags-find-definition)
;; (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;; (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;; (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;; (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;; (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; (setq imenu-create-index-function #'ggtags-build-imenu-index)

;; ;;sr-speedbar
;; (require 'sr-speedbar)
;; (global-set-key (kbd "§") 'sr-speedbar-toggle)

;; ;;company-mode
;; (require 'company)
;; ;;(add-hook 'after-init-hook 'global-company-mode)
;; ;;(setq company-backends (delete 'company-semantic company-backends))
;; ;;;;(define-key c-mode-map [(tab)] 'company-complete)
;; ;;;;(define-key c++-mode-map [(tab)] 'company-complete)

;; (require 'cc-mode)
;; (require 'semantic)

;; (global-semanticdb-minor-mode 1)
;; (global-semantic-idle-scheduler-mode 1)

;; (semantic-mode 1)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

;; No backup-files
(setq backup-directory-alist `(("." . "~/.saves")))
;;(setq make-backup-files nil)
(server-start)


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(inhibit-startup-screen t)
;;  '(package-selected-packages (quote (helm-ebdb company))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (color-theme helm company))))
