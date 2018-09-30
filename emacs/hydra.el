(use-package hydra
  :ensure t)
  ;; no :pin needed, as package.el will choose the version in melpa


;; (defhydra hydra-zoom (global-map "<f2>")
;;   "zoom"
;;   ("g" text-scale-increase "in")
;;   ("l" text-scale-decrease "out"))

(defhydra hydra-super-gitter (:color pink
                             :hint nil)

  "

^  ^Commands^        
^  ^^^^^^^^----------
^  _s_: status   
^  _d_: diff-mode   
^  _n_: next-diff      
^  _p_: prev-diff         
^  ^ ^
"
  ("s" magit-status :exit t)
  ("d" git-gutter:popup-hunk)
  ("n" git-gutter:next-hunk)
  ("p" git-gutter:previous-hunk)
  ("q" nil "quit"))


(defhydra hydra-super-searcher (:color pink
                             :hint nil)

  "

^  ^Find^             ^Show^             ^Actions^          ^Search
^  ^^^^^^^^-----------------------------------------------------------------
^  _r_: references    _G_: GIT           _p_: preprocess    _f_: file
^  _d_: definition    _c_: callers       _R_: rename        _P_: replace
^  _a_: apropos       _m_: members       ^ ^                _O_: multi-occur
^  _g_: grep          ^ ^                ^ ^
^  ^ ^
"
  ("r" lsp-ui-peek-find-references :exit t)
  ("d" lsp-ui-peek-find-definitions :exit t)
  ("a" xref-find-apropos :exit t)
  ("g" robb-grep :exit t)
  ("m" ccls-member-hierarchy :exit t)
  ("c" ccls-call-hierarchy :exit t)
  ("G" hydra-super-gitter/body :exit t)
  ("R" lsp-rename :exit t)
  ("p" ccls-preprocess-file :exit t)
  ("O" Buffer-menu-multi-occur :exit t)
  ("P" query-replace :exit t)
  ("f" robb-search-in-file :exit t)
  ("q" nil "quit"))
 
(global-set-key [f2] 'hydra-super-searcher/body)

(defhydra hydra-locater (:color pink
                             :hint nil)

  "

^  ^Commands^        
^  ^^^^^^^^----------
^  _1_: rootdb
^  _2_: ihudb
^  _3_: ihu_aptivdb
^  _4_: semdb
^  _5_: sem_aptivdb
^  _s_: search
^  ^ ^
"
  ("1" setlocate-root)
  ("2" setlocate-ihu)
  ("3" setlocate-ihu_aptiv)
  ("4" setlocate-sem)
  ("5" setlocate-sem_aptiv)
  ("s" helm-locate :exit t))
(global-set-key (kbd "C-l") 'hydra-locater/body)

