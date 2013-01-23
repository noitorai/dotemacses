;;;; path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))

;;;; auto-install
;; for update
;; (install-elisp-from-emacswiki "auto-install.el")

(require 'auto-install)

;; add auto-install elisps to load-path 
(add-to-list 'load-path auto-install-directory)

;; Update package name when start up. But this setup is not necessary,
;; because AutoInstall will automatically update package name when you
;; just first call `auto-install-from-emacswiki', This setup just
;; avoid *delay* when you first call `auto-install-from-emacswiki'.
;; (auto-install-update-emacswiki-package-name t)

;; install-elisp.el compatibility mode
(auto-install-compatibility-setup)

;; gather ediff buffers together in one frame
(setq ediff-window-setup-function 'ediff-setup-window-plain)

;; **********************************************************************
;;   View
;; **********************************************************************

;; 列数表示                                                                     
(column-number-mode t)

;;リージョンに色を付ける
;;(setq transient-mark-mode t)

;; 折り返し表示 ON/OFF
(defun toggle-truncate-lines ()
  "折り返し表示をトグル"
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
(global-set-key "\C-c\C-l" 'toggle-truncate-lines)  

;; TODO elscreen
;;(setq elscreen-prefix-key "\C-z")
;;(setq elscreen-display-tab nil)
;;(load "elscreen" "ElScreen" t)
;;(add-hook 'term-mode-hook '(lambda ()
;;                             (define-key term-raw-map "\C-z"
;;                               (lookup-key (current-global-map) "\C-z"))))

;; FIXME elscreen と合わせて要不要を検討(使用するなら Action へ移動
;; ;;C-zをtermに強奪されてないようにする                                   
;; (add-hook 'term-mode-hook '(lambda ()                    
;;                              (define-key term-raw-map "\C-z"      
;;                                (lookup-key (current-global-map) "\C-z"))))

;; TODO: 導入を検討 jaspace-mode
;; ;; 切り替えは M-x jaspace-mode-{on,off}
;; (require 'jaspace)
;; ;; 全角空白を表示させる。                                                       
;; (setq jaspace-alternate-jaspace-string "□ ")
;; ;; 改行記号を表示させる。                                                       
;; (setq jaspace-alternate-eol-string "↓ \n")
;; ;; タブ記号を表示。                                                             
;; (setq jaspace-highlight-tabs t)  ; highlight tabs                               

;; **********************************************************************
;;   Action
;; **********************************************************************

;; C-h を Backspace に
(global-set-key "\C-h" 'delete-backward-char)

;;タブの代わりに半角スペースを使う                                              
(setq-default tab-width 4 indent-tabs-mode nil)
;; タブストップ位置の設定                                                       
(setq-default tab-stop-list
  '(4 8 12 16 20))

;; 対応する括弧をハイライト                                                     
(show-paren-mode t)

;; redo
(when (require 'redo nil t)
  (define-key ctl-x-map (if window-system "U" "r") 'redo)
  (define-key global-map [?\C-.] 'redo))

;; ビープ音を画面のフラッシュに変更                                             
(setq visible-bell t)

;; Other

;; TODO 導入を検討する
;; 導入する場合は、Motion section へ
;; ;; 矩形選択モードを使いやすく
;; (autoload 'sense-region-on "sense-region"
;;   "System to toggle region and regtangle." t nil)
