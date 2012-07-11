
;; General settings
(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(custom-set-variables '(inhibit-startup-screen t))
(setq frame-title-format "%b")

(show-paren-mode 1)

;; Key bindings
(define-key global-map (kbd "M-j") ctl-x-map)
(global-set-key (kbd "M-a") 'execute-extended-command)    ; was backward-sentence

(global-set-key (kbd "M-1") 'delete-other-windows)        ; was digit-argument
(global-set-key (kbd "M-2") 'split-window-vertically)     ; was digit-argument
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-s") 'other-window)                ; was center-line

(add-to-list 'load-path "~/.emacs.d")

; isearchb?

;; Redo
;(require 'redo)                    ; redo key C-r
(add-to-list 'load-path "~/.emacs.d/undo-tree")

;; Viper and vimpulse mode
(add-to-list 'load-path "~/.emacs.d/vimpulse")
(setq viper-mode t)                ; enable Viper at load time
(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
(require 'vimpulse)                   ; load Viper

;; Paredit <-> Viper
(eval-after-load 'paredit
  '(progn
     (require 'paredit-viper-compat)
     (paredit-viper-compat)))

;; nxml workaround
(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))

;; Fullscreen mode via <f11>
(load "~/.emacs.d/fullscreen.el")

;; ELPA
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; Clojure syntax highlighting in SLIME REPL
(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

;; symbols for some overlong function names by Eric Schulte
;; http://groups.google.com/group/clojure/t/f13dfd1484f6b537
#_(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode
    (mapcar
     (lambda (pair)
       `(,(car pair)
         (0 (progn (compose-region
                    (match-beginning 0) (match-end 0)
                    ,(cadr pair))
                   nil))))
     `(("\\<fn\\>" ,(make-char 'greek-iso8859-7 107))
       ("\\<comp\\>" ?∘)
       ("\\<partial\\>" ?þ)
       ("\\<complement\\>" ?¬)))))

;; Paredit in Clojure
(dolist (mode '(clojure-mode-hook slime-repl-mode-hook))
  (add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
  (setq viper-shift-width 2))

;; Textile syntax highlighting
(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
