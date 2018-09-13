(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(delete-selection-mode 1)
(dynamic-completion-mode)
(global-linum-mode 1)
(show-paren-mode 1)
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value
(setq c-default-style "linux"
      c-basic-offset 4)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; set a default font Office Code Pro
(when (member "Hack" (font-family-list))
  (set-face-attribute 'default nil :font "Hack-12"))

;; specify font for all unicode characters
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;; specify font for chinese characters using default chinese font on linux
(when (member "WenQuanYi Micro Hei" (font-family-list))
  (set-fontset-font t '(#x4e00 . #x9fff) "WenQuanYi Micro Hei" ))

(add-hook 'term-mode-hook (lambda ()
                            (setq-local global-linum-mode
                                        nil)))





