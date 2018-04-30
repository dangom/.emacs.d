;; Time-stamp: <2018-04-30 17:37:29 csraghunandan>

(use-package python
  :ensure nil
  :hook ((python-mode . (lambda ()
                          (require 'lsp-python)
                          (lsp-python-enable)
                          (lsp-ui-mode)
                          (eldoc-mode)
                          (flycheck-mode)
                          (smart-dash-mode)
                          (company-mode)))
         (python-mode . (lambda ()
                          (setq-local tab-width 4)))
         (inferior-python-mode . company-mode))
  :config
  ;; don't try to guess python indent offset
  (setq python-indent-guess-indent-offset nil)

  (defun my-python-mode-hook ()
    (set (make-local-variable 'company-backends)
         '(company-lsp company-yasnippet company-files)))
  (add-hook 'python-mode-hook #'my-python-mode-hook)

  ;; from https://www.snip2code.com/Snippet/127022/Emacs-auto-remove-unused-import-statemen
  (defun python-remove-unused-imports()
    "Use Autoflake to remove unused function"
    "autoflake --remove-all-unused-imports -i unused_imports.py"
    (interactive)
    (if (executable-find "autoflake")
        (progn
          (shell-command (format "autoflake --remove-all-unused-imports -i %s"
                                 (shell-quote-argument (buffer-file-name))))
          (revert-buffer t t t))
      (warn "python-mode: Cannot find autoflake executable, automatic removal of unused imports disabled")))

  (when (executable-find "yapf")
    (add-hook 'python-mode-hook
              (lambda ()
                (add-hook 'before-save-hook
                          (lambda ()
                            (time-stamp)
                            (lsp-format-buffer)) nil t)))))

;; pytest: for testing python code
;; https://github.com/ionrock/pytest-el
(use-package pytest :defer t)

;; py-isort: sort import statements in python buffers
;; https://github.com/paetzke/py-isort.el
(use-package py-isort
  :if (executable-find "isort"))

;; pyenv-mode: Integrate pyenv with python-mode.
;; https://github.com/proofit404/pyenv-mode
(use-package pyenv-mode
  :if (executable-find "pyenv")
  :hook ((python-mode . pyenv-mode))
  :config
  ;; integrate pyenv with projectile
  (defun projectile-pyenv-mode-set ()
    "Set pyenv version matching project name."
    (let ((project (projectile-project-name)))
      (if (member project (pyenv-mode-versions))
          (pyenv-mode-set project)
        (pyenv-mode-unset))))
  (add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set))

;; python-docstring: format and highlight syntax for python docstrings
;; https://github.com/glyph/python-docstring-mode
(use-package python-docstring
  :hook ((python-mode . python-docstring-mode)))

;; pip-requirements: Major mode for editing pip requirements files
;; https://github.com/Wilfred/pip-requirements.el
(use-package pip-requirements
  :hook ((pip-requirements-mode . company-mode)))

;; sphinx-doc: add sphinx-doc comments easily
;; https://github.com/naiquevin/sphinx-doc.el
;; to add sphinx-docs to a function, press `C-c M-d' on a function definition
(use-package sphinx-doc
  :hook ((python-mode . sphinx-doc-mode)))

(provide 'setup-python-lsp)
