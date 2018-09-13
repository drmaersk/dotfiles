(elpy-enable)


(defun elpy//enable ()
  (condition-case nil
      (progn
        (flycheck-mode)
;;        (local-unset-key (kbd "M-left"))
;;        (local-unset-key (kbd "M-right"))
        (define-key elpy-mode-map (kbd "M-<left>") 'xah-previous-user-buffer)
        (define-key elpy-mode-map (kbd "M-<right>") 'xah-previous-user-buffer)
        )
    (user-error nil)))

;; (defun pymode//enable ()
;;   (condition-case nil
;;       (progn
;;         (local-set-key (kbd "C-c C-c") 'list-flycheck-errors)
;;         (local-set-key (kbd "C-x M-x") 'list-flycheck-errors)
;;         )
;;     (user-error nil)))


;; (add-hook 'file-name-shadow-mode-hook #'pymode//enable)


(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook #'elpy//enable))

(setq elpy-rpc-backend "jedi")

(pyvenv-activate "~/dev/python/python-venv/")


