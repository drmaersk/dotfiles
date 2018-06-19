(package-initialize)
(let ((default-directory  "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))

(load "/home/robban/.emacs.d/elpa/cquery-20180413.938/cquery.el")

(load "~/dotfiles/emacs/001-package.el")
(load "~/dotfiles/emacs/color-theme-settings.el")
(load "~/dotfiles/emacs/line-endings.el")
(load "~/dotfiles/emacs/helm.el")
(load "~/dotfiles/emacs/ibuffer.el")
(load "~/dotfiles/emacs/keybindings.el")
(load "~/dotfiles/emacs/editor.el")
(load "~/dotfiles/emacs/flymd.el")

;;cquery
(setq cquery-executable "/home/robban/.nix-profile/bin/cquery")

;; (defun cquery//enable ()
;;   (condition-case nil
;;       (lsp-cquery-enable)
;;     (user-error nil)))

;;   (use-package cquery
;;     :commands lsp-cquery-enable
;;     :init (add-hook 'c-mode-common-hook #'cquery//enable))
;; Also see lsp-project-whitelist lsp-project-blacklist cquery-root-matchers

;;cquery end

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

  ;; Package: ws-butler
(require 'ws-butler)
(add-hook 'c-mode-common-hook 'ws-butler-mode)

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

(setq-default indent-tabs-mode nil)
;;;; (color-theme company ggtags helm-gtags helm-projectile helm-swoop helm helm-core async ibuffer-projectile nix-mode popup projectile pkg-info epl dash)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cquery ws-butler dtrt-indent helm-ag helm-rtags rtags flycheck-irony flycheck plantuml-mode flymd ibuffer-projectile helm-gtags ggtags nix-mode color-theme helm company))))
(put 'downcase-region 'disabled nil)
