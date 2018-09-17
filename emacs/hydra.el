(use-package hydra
  :ensure t)
  ;; no :pin needed, as package.el will choose the version in melpa


;; (defhydra hydra-zoom (global-map "<f2>")
;;   "zoom"
;;   ("g" text-scale-increase "in")
;;   ("l" text-scale-decrease "out"))


(defhydra hydra-buffer-menu (:color pink
                             :hint nil)

  "

^  ^Find^             ^Show^             ^Actions^          ^Search
^  ^^^^^^^^-----------------------------------------------------------------
^  _r_: references    _m_: members       _p_: preprocess    _f_: file
^  _d_: definition    _c_: callers       _R_: rename        _P_: replace
^  _a_: apropos       ^ ^                ^ ^                _O_: multi-occur
^  _g_: grep          ^ ^                ^ ^
^  ^ ^
"
  ("r" lsp-ui-peek-find-references)
  ("d" lsp-ui-peek-find-definitions)
  ("a" xref-find-apropos)
  ("g" robb-grep)
  ("m" ccls-member-hierarchy)
  ("c" ccls-call-hierarchy)
  ("R" lsp-rename)
  ("p" ccls-preprocess-file)
  ("O" Buffer-menu-multi-occur :color blue)
  ("P" query-replace :color blue)
  ("f" robb-search-in-file :color blue)
  ("q" nil "quit" :color blue))
 
(global-set-key [f2] 'hydra-buffer-menu/body)

