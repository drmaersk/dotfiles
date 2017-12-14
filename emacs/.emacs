(package-initialize)
(let ((default-directory  "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))

(load "~/dotfiles/emacs/001-package.el")
(load "~/dotfiles/emacs/color-theme-settings.el")
(load "~/dotfiles/emacs/line-endings.el")
(load "~/dotfiles/emacs/helm.el")
(load "~/dotfiles/emacs/ibuffer.el")
(load "~/dotfiles/emacs/keybindings.el")
(load "~/dotfiles/emacs/editor.el")


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


;;;; (color-theme company ggtags helm-gtags helm-projectile helm-swoop helm helm-core async ibuffer-projectile nix-mode popup projectile pkg-info epl dash)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-irony flycheck plantuml-mode flymd ibuffer-projectile helm-gtags ggtags nix-mode color-theme helm company))))
