;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq user-full-name "Roberth Allevik"
      user-mail-address "r.allevik@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq kill-whole-line t)

(require 'which-key)
(setq which-key-idle-delay 0.1)
(which-key-mode)

;;(desktop-save-mode)
;;(desktop-read)

(require 'magit)
(defun magit-push-to-gerrit ()
 (interactive)
 (magit-git-command "git push origin HEAD:refs/for/master" ))

(defun magit-push-to-gerrit-wip ()
 (interactive)
 (magit-git-command "git push origin HEAD:refs/for/master%wip" ))


 (transient-append-suffix 'magit-push "o"
   '("g" "Push to gerrit" magit-push-to-gerrit))

 (transient-append-suffix 'magit-push "o"
   '("w" "Push to gerrit wip" magit-push-to-gerrit-wip))


(defun my-term ()
  (interactive)
  (term "/bin/bash"))


(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

;; small fixes to leader
(map! :leader
      (:prefix ("o" . "open")
        :desc "Terminal"        "t"   #'my-term
        :desc "eshell"          "e"   #'eshell
        )

      (:prefix ("b" . "buffer")
        :desc "Revert Buffer"    "r"   #'revert-buffer-no-confirm)

      (:prefix ("p" . "project")
        :desc "Other file"       "o"   #'projectile-find-other-file)
)


(defun copy-path ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("--header-insertion-decorators=0"
          "--compile-commands-dir=/home/roberth/sources/haleytek-gpa/android"
          "-j=1"
          "--background-index=false")))
(defun toggle-evilmode ()
  (interactive)
  (if (bound-and-true-p evil-local-mode)
    (progn
      ; go emacs
      (evil-local-mode (or -1 1))
;;      (undo-tree-mode (or -1 1))
      (set-variable 'cursor-type 'bar)
    )
    (progn
      ; go evil
      (evil-local-mode (or 1 1))
      (set-variable 'cursor-type 'box)
    )
  )
)

(global-set-key (kbd "M-u") 'toggle-evilmode)

(defun vterm-send-c-o ()
  "Quote the next character in term-mode.
Similar to how `quoted-insert' works in a regular buffer."
  (interactive)
  (term-send-raw-string "\C-o"))

(defun vterm-send-c-x ()
  "Quote the next character in term-mode.
Similar to how `quoted-insert' works in a regular buffer."
  (interactive)
  (term-send-raw-string "\C-x"))


(defun vterm-send-c-c ()
  "Quote the next character in term-mode.
Similar to how `quoted-insert' works in a regular buffer."
  (interactive)
  (term-send-raw-string "\C-c"))

(add-to-list 'auto-mode-alist '("\\.bp\\'" . bazelrc-mode))

(map! "C-x k" #'kill-current-buffer)

(map! "<M-right>" #'+workspace/switch-right)
(map! "<M-left>" #'+workspace/switch-left)

(map! "<C-M-right>" #'windmove-right)
(map! "<C-M-left>" #'windmove-left)
(map! "<C-M-up>" #'windmove-up)
(map! "<C-M-down>" #'windmove-down)

(map! "<M-up>" #'drag-stuff-up)
(map! "<M-down>" #'drag-stuff-down)


(map! "C-x C-b" #'ibuffer)
(map! "C-c C-c" #'comment-or-uncomment-region)
(map! "<C-SPC>" #'set-mark-command)
(map! "H-z" #'undo)
(map! "H-b" #'+vertico/switch-workspace-buffer)
(map! "H-n" #'rename-buffer)
(map! "H-t" #'+vterm/here)
(map! "H-c" #'avy-goto-char-2)
(map! "H-g" #'helm-gtags-dwim)
(map! "H-l" #'consult-locate)
(map! "H-k" #'kill-current-buffer)
(map! "H-r" #'revert-buffer-no-confirm)
(map! "H-h" #'help)
(map! "C-f" #'consult-ripgrep)
(map! "H-<left>" #'windmove-left)
(map! "H-<right>" #'windmove-right)
(map! "H-<down>" #'windmove-down)
(map! "H-<up>" #'windmove-up)
(map! "C-H-<left>" #'shrink-window-horizontally)
(map! "C-H-<right>" #'enlarge-window-horizontally)
(map! "C-H-<down>" #'shrink-window)
(map! "C-H-<up>" #'enlarge-window)
(map! "H-0" #'delete-window)
(map! "H-1" #'delete-other-windows)
(map! "H-2" #'split-window-below)
(map! "H-3" #'split-window-horizontally)
(map! "M-g g" #'avy-goto-line)
(map! "M-g M-g" #'avy-goto-line)
(map! "H-§" #'evil-emacs-state)


(require 'hercules)
(require 'windresize)
(hercules-def
 :show-funs #'windresize
 :hide-funs '(windresize-exit windresize-cancel-and-quit)
 :keymap 'windresize-map)

(map! "H-u" #'windresize)

 (global-set-key (kbd "C-x b")
                 #'(lambda (arg)
                     (interactive "P")
                     (with-persp-buffer-list () (ibuffer arg))))
;;kitty keyboard
(global-kkp-mode +1)

(defun my-multi-occur-in-matching-buffers (regexp &optional allbufs)
  "Show lines matching REGEXP in all file-visiting buffers.

Given a prefix argument, search in ALL buffers."
  (interactive (occur-read-primary-args))
  (multi-occur-in-matching-buffers "." regexp allbufs))

(defun my-non-log-buffers ()
  "Return a list of buffers whose names do not end with '.log'."
  (seq-filter
   (lambda (buf)
     (not (string-suffix-p ".log" (buffer-name buf))))
   (buffer-list)))

(defun my-multi-occur-non-log-buffers (regexp)
  "Run `multi-occur` on all buffers except those ending with '.log'."
  (interactive "sRegexp: ")
  (multi-occur (my-non-log-buffers) regexp))

(global-set-key (kbd "M-s /") 'my-multi-occur-in-matching-buffers)

(after! corfu
(evil-define-key 'normal corfu-mode-map
  (kbd "C-SPC") 'set-mark-command))

 (global-set-key (kbd "C-SPC") 'set-mark-command)

(after! org
(map! :map org-mode-map
      "<M-right>" #'+workspace/switch-right
      "<M-left>" #'+workspace/switch-left))

(custom-theme-set-faces! 'doom-dark+
  '(org-level-3 :inherit outline-4)
  '(org-level-4 :inherit outline-5)
  '(org-level-5 :inherit outline-6)
  '(org-level-6 :inherit outline-7)
  '(org-level-7 :inherit outline-1 :weight normal)
  '(org-level-8 :inherit outline-2 :weight normal)
  '(org-tag :foreground "#D9DAA2" :weight normal))

(setq +workspaces-on-switch-project-behavior nil)
(setq persp-add-buffer-on-find-file nil)
(setq persp-interactive-init-frame-behaviour-override -1)
(setq persp-emacsclient-init-frame-behaviour-override -1)
(set persp-init-frame-behaviour 'prompt)

(require 'cl-lib)
(defun select-perspective ()
  "Display a list of non current perspectives in the minibuffer for selection."
  (completing-read "Choose a perspective: "
                                        (cl-remove-if (lambda (workspace-name) (string= workspace-name (+workspace-current-name))) (+workspace-list-names))))

(defun move-buffer-to-persp ()
  (interactive)
  (setq selected-p (select-perspective))
  (persp-add-buffer (current-buffer) (gethash selected-p *persp-hash*))
  (persp-remove-buffer (current-buffer)))

(defun chmodX ()
  ;;chmod +x current file
  (interactive)
  (call-process-shell-command
   (format "chmod +x %s" (buffer-file-name))
   nil 0))
