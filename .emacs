(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(ede-project-directories (quote ("/home/icblnk/projects/network")))
 '(line-number-mode t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(package-initialize)

;; Load CEDET
(load-file "~/repos/cedet-git/cedet-devel-load.el")

;; Configure and enable evil mode
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

;; Enable speedbar
(require 'sr-speedbar)

;; Enable and configure powerline
(require 'powerline)
(powerline-vim-theme)

;; Enable ycombinator hackernews
(require 'hackernews)

;; Make possible save sessions
(desktop-save-mode 1)

;; Enable auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; auto-complete-c-headers
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; Enable semantic
(semantic-mode 1)
(global-cedet-m3-minor-mode t)
(global-semantic-idle-local-symbol-highlight-mode t)
(global-semantic-idle-scheduler-mode t)
(setq semantic-idle-scheduler-idle-time 1)
(require 'semantic/ia)
(require 'semantic/bovine/gcc)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
(global-ede-mode 1)

(global-semantic-idle-summary-mode 1)

(global-linum-mode 1)

;; bind jump to func declaration to F2
(global-set-key (kbd "<f2>") 'semantic-ia-fast-jump)
(global-set-key (kbd "C-x p") 'sr-speedbar-toggle)

;; configure matching bracers highlighting
(show-paren-mode 2)

;; disable auto-save
(setq auto-save-default nil)

;; enable iDo, allows to print names in minubuffer
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
