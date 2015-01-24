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

;;;; byte compile
(require 'auto-async-byte-compile)
;; ignore pattern
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

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
  (set-frame-font "UmePlus Gothic-9"))
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

;;; whitespace-mode
;;
;; 全角スペース -> □
;; タブ         -> ____
;; 改行         -> ⇓
;;
(require 'whitespace)
(set-face-foreground 'whitespace-space "cornsilk3")
(set-face-background 'whitespace-space nil)
(set-face-bold 'whitespace-space t)
(set-face-foreground 'whitespace-tab "cornsilk3")
(set-face-underline 'whitespace-tab t)
(set-face-foreground 'whitespace-newline "cornsilk3")
(set-face-background 'whitespace-newline nil)
(set-face-bold 'whitespace-newline t)

(setq whitespace-style '(face tabs tab-mark spaces space-mark newline newline-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '(
        (space-mark   ?\x3000 [?\□])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        ;; (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t])	; tab - left quote mark
        (tab-mark     ?\t     [?\t])
        (newline-mark ?\n     [?\x21d3 ?\n])
        ))
(global-whitespace-mode 1)

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

;;; sticky.el
(require 'sticky)
(use-sticky-key ";" sticky-alist:ja)

;; Other
