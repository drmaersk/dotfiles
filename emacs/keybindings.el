;; ;;functions
(defun linemode_toggle ()
  (defvar r_linemode nil)
  (if (equal r_linemode nil)
      (progn
        (setq r_linemode t)
        (term-line-mode))
    (progn
      (setq r_linemode nil)
      (term-char-mode))
    )
  )

(defun robb-search-in-file () (interactive)
  (progn
(list-matching-lines (read-from-minibuffer "Search: "))
(switch-to-buffer-other-window "*Occur*")))

(defun robb-search-all-open-files() (interactive)
  (progn
    (multi-occur-in-matching-buffers "." (read-from-minibuffer "Search: "))
    (switch-to-buffer-other-window "*Occur*")))

(defun robb-grep() (interactive)
       (helm-ag (read-directory-name "Path: ")))

(defun robb-get-current-path ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
  )

(defun robb-find-base-class () (interactive)
  (ccls-xref-find-custom "$ccls/base")
  )

(defun robb-find-derived-class () (interactive)
       (ccls-xref-find-custom "$ccls/derived")
       )

(defun robb-find-callers () (interactive)
       (ccls-xref-find-custom "$ccls/callers")
       )
(defun robb-find-vars () (interactive)
; Use lsp-goto-implementation or lsp-ui-peek-find-implementation for derived types/functions
       (ccls-xref-find-custom "$ccls/vars")
       )


;;KEYBINDINGS
(global-set-key (kbd "C-x r 1") 'robb-find-base-class)
(global-set-key (kbd "C-x r 2") 'robb-find-callers)
(global-set-key (kbd "C-x r 3") 'robb-find-vars)
(global-set-key (kbd "C-x r 4") 'robb-search-in-file)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-!") 'set-frame-name)
(global-set-key (kbd "M-<left>") 'xah-previous-user-buffer)
(global-set-key (kbd "M-<right>") 'xah-next-user-buffer)
(global-set-key (kbd "C-M-<right>") 'windmove-right)
(global-set-key (kbd "C-M-<left>") 'windmove-left)
(global-set-key (kbd "C-M-<up>") 'windmove-up)
(global-set-key (kbd "C-M-<down>") 'windmove-down)
;;(global-set-key [f2] 'xref-find-apropos)
(global-set-key (kbd "C-<f2>") 'helm-gtags-find-pattern)
(global-set-key [f3] 'xref-find-definitions)
(global-set-key (kbd "C-<f3>") 'helm-imenu) ;;lsp-rename
(global-set-key [f4] 'xref-find-references)
(global-set-key (kbd "C-<f4>") 'robb-find-callers)
;;(global-set-key (kbd "C-<f3>") 'lsp-ui-peek-find-references)
(global-set-key (kbd "M-RET") 'company-complete)
(global-set-key (kbd "C-c C-c") 'avy-goto-char)
;;(global-set-key [f8] 'semantic-ia-complete-symbol-menu)
(global-set-key [f8] 'robb-get-current-path)
;;(global-set-key (kbd "C-<f6>") 'cscope-find-this-symbol)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c C-c") 'c-mode)
(global-set-key (kbd "C-<f7>") 'cscope-find-functions-calling-this-function)
(global-set-key (kbd "M-g") 'goto-line)
;;(global-set-key [f12] 'helm-gtags-create-tags)
;;(global-set-key [f11] 'set-local-database)
;;(global-set-key [f10] 'set-block-database)
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (linemode_toggle)))

(global-set-key (kbd "<f7>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

(global-set-key (kbd "C-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-å") 'bookmark-set)
(global-set-key (kbd "C-ä") 'bookmark-jump)
(global-set-key (kbd "C-<tab>") 'projectile-find-other-file)
(global-set-key (kbd "C-r") 'revert-buffer)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-M-s-<up>") 'enlarge-window)
(global-set-key (kbd "C-M-s-<down>") 'shrink-window)
(global-set-key (kbd "C-M-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-l") 'helm-locate)
(global-set-key (kbd "C-f") 'helm-occur-from-isearch)


;;(global-set-key (kbd "§") 'complete)
