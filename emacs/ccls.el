

;;ccls
(require 'helm-xref)
(setq xref-show-xrefs-function 'helm-xref-show-xrefs)

(require 'ccls)
(setq ccls-executable "/run/current-system/sw/bin/ccls")

(with-eval-after-load 'projectile
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json"
                  ".ccls")
                projectile-project-root-files-top-down-recurring)))



(defun ccls//enable ()
  (condition-case nil
      (progn
        (lsp-ccls-enable)
        (lsp-ui-mode)
        (company-mode)
        (yas-minor-mode-on)
        (setq lsp-ui-sideline-mode nil)
        (flycheck-mode)
        (local-set-key (kbd "C-c C-c") 'list-flycheck-errors)
        )
    (user-error nil)))

(use-package ccls
  :commands lsp-ccls-enable
  :init
  (add-hook 'c-mode-hook #'ccls//enable)
  (add-hook 'c++-mode-hook #'ccls//enable)
  :config
  (setq ccls-sem-highlight-method 'font-lock)
;; alternatively, (setq ccls-sem-highlight-method 'overlay)
;; For rainbow semantic highlighting
;;  (ccls-use-default-rainbow-sem-highlight)
  )

  (use-package company
    :ensure t
    :config
    (setq company-idle-delay 0.5)
    (setq company-tooltip-limit 10)
    (setq company-minimum-prefix-length 2)
    ;; invert the navigation direction if the the completion popup-isearch-match
    ;; is displayed on top (happens near the bottom of windows)
    (setq company-global-modes '(not org-mode text-mode emacs-lisp-mode))
    (global-company-mode 1)
    )


;; (add-hook 'c-mode-hook
;;           (lambda () (lsp-ccls-enable)))

;; (add-hook 'c++-mode-hook
;;           (lambda () (lsp-ccls-enable)))

(setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)

;;(setq ccls-extra-init-params '(:cacheDirectory "/home/robban/.config/ccls" :enableComments 2 :cacheFormat "msgpack" :completion (:detailedLabel t)  ))

;; ;; Log file
(setq ccls-extra-args '("--log-file=/home/robban/.config/ccls/cq.log"))
;; ;; Cache directory, both relative and absolute paths are supported
(setq ccls-cache-dir "/home/robban/.config/ccls/")
;; ;; Initialization options
(setq ccls-extra-init-params '(:completion (:detailedLabel t)))



;; Also see lsp-project-whitelist lsp-project-blacklist ccls-root-matchers


