
;; (package-initialize) should be commented when using spacemacs.
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(setq custom-file "~/.emacs.d/custom.el")
(load-file (concat spacemacs-start-directory "init.el"))

;; Helm with init
; (use-package helm
;   :diminish helm-mode
;   :config
;   (progn
;     (require 'helm-config)
;     (setq helm-mode-fuzzy-match t)
;     (setq helm-completion-in-region-fuzzy-match t)
;     (setq helm-split-window-in-side-p t)
;     (helm-mode)
;     (helm-autoresize-mode t)

;     (use-package helm-flx
;       :config
;       (helm-flx-mode +1))

;     (use-package helm-fuzzier
;       :config
;       (helm-fuzzier-mode 1)))

;   :bind
;   (("M-x" . helm-M-x)
;    ("C-x b" . helm-buffers-list)
;    ("C-x C-f" . helm-find-files)))


; ;; Evil config that uses evil-leader.  We should probably use general instead.
; (use-package evil
;   :init
;   (progn
;     ;; if we don't have this evil overwrites the cursor color
;     (setq evil-default-cursor t)

;     (use-package evil-commentary
;       :config
;       (evil-commentary-mode))

;     ;; leader shortcuts
;     ;; This has to be before we invoke evil-mode due to:
;     ;; https://github.com/cofi/evil-leader/issues/10
;     ;; (use-package evil-leader
;     ;;   :init (global-evil-leader-mode)
;     ;;   :config
;     ;;   (progn
;     ;;     (setq evil-leader/in-all-states t)
;     ;;     (evil-leader/set-leader "<SPC>")
;     ;;     (evil-leader/set-key
;     ;;       "b" 'helm-buffers-list
;     ;;       "ff" 'helm-find-files
;     ;;       "k" 'kill-buffer
;     ;;       "K" 'kill-this-buffer
;     ;;       "o" 'occur
;     ;;       "T" 'eshell
;     ;;       "wd" 'delete-window
;     ;;       "wo" 'delete-other-windows
;     ;;       "ws" 'split-window-below
;     ;;       "wh" 'split-window-horizontally
;     ;;       "wv" 'split-window-vertically
;     ;;       "ww" 'other-window
;     ;;       "x" 'helm-M-x
;     ;;       )))

;     ;; boot evil by default
;     (evil-mode 1))
;   :config
;   (progn
;     ;; Enter ex-mode using smex
;     ;; (define-key evil-ex-map "x" 'smex)
;     (define-key evil-ex-map "e " 'helm-find-files)
;     (define-key evil-ex-map "b " 'helm-buffers-list)

;     ;; recover emacs key bindings in motion state
;     ;; (my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
;     ;; (my-move-key evil-motion-state-map evil-normal-state-map " ")

;     ;; esc should always quit: http://stackoverflow.com/a/10166400/61435
;     (define-key evil-normal-state-map [escape] 'keyboard-quit)
;     (define-key evil-visual-state-map [escape] 'keyboard-quit)
;     (define-key minibuffer-local-map [escape] 'abort-recursive-edit)
;     (define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
;     (define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
;     (define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
;     (define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)))


; ;; Reclaim space key for use as a leader.
; (define-key evil-normal-state-map (kbd "SPC") nil)
; (define-key evil-motion-state-map (kbd "SPC") nil)
; (define-key evil-motion-state-map (kbd "SPC b") nil)
; (use-package general
;   :config
;   (progn
;     ;; (setq general-default-keymaps 'evil-normal-state-map)
;     (setq leader-space "SPC")
;     (general-define-key
;              :keymaps 'evil-normal-state-map
;              :prefix leader-space
;              "bb" 'helm-buffers-list)))

