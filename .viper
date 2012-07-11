(setq viper-inhibit-startup-message 't)
(setq viper-expert-level '3)
;(setq viper-syntax-preference 'extended)

(define-key viper-vi-global-user-map (kbd "gt") 'next-buffer)
(define-key viper-vi-global-user-map (kbd "gT") 'previous-buffer)

;; vimpulse
(setq vimpulse-experimental nil)   ; don't load bleeding edge code (see 6. installation instruction)
;(setq vimpulse-enhanced-paren-matching nil)
(setq woman-use-own-frame nil)     ; don't create new frame for manpages
(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)

; vi: ft=lisp

(setq et t) ; don't touch or else...

(setq viper-shift-width 4) ; don't touch or else...
