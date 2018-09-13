(require 'package) ;; You might already have this line
; list the packages you want see custom set variables in .emacs TODO: use-package instead
(setq package-list '(android-mode
                     elogcat
                     eopengrok
                     cquery
                     ws-butler
                     dtrt-indent
                     helm-ag
                     helm-rtags
                     helm-xref
                     rtags
                     flycheck
                     plantuml-mode
                     flymd
                     ibuffer-projectile
                     helm-gtags
                     ggtags
                     nix-mode
                     color-theme
                     helm
                     company
                     smart-mode-line
                     smart-mode-line-powerline-theme
                     elpy
                     jedi
                     which-key
                     magit
                     ccls
                     lsp-mode
                     lsp-ui
                     company-lsp
                     use-package
                     flycheck-plantuml))


(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize) ;; You might already have this line


; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

