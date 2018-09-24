(use-package counsel-etags
  :ensure t
  :bind (("C-c C-t" . counsel-etags-find-tag-at-point))
  )

(use-package counsel
  :ensure t
  ;; :bind (("M-x" . counsel-M-x)
  ;;        ("<f1> f" . counsel-describe-function)
  ;;        ("<f1> v" . counsel-describe-variable)
  ;;        ("<f1> l" . counsel-find-library)
  ;;        ("<f2> i" . counsel-info-lookup-symbol)
  ;;        ("<f2> u" . counsel-unicode-char)
  ;;        ("C-c g" . counsel-git-grep)
  ;;        ("C-c j" . counsel-git)
  ;;        ("C-c k" . counsel-ag)
  ;;        ("C-c r" . counsel-rg)
  ;;        ("C-x l" . counsel-locate)
  ;;        :map minibuffer-local-map
  ;;        ("C-r" . counsel-minibuffer-add)
  ;;        )
  :config
  (if (executable-find "rg")
      ;; use ripgrep instead of grep because it's way faster
      (setq counsel-grep-base-command
            "rg -i -M 120 --no-heading --line-number --color never '%s' %s"
            counsel-rg-base-command
            "rg -i -M 120 --no-heading --line-number --color never %s ."
            )
    (warn "\nWARNING: Could not find the ripgrep executable. It "
          "is recommended you install ripgrep.")
    )
  )

(use-package helm-cscope
  :ensure t
  )
