;; Time-stamp: <2017-02-12 13:37:25 csraghunandan>

;; haskell-mode: major mode for editing haskell files
;; https://github.com/haskell/haskell-mode
(use-package haskell-mode
  :config
  ;; more snippets for haskell-mode
  ;; https://github.com/haskell/haskell-snippets
  (use-package haskell-snippets)

  (defun my-haskell-mode-hook ()
    "Hook for `haskell-mode'."
    (set (make-local-variable 'company-backends)
         '((company-intero company-files company-yasnippet))))
  (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook (lambda ()
                                 ;; disable haskell-indentation-mode
                                 (setq haskell-indentation-mode nil)))

  ;; intero-mode: IDE features for haskell
  ;; commercialhaskell.github.io/intero
  (use-package intero
    :diminish inter-mode "𝐈𝐧"
    :config (add-hook 'haskell-mode-hook 'intero-mode))

  ;; hindent: format haskell code automatically
  ;; https://github.com/chrisdone/hindent
  (when (executable-find "hindent")
    (use-package hindent
      :diminish hindent-mode "𝐇𝐢"
      :config
      (add-hook 'haskell-mode-hook #'hindent-mode)
      ;; reformat the buffer using hindent on save
      (setq hindent-reformat-buffer-on-save t)))

  ;; structured-haskell-mode: paredit like features for haskell code
  ;; https://github.com/chrisdone/structured-haskell-mode
  (when (executable-find "structured-haskell-mode")
    (use-package shm
      :diminish (structured-haskell-mode . "𝐒𝐇𝐌")
      :config
      (add-hook 'haskell-mode-hook 'structured-haskell-mode)
      (add-hook 'structured-haskell-mode-hook (lambda ()
                                                (smartparens-mode -1)
                                                (smartparens-strict-mode -1)))
      ;; add case splits for simple sum types
      (require 'shm-case-split)
      (bind-key "C-c |" 'shm/case-split haskell-mode-map)))

  ;; enable hlint checker for flycheck
  (when (executable-find "hlint")
    (flycheck-add-next-checker 'intero
                               'haskell-hlint)))

(provide 'setup-haskell)

;; Haskell intero config
;; `C-c C-l' to load the current file to stack GHCi
;; `C-c C-z' to open stack GHCi
;; `C-c C-t' to see the type of the thing at point
;; `M-.' jump to definition
;; `M-,' jump back from definition
;; `M-q' to format the expression at point using hindent
;; `C-M-\' to format the selected region using hindent

;; structured-haskell-mode
;; `C-j' will automatically add a comma when inside a ilst
;; `C-+' will will look at the current node and add another operand in the direction the cursor is leaning towards
;; automatically reindents code as we type(similar to aggressive indent)
;; multi line strings: press `C-j' while inside a string to split it to next line
;; `C-c |' to add case splits for simple sum types
;; `C-k' will act like `sp-kill-hybrid-sexp'
;; `)' will move cursor to the end of  the parent
;; Skeletons: Typing prefixes of common syntax will auto-fill in the structure
;;            with "slots" that you can hit TAB to jump to, which auto-disappear
;;            when you type in them
;;
