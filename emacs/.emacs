(setq inhibit-splash-screen t)
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

(delete-selection-mode 1)
(dynamic-completion-mode)
(global-linum-mode 1)

(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value
(setq c-default-style "linux"
      c-basic-offset 4)

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
 '(package-selected-packages
   (quote
	(ibuffer-projectile helm-gtags ggtags nix-mode color-theme helm company))))
