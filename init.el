(setq gc-cons-threshold 100000000)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; emacs setup file
(add-to-list 'load-path (concat user-emacs-directory "setup-files/"))

;; save custom file to a separate directory
(setq custom-file "~/.emacs.d/my-elisp-code/custom-settings.el")
(load custom-file :noerror :nomessage)

;; all use packages declarations -----------------------------------------------
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package
(require 'use-package)
(setq use-package-always-ensure t)

(require 'setup-pragmatapro)
(require 'setup-org)
(require 'setup-backup)
(require 'setup-search)
(require 'setup-ibuffer)
(require 'setup-recentf)
(require 'setup-desktop)
(require 'setup-calc)
(require 'setup-ediff)
(require 'setup-white-space)
(require 'setup-dired)
(require 'setup-elisp-mode)
(require 'setup-fly)
(require 'setup-bookmark)
(require 'setup-hydra)
(require 'setup-company)
(require 'setup-beacon)
(require 'setup-smartparens)
(require 'setup-mc)
(require 'setup-git-stuff)
(require 'setup-undo-tree)
(require 'setup-avy)
(require 'setup-smex)
(require 'setup-projectile)
(require 'setup-web-mode)
(require 'setup-yas)
(require 'setup-ivy)
(require 'setup-counsel)
(require 'setup-swiper)
(require 'setup-movement)
(require 'setup-js)
(require 'setup-markdown)
(require 'setup-highlight)
(require 'setup-mode-line)
(require 'setup-racket)
(require 'setup-hungry-delete)
(require 'setup-rust)
(require 'setup-haskell)
(require 'setup-python)
(require 'setup-tex)
(require 'setup-osx)
(require 'setup-misc)
(require 'setup-fold)
(require 'setup-buffers)
(require 'setup-theme)
(require 'setup-aggresive-indent)
(require 'setup-move-line)
(require 'setup-duplicate-line)
(require 'setup-editing)
(require 'setup-google-this)
(require 'setup-windmove)
(require 'electric-operator)

(setq gc-cons-threshold 800000)
;;; init.el ends here
