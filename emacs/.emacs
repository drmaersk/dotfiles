
;; Addedee by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(let ((default-directory  "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))


(load "~/dotfiles/emacs/001-package.el")
(load "~/dotfiles/emacs/color-theme-settings.el")
(load "~/dotfiles/emacs/keybindings.el")
(load "~/dotfiles/emacs/line-endings.el")
(load "~/dotfiles/emacs/ibuffer.el")
;;(load "~/dotfiles/emacs/helm.el")



(setq inhibit-splash-screen t)
(delete-selection-mode 1)
(dynamic-completion-mode)
(global-linum-mode 1)


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
    (helm-gtags ggtags nix-mode color-theme helm company))))
