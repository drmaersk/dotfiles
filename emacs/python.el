(elpy-enable)

(use-package jedi
 :ensure t)

(defun elpy//enable ()
  (condition-case nil
      (progn
        (flycheck-mode)
       (jedi:setup)
;;        (local-unset-key (kbd "M-left"))
;;        (local-unset-key (kbd "M-right"))
        (define-key elpy-mode-map (kbd "M-<left>") 'xah-previous-user-buffer)
        (define-key elpy-mode-map (kbd "M-<right>") 'xah-previous-user-buffer)
       (define-key elpy-mode-map (kbd "C-RET") 'elpy-company-backend)
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
;;pip install jedi rope flake8 yapf importmagic
(setq elpy-rpc-backend "jedi")

(pyvenv-activate "~/Dev/python/venv/")


