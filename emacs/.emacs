(package-initialize)
(let ((default-directory  "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))

(load "~/dotfiles/emacs/001-package.el")

;;(load "/home/robban/.emacs.d/elpa/cquery-20180413.938/cquery.el")

(load "~/dotfiles/emacs/color-theme-settings.el")
;;(load "~/dotfiles/emacs/line-endings.el")
(load "~/dotfiles/emacs/helm.el")
(load "~/dotfiles/emacs/ibuffer.el")
(load "~/dotfiles/emacs/editor.el")
(load "~/dotfiles/emacs/python.el")
(load "~/dotfiles/emacs/locate.el")
(load "~/dotfiles/emacs/scratch.el")
(load "~/dotfiles/emacs/ccls.el")
(load "~/dotfiles/emacs/hydra.el")
;; Keep last so everything is loaded
(load "~/dotfiles/emacs/xah.el")
(load "~/dotfiles/emacs/keybindings.el")
;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; Package: ws-butler
(require 'ws-butler)
(add-hook 'c-mode-common-hook 'ws-butler-mode)

(which-key-mode)

;; No backup-files
(setq backup-directory-alist `(("." . "~/.saves")))
;;(setq make-backup-files nil)
(setq delete-old-versions  t)
(server-start)
(setq x-select-enable-clipboard t)

(setq-default indent-tabs-mode nil)

;; Plant-uml stuff
(require 'flycheck-plantuml)
(flycheck-plantuml-setup)
(add-to-list 'auto-mode-alist '("\\.uml\\'" . plantuml-mode))
(add-hook 'plantuml-mode-hook 'flycheck-mode)

;;Smart mode line
(setq sml/no-confirm-load-theme t)
;; These two lines are just examples
(setq powerline-arrow-shape 'curve)
(setq powerline-default-separator-dir '(right . left))
;; These two lines you really need.
(setq sml/theme 'powerline)
(sml/setup)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:background "red" :foreground "white" :box nil :underline (:color "white" :style wave) :slant italic))))
 '(sml/filename ((t (:inherit sml/global :foreground "dark cyan" :weight bold))))
 '(sml/global ((t (:background "dim gray" :foreground "gray50" :inverse-video nil)))))
(put 'upcase-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(after-save-hook (quote (sml/generate-buffer-identification)))
 '(company-backends
   (quote
    (company-lsp company-clang company-xcode company-cmake company-capf company-files
                 (company-dabbrev-code company-gtags company-etags company-keywords)
                 company-oddmuse company-dabbrev)))
 '(helm-locate-command
   "locate %s -d /home/robban/.config/locatedb/ihudb -e -A --regex %s")
 '(lsp-ui-sideline-enable nil)
 '(package-selected-packages
   (quote
    (dracula-theme flycheck-plantuml elpy guide-key smart-mode-line android-mode elogcat eopengrok cquery ws-butler dtrt-indent helm-ag helm-rtags rtags flycheck-irony flycheck plantuml-mode flymd ibuffer-projectile helm-gtags ggtags nix-mode color-theme helm company)))
 '(plantuml-jar-path "/home/robban/.config/plantuml/plantuml.jar")
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote sml/global)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes))))
(put 'downcase-region 'disabled nil)


;;(load-theme 'dracula t)
  ;; (require 'color)
  
  ;; (let ((bg (face-attribute 'default :background)))
  ;;   (custom-set-faces
  ;;    `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
  ;;    `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
  ;;    `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
  ;;    `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
  ;;    `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))


;; (setq sml/no-confirm-load-theme t)
;; ;; These two lines are just examples
;; (setq powerline-arrow-shape 'curve)
;; (setq powerline-default-separator-dir '(right . left))
;; ;; These two lines you really need.
;; (setq sml/theme 'powerline)
;; (sml/setup)
