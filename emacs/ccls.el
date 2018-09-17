

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

(setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)

;;(setq ccls-extra-init-params '(:cacheDirectory "/home/robban/.config/ccls" :enableComments 2 :cacheFormat "msgpack" :completion (:detailedLabel t)  ))

;; ;; Log file
(setq ccls-extra-args '("--log-file=/home/robban/.config/ccls/cq.log"))
;; ;; Cache directory, both relative and absolute paths are supported
(setq ccls-cache-dir "/home/robban/.config/ccls/")
;; ;; Initialization options
(setq ccls-extra-init-params '(:completion (:detailedLabel t)))


;; Value: ((-32700 "Parse Error")
;;  (-32600 "Invalid Request")
;;  (-32601 "Method not Found")
;;  (-32602 "Invalid Parameters")
;;  (-32603 "Internal Error")
;;  (-32099 "Server Start Error")
;;  (-32000 "Server End Error")
;;  (-32002 "Server Not Initialized")
;;  (-32001 "Unknown Error Code")
;;  (-32800 "Request Cancelled"))

(push '-32603 lsp--silent-errors) ;;Internal Error"
(push '-32002 lsp--silent-errors) ;;Server Not Initialized"



