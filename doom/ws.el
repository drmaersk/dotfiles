;;; ws.el -*- lexical-binding: t; -*-


IDevice.hal
types.hal
IStreamOut.hal<2>
(gethash "main" *persp-hash*)

(persp-get-by-name "AR")


(gethash "AR" *persp-hash*)

(dolist (item (cdr (persp-names) ))
  (message "pers:%s buffers:%s" item  (persp-buffers (persp-get-by-name item))))

(persp-buffers (persp-get-by-name "AR"))

(eq
(get-current-persp)
(persp-get-by-name "WS"))

(persp-remove-buffer "IDevice.hal" (persp-get-by-name "audiohal71"))
(persp-add-buffer "IDevice.hal" (persp-get-by-name "main"))

(persp-buffer-list)

(select-hobby
 (persp-buffers (persp-get-by-name "main"))
)
(+vertico/switch-workspace-buffer "audiohal71")

(+vertico--workspace-generate-sources)


import-buffer
(setq persp-add-buffer-on-after-change-major-mode t)


(defun my-dired-perspective ()
  "Automatically switch to or create a 'Dired' perspective for all `dired-mode` buffers."
  (when (eq major-mode 'dired-mode)
    (let ((persp-name "Dired"))
      (unless (gethash persp-name *persp-hash*)
        (persp-add-new persp-name))
      (persp-switch persp-name))))


(defun my-dired-perspective ()
  "Switch to a 'Dired' perspective for all `dired-mode` buffers, adding them only to this perspective."
  (when (eq major-mode 'dired-mode)
    (let ((persp-name "Dired")
          (old-perspective (get-current-persp))
          )
      ;; Create the "Dired" perspective if it doesn't exist
      (unless (gethash persp-name *persp-hash*)
        (persp-add-new persp-name))
      ;; Switch to the "Dired" perspective and add the buffer to it
      (persp-switch persp-name)
      (persp-add-buffer (current-buffer) (gethash persp-name *persp-hash*) nil)
      ;; Remove buffer from any other perspective
      (unless (eq
       (get-current-persp)
       (persp-get-by-name persp-name))
      (persp-remove-buffer (current-buffer) old-perspective t)))))

(add-hook 'dired-mode-hook #'my-dired-perspective)

(defun my-vterm-perspective ()
  "Switch to a 'Dired' perspective for all `dired-mode` buffers, adding them only to this perspective."
  (when (eq major-mode 'vterm-mode)
    (let ((persp-name "vterm")
          (old-perspective (get-current-persp))
          )
      ;; Create the "Dired" perspective if it doesn't exist
      (unless (gethash persp-name *persp-hash*)
        (persp-add-new persp-name))
      ;; Switch to the "Dired" perspective and add the buffer to it
      (persp-switch persp-name)
      (persp-add-buffer (current-buffer) (gethash persp-name *persp-hash*) nil)
      ;; Remove buffer from any other perspective
      ;;
      (message "old-perspective %S persp-name %S"
               (safe-persp-name old-perspective) persp-name)

      (unless (equal
       (safe-persp-name old-perspective)
       persp-name)
        (message "old and new is not the same -> remove buffer")

    (let (
          (buffer (persp-get-buffer-or-null (current-buffer)))
          (oldp old-perspective)
          )
       (message "111")

      (when buffer
          (message "222")
        (let ((persp oldp))
          (when (and persp (persp-contain-buffer-p* buffer persp))
             (message "buffer should have been removed!!!!")
              (persp-remove-buffer buffer persp nil nil nil nil)))))))))



      ;; (persp-remove-buffer (current-buffer) old-perspective nil nil nil nil)
      ;;         (message "buffer should have been removed")
      ;; ))))


  (defun test-vterm-hook ()
    (message "buffer opened in %S in %S"
             (current-buffer) (safe-persp-name (get-current-persp))))


(defun my-vterm-hook ()
(my-vterm-perspective)
(test-vterm-hook))

(add-hook 'vterm-mode-hook #'my-vterm-hook)


(persp--buffer-in-persps (current-buffer))

(add-hook 'org-mode-hook 'my-org-mode-hook)

(defun print-my-hook ()
          (message "after switch"))

(add-hook 'after-switch-to-buffer-functions #'print-my-hook)

()


(persp-def-auto-persp "MyVtermPersp"
  :mode 'vterm-mode
  :hooks '(vterm-mode-hook)
  :switch 'frame
  :parameters '((dont-save-to-file . t)))



  (add-hook 'org-roam-file-setup-hook 'bjc/test-roam-hook)

(with-eval-after-load "persp-mode"
      (with-eval-after-load "dired"
        (persp-def-auto-persp "dired"
          :parameters '((dont-save-to-file . t))
          :mode 'dired-mode
          :dyn-env '(after-switch-to-buffer-functions ;; prevent recursion
                     (persp-add-buffer-on-find-file nil)
                     persp-add-buffer-on-after-change-major-mode)
          :hooks '(after-switch-to-buffer-functions)
          :switch 'window)))

 (with-eval-after-load "term"

    (persp-def-auto-persp "vterm"
                          :parameters '((dont-save-to-file . t))
                          :mode 'vterm-mode
                          :dyn-env '(after-switch-to-buffer-functions ;; prevent recursion
                                     (persp-add-buffer-on-find-file nil)
                                     persp-add-buffer-on-after-change-major-mode)
                          :hooks '(after-switch-to-buffer-functions)
                          :switch 'window)
    )




;; To create a new read-only buffer that displays all items in an input list in Emacs Lisp, you can use the following steps:

;; Create a buffer using generate-new-buffer.
;; Insert content (each item in the list) into the buffer.
;; Make the buffer read-only using read-only-mode or buffer-read-only.
;; Here’s a complete function:

(defun display-list-in-read-only-buffer (list buffer-name)
  "Create a new read-only buffer and display all items in LIST."
  (let ((buffer (generate-new-buffer buffer-name)))
    (with-current-buffer buffer
      ;; Insert each item from the list
      (dolist (item list)
        (insert (format "%s\n" item)))
      ;; Enable read-only mode
      (read-only-mode 1))
    ;; Display the buffer
    (switch-to-buffer buffer)))



(defun compute-area (length width)
  "Calculate the area of a rectangle given LENGTH and WIDTH."
  (progn
    (message "Calculating area...")
    (* length width)))  ;; Return the area


(compute-area 5 4)
(persp-get-by-name "org")



;;Example: getting the non current workspaces
(setq my-list (+workspace-list-names))
(cl-remove-if (lambda (x) (string= x (+workspace-current-name))) my-list)

;; keep this
(require 'cl-lib)
(defun select-other-perspective ()
  "Display a list of non current perspectives in the minibuffer for selection."
  (completing-read "Choose a perspective: "
                   (cl-remove-if (lambda (workspace-name) (string= workspace-name (+workspace-current-name)))
                                 (+workspace-list-names))))

(defun move-buffer-to-persp ()
(interactive)
(setq selected-p (select-other-perspective))
(persp-add-buffer (current-buffer) (gethash selected-p *persp-hash*))
(persp-remove-buffer (current-buffer)))

  )



(persp-add-buffer (current-buffer) (gethash "org" *persp-hash*))
(persp-remove-buffer (current-buffer))

(persp-remove-buffer (current-buffer) (gethash "org" *persp-hash*))

(persp-add-buffer (current-buffer)
(persp-switch-to-buffer (car (persp-buffer-list)))

;;move buffer from current ws to other
(+workspace-current-name)
(+workspace-list-names)
(+workspace-buffer-list)



(persp-name)

(display-list-in-read-only-buffer  (persp-buffers (persp-get-by-name "AR")) "*Test*")

 (dolist (item (cdr (persp-names) ))
  (message "pers:%s buffers:%s" item  (persp-buffers (persp-get-by-name item))))




(defun select-perspective (perspList)
  "Display a list of HOBBIES in the minibuffer for selection."
  (let ((selectedPersp (completing-read "Choose a perspective: " perspList)))
    (message "You selected: %s" selectedPersp)))

(select-perspective (cdr (persp-names) ))


(defun buffer-list-to-names (buffers)
  "Convert a list of buffer objects BUFFERS to a list of buffer names."
  (mapcar #'buffer-name buffers))

(setq my-buffers  (persp-buffers (persp-get-by-name "AR")))
(select-hobby (buffer-list-to-names my-buffers))


(global-set-key (kbd "C-x b") #'(lambda (arg)
<                                      (interactive "P")
                                      (with-persp-buffer-list () (ibuffer arg))))


(defun my/ibuffer-save-marked-buffers-names ()
  "Save the names of marked buffers in `ibuffer' to the kill ring."
  (interactive)
  (let ((buffers (ibuffer-get-marked-buffers)))
    (kill-new
     (mapconcat 'buffer-name buffers "\n"))
    (message "Saved marked buffer names to kill ring.")))


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



(defun my/show-project-root ()
  "Display the root directory of the current project in the echo area."
  (interactive)
  (if-let ((project (project-current)))
      (message "Project root: %s" (car (project-roots project)))
    (message "No project found.")))


(defun my/create-symlink-to-project-root (compstring)
  "Create a symbolic link from COMPSTRING to the current project's root directory."
  (interactive "FPath to create symbolic link: ")
  (if-let ((project (project-current)))
      (let ((project-root (car (project-roots project))))
        (make-symbolic-link project-root compstring t)
        (message "Created symbolic link from %s to %s" compstring project-root))
    (message "No project found.")))





  ;; Define custom faces
  (defface error-face
    '((t (:foreground "white" :background "red" :weight bold)))
    "Face for errors.")

    (defface debug-face
    '((t (:foreground "black" :background "yellow")))
    "Face for debug messages.")

(define-derived-mode my-log-mode fundamental-mode "Log Mode"
  "A major mode for highlighting specific patterns in log files."

  ;; Syntax highlighting rules
  (setq font-lock-defaults
        '((("[[:space:]]E[[:space:]]" . 'error-face)      ; Highlight [ERROR]
           ("[[:space:]]F[[:space:]]DEBUG[[:space:]][[:space:]][[:space:]]" . 'error-face)
           ("Abort message:" . 'debug-face)
           ("\\[INFO\\]" . font-lock-keyword-face)      ; Highlight [INFO]
           ("\\[DEBUG\\]" . font-lock-comment-face)     ; Highlight [DEBUG]
           ("\\b[0-9]+\\b" . font-lock-constant-face)   ; Highlight numbers
           ("\\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\b" . font-lock-string-face))))) ; Highlight email addresses


;;font-lock-warning-face

;; Associate the mode with .log files
(add-to-list 'auto-mode-alist '("\\.log\\'" . my-log-mode))



(defun show-interactive-list ()
  "Display an interactive list in a dedicated buffer."
  (let ((buffer (get-buffer-create "*Interactive List*")))
    (with-current-buffer buffer
      (let ((items '(("Item 1" "Description 1")
                     ("Item 2" "Description 2")
                     ("" "Description 2")
                     ("Item 3" "Deeaouscription 3" "fjart"))))
        ;; Set up the tabulated-list-mode
        (setq tabulated-list-format [("Name" 20 t) ("Description" 30 nil)])
        (setq tabulated-list-entries
              (mapcar (lambda (item)
                        (list (car item) (vector (car item) (cadr item))))
                      items))
        (tabulated-list-init-header)
        (tabulated-list-mode))
      (tabulated-list-print))
    (pop-to-buffer buffer)))

(show-interactive-list )

(defun copy-buffer-name-to-clipboard ()
  "Copy the name of the current buffer to the clipboard."
  (interactive)
  (let ((buffer-name (buffer-name)))
    (when buffer-name
      (kill-new buffer-name)
      (message "Copied buffer name '%s' to clipboard" buffer-name))))
(global-set-key (kbd "C-c n") 'copy-buffer-name-to-clipboard)


(define-derived-mode my-custom-mode fundamental-mode "MyMode"
  "A simple custom mode for demonstration."
  ;; Mode-specific settings go here
  (setq-local tab-width 4)       ;; Example: Set tab width to 4
  (setq-local fill-column 80)    ;; Example: Set maximum line width
  (setq-local buffer-read-only 1)
  )

(define-derived-mode dotcrafter-mode fundamental-mode "MyMode"
  "Toggles global dotcrafter-mode."
  nil   ; Initial value, nil for disabled
  :global t
  :group 'dotfiles
  :lighter " dotcrafter"
  :keymap
  (map! :prefix "C-c"
      ;;; <leader> b --- buffer
        (:prefix ("C-." . "stuff")
         :desc "Terminal"                 "t"   #'my-term
        ))

  (if dotcrafter-mode
      (message "dotcrafter-basic-mode activated!")
    (message "dotcrafter-basic-mode deactivated!")))

(add-hook 'dotcrafter-mode-hook (lambda () (message "Hook was executed!")
                                  (delete-other-windows)
                                  ))
(add-hook 'dotcrafter-mode-on-hook (lambda () (message "dotcrafter turned on!")))
(add-hook 'dotcrafter-mode-off-hook (lambda () (message "dotcrafter turned off!")))


(map! :prefix "C-a"
      (:prefix ("a" . "open")
      :desc "Custom action" "a" #'eshell
      )
      (:prefix ("b" . "open")
      :desc "Custom terminal" "t" #'my-term))


(general-def
  :prefix-map 'my-navmap
  "<right>" #'evil-next-buffer
  "<left>" #'evil-prev-buffer
  "<up>" #'baz
  "<down>" #'baz
  "m" '(:ignore t :wk "mmap")
  "mf" #'mfoo
  "mb" #'mbar
  "mz" #'mbaz)

(hercules-def
 :toggle-funs #'my-navmode
 :keymap 'my-navmap
 :transient t)

(map! "H-i" #'my-navmode)


(set persp-init-frame-behaviour 'prompt)

(setq persp-interactive-init-frame-behaviour-override -1)
(setq persp-emacsclient-init-frame-behaviour-override -1)
