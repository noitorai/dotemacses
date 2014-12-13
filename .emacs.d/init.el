;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;;; 
;;; auto-install
;;; 
;; execute below code to update
;; (install-elisp-from-emacswiki "auto-install.el")
(require 'auto-install)

;; add auto-install elisps to load-path
(add-to-list 'load-path auto-install-directory)

;; install-elisp.el compatibility mode
(auto-install-compatibility-setup)

;; gather ediff buffers together in one frame
(defvar ediff-window-setup-function 'ediff-setup-windows-plain)


;; ;;;; byte compile
;; (require 'auto-async-byte-compile)
;; ;; ignore pattern
;; (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;; package.el
;; Installation for Emacs24:
;;   (auto-install-from-url "http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/emacs-lisp/package.el")
;; Installation for Emacs23:
;;   (auto-install-from-url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el")
(require 'package)
;; add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;  loading init-local.el if exists
(defvar local-config  "~/.emacs.d/init-local.el")
(if (file-readable-p local-config) (load local-config))

;;; integrate kill ring and clipboard
(cond (window-system
(setq x-select-enable-clipboard t)
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; view ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs フォントサイズ設定
(if (>= emacs-major-version 24)
(progn
  (set-frame-font "IPAゴシック-10"))
(if (and (>= emacs-major-version 23) (< emacs-major-version 24))
(progn
  (set-frame-font "Monospace-9")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("IPAゴシック" . "unicode-bmp")))))

;; 列数表示
(column-number-mode t)

;; 行番号表示
(linum-mode t)

;;リージョンに色を付ける
;; default で t
(setq transient-mark-mode t)

;; 折り返し表示 ON/OFF
(defun toggle-truncate-lines ()
  "折り返し表示をトグル"
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
(global-set-key "\C-c\C-l" 'toggle-truncate-lines)

;;; Elscreen
;; Installation:
;;  execute the following code
;;    (package-list-packages)
;;  move to elscreen and press I, x and yes
(declare-function elscreen-start "elscreen.el" nil)
(elscreen-start)

;; C-zをtermに強奪されてないようにする                                   
(add-hook 'term-mode-hook '(lambda ()                    
                             (define-key term-raw-map "\C-z"      
                               (lookup-key (current-global-map) "\C-z"))))

;;; ビープ音を画面のフラッシュに変更
(setq visible-bell t)

;;; jaspace-mode
;; 切り替えは M-x jaspace-mode-{on,off}
;; (require 'jaspace)
;; ;; 全角空白を表示させる。
;; (setq jaspace-alternate-jaspace-string "□")
;; ;; 改行記号を表示させる。
;; (setq jaspace-alternate-eol-string "↓ \n")
;; ;; タブ記号を表示。
;; (setq jaspace-highlight-tabs t)  ; highlight tabs

;; デフォルトでは折り返さないようにする
(setq truncate-lines nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; action ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; C-h を Backspace に
(global-set-key "\C-h" 'delete-backward-char)
;; (global-set-key (kbd "C-h") 'delete-backward-char)

;;タブの代わりに半角スペースを使う
(setq-default tab-width 4 indent-tabs-mode nil)
;; タブストップ位置の設定
(setq-default tab-stop-list
  '(4 8 12 16 20))

;; 対応する括弧をハイライト
(show-paren-mode t)

;; redo+.el
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(defvar undo-no-read t) ; 過去の undo が redo されないように
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; ビープ音を画面のフラッシュに変更
(setq visible-bell t)

;; 矩形選択モードを使いやすく
;; init.el 導入検討中
(autoload 'sense-region-on "sense-region"
  "System to toggle region and regtangle." t nil)

;; C-zをtermに強奪されてないようにする
(add-hook 'term-mode-hook '(lambda ()
                             (define-key term-raw-map "\C-z"
                               (lookup-key (current-global-map) "\C-z"))))

;;; sequential-command.el
;; M-{u,l} で直前の単語を大文字/小文字化
(require 'sequential-command-config)
(sequential-command-setup-keys)

;; Other
