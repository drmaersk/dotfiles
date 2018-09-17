(use-package doom-themes
  :ensure t
  :init
  :config
  (load-theme 'doom-one t)  
  )

(use-package doom-modeline
      :ensure t
      :defer t
      :hook (after-init . doom-modeline-init))
