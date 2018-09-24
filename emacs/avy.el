(use-package avy
  :ensure t
  :init (define-key c-mode-map (kbd "C-c C-c") 'avy-goto-char)
  (define-key c++-mode-map (kbd "C-c C-c") 'avy-goto-char)
  (setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s
                            ?A ?O ?E ?U ?I ?D ?H ?T ?N ?S
                            ?p ?y ?f ?g ?c ?r ?l
                            ?P ?Y ?F ?G ?C ?R ?L))
  :bind ("C-c C-c" . avy-goto-char))
