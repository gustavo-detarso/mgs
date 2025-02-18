;; .emacs.d/init.el
;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Adiciona NonGNU archive to the list of available repositories
(add-to-list 'package-archives
             '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

(add-to-list 'package-archives '( "jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(use-package
    restart-emacs
    better-defaults                 ;; Set up some better Emacs defaults
    material-theme                  ;; Theme
    eshell
    projectile
    treemacs
    treemacs-projectile
    treemacs-tab-bar
    yasnippet
    yasnippet-snippets
    ob-elm
    ob-napkin
    ivy
    evil
    evil-collection
    evil-org
    winum
    auto-complete
    flycheck
    python-mode
    python-black
    pipenv
    flycheck-pyflakes
    flymake-python-pyflakes
    py-autopep8
    csv-mode
    gnuplot
    quelpa-use-package
    php-mode
    smartparens
    evil-smartparens
    docker
    helm-tramp
    websocket
    company-box
    sly-named-readtables
    gptel
    ess
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ===================================
;; Basic Customization
;; ===================================

(add-to-list 'load-path "/home/gustavodetarso/.emacs_profiles/emacs.default/snippets")
(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'material t)            ;; Load material theme
(global-display-line-numbers-mode t)               ;; Enable line numbers globally
(yas-global-mode 1) ;; Ativa o YASnippet globalmente
(setq yas-snippet-dirs '("~/.emacs.d/snippets")) ;; Defina o diretório dos snippets
;(global-auto-complete-mode t)
;(add-to-list 'ac-modes 'python-mode)
(set-face-attribute 'default nil :height 100)
(setq org-image-actual-width (/ (display-pixel-width) 5))

(ivy-mode 1)

(require 'winum)

(winum-mode)

(require 'quelpa-use-package)

(require 'smartparens)
(sp-pair "<" ">" :wrap "C-*")
(sp-pair "*" "*")
(sp-pair "<?php" "?>")
(smartparens-mode t)
(smartparens-global-mode t)

(require 'flycheck-pyflakes)

(require 'flymake-python-pyflakes)

(require 'ob-eshell)

(require 'ob-java)

(require 'ob-napkin)

(require 'tempo)

(require 'php-mode)
(setq auto-mode-alist
  (append '(("\.php$" . php-mode)
            ("\.module$" . php-mode))
              auto-mode-alist))

;(let ((git-bash-bin "C:/Program Files/Git/usr/bin"))
;  (setenv "PATH" (concat git-bash-bin ";" (getenv "PATH")))
;  (add-to-list 'exec-path git-bash-bin))

(require 'tramp)

(setq tramp-default-method "docker")

(setq tramp-docker-executable "docker")

(setq tramp-verbose 10)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :custom
  ;; use emacs bindings in insert-mode
  (evil-disable-insert-state-bindings t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :init
  (setq general-override-states '(insert
                                  emacs
                                  hybrid
                                  normal
                                  visual
                                  motion
                                  operator
                                  replace))
  :config
  (general-define-key
   :states '(normal visual motion)
   :keymaps 'override
   "SPC" 'hydra-space/body))
;; Replace 'hydra-space/body with your leader function.

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

(quelpa '(discover-my-major :fetcher git :url "https://framagit.org/steckerhalter/discover-my-major.git"))

(projectile-mode +1)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package treemacs
  :demand t
  :hook (after-init . treemacs)
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0))))

(setq treemacs-width 15)
(setq treemacs--width-is-locked nil)
(setq treemacs-width-is-initially-locked nil)

(require 'treemacs)
(add-hook 'treemacs-mode-hook
          (lambda ()
            (message "treemacs-mode-hook `%s'" (current-buffer))
            (text-scale-adjust -1)
            ))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package pipenv
  :hook (python-mode . pipenv-mode)
  :commands (pipenv-mode
         pipenv-activate
         pipenv-run))

(defun run-python-script ()
  "Run Python script."
  (interactive)
  (let ((buffer (compile (concat "python3 " (buffer-file-name)))))
    (set-buffer buffer)
    (end-of-buffer)))

;; Definindo uma tecla de atalho
(global-set-key (kbd "C-x C-m") 'run-python-script)  ; Usando Ctrl+c, p como atalho

;; Develop in ~/emacs.d/mysnippets
;(setq yas-snippet-dirs
;     '("/home/gustavodetarso/.emacs_profiles/emacs.default/snippets")))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-global-mode t)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "C-'") #'yas-expand)
  (add-to-list #'yas-snippet-dirs "/home/gustavodetarso/.emacs_profiles/emacs.default/snippets")
  (yas-reload-all)
  (setq yas-prompt-functions '(yas-ido-prompt))
  (defun help/yas-after-exit-snippet-hook-fn ()
    (prettify-symbols-mode)
    (prettify-symbols-mode))
  (add-hook 'yas-after-exit-snippet-hook #'help/yas-after-exit-snippet-hook-fn)
  :diminish yas-minor-mode)

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "copilot-emacs/copilot.el"
                   :branch "main"
                   :files ("*.el")))
;; you can utilize :map :hook and :config to customize copilot

(define-key copilot-completion-map (kbd "<C->") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "C->") 'copilot-accept-completion)

;(setq org-ai-openai-api-token "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")

;; UTF-8 as default encoding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
; add this especially on Windows, else python output problem
(set-terminal-coding-system 'utf-8-unix)

;; Globally
(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
;(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-c r") 'restart-emacs)

;; Copilot
;; enable completion automatically
(add-hook 'prog-mode-hook 'copilot-mode)
;; enable completion in insert mode
(customize-set-variable 'copilot-enable-predicates '(evil-insert-state-p))
; complete by copilot first, then company-mode
(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))
(setq copilot-indent-offset-warning-disable t)

;; Eshell
; For `eat-eshell-mode'.
(add-hook 'eshell-load-hook #'eat-eshell-mode)
; For `eat-eshell-visual-command-mode'.
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

;; Python
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'py-autopep8-mode)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook 'turn-on-smartparens-mode)

;; PHP
(add-hook 'php-mode-hook 'company-box-mode)
(add-hook 'php-mode-hook (lambda ()
    (defun ywb-php-lineup-arglist-intro (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) c-basic-offset))))
    (defun ywb-php-lineup-arglist-close (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (current-column))))
    (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
    (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

; Indentation for PHP
(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  (setq indent-tabs-mode t)
  (let ((my-tab-width 4))
    (setq tab-width my-tab-width)
    (setq c-basic-indent my-tab-width)
    (set (make-local-variable 'tab-stop-list)
         (number-sequence my-tab-width 200 my-tab-width))))

; Completion for PHP
(defun my-fetch-php-completions ()
  (if (and (boundp 'my-php-symbol-list)
           my-php-symbol-list)
      my-php-symbol-list

    (message "Fetching completion list...")

    (with-current-buffer
        (url-retrieve-synchronously "http://www.php.net/manual/en/indexes.functions.php")

      (goto-char (point-min))

      (message "Collecting function names...")

      (setq my-php-symbol-list nil)
      (while (re-search-forward "<a[^>]*class=\"index\"[^>]*>\\([^<]+\\)</a>" nil t)
        (push (match-string-no-properties 1) my-php-symbol-list))

      my-php-symbol-list)))

;; PlantUML
(defun setup-plantuml ()
  "Configurações centralizadas para PlantUML no Emacs."
  ;; Caminho para o JAR do PlantUML
  (setq plantuml-jar-path (expand-file-name "~/.others/plantuml.jar"))
  (setq org-plantuml-jar-path (expand-file-name "~/.others/plantuml.jar"))

  ;; Execução e formato de saída
  (setq plantuml-default-exec-mode 'jar)
  (setq plantuml-output-type "svg")

  ;; Associações de extensões ao plantuml-mode
  (dolist (ext '("\\.mm\\'" "\\.puml\\'" "\\.plantuml\\'"))
    (add-to-list 'auto-mode-alist (cons ext 'plantuml-mode)))

  ;; Integração com org-mode
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

  ;; Ativar auto-complete no plantuml-mode
  (add-hook 'plantuml-mode-hook #'auto-complete-mode)

  ;; Configurações adicionais para org-babel
  (with-eval-after-load 'ob
    (require 'ob-napkin)) ;; Suporte para ob-napkin (opcional)

  ;; Configuração personalizada do plantuml-mode
  (defun my-plantuml-setup ()
    "Configuração personalizada para arquivos PlantUML no plantuml-mode."
    (when (member (file-name-extension buffer-file-name) '("mm" "puml" "plantuml"))
      ;; Atalhos para inserir cores
      (local-set-key (kbd "C-c b") (lambda () (interactive) (insert "<color:blue>")))
      (local-set-key (kbd "C-c g") (lambda () (interactive) (insert "<color:green>")))
      (local-set-key (kbd "C-c y") (lambda () (interactive) (insert "<color:yellow>")))
      (local-set-key (kbd "C-c o") (lambda () (interactive) (insert "<color:orange>")))
      ;; Atalhos para níveis do mindmap
      (local-set-key (kbd "C-c 1") (lambda () (interactive) (insert "* ")))
      (local-set-key (kbd "C-c 2") (lambda () (interactive) (insert "** ")))
      (local-set-key (kbd "C-c 3") (lambda () (interactive) (insert "*** ")))
      (local-set-key (kbd "C-c 4") (lambda () (interactive) (insert "**** ")))
      (local-set-key (kbd "C-c 5") (lambda () (interactive) (insert "***** ")))
      (local-set-key (kbd "C-c 6") (lambda () (interactive) (insert "****** ")))
      ;; Configuração do preview na janela à direita
      (advice-add 'plantuml-preview :after
                  (lambda (&rest _args)
                    (let ((buf (get-buffer-create "*PLANTUML Preview*")))
                      ;; Abre o buffer na janela à direita
                      (display-buffer-in-side-window buf '((side . right) (slot . 0) (window-width . 0.5))))))
      ;; Configuração do auto-complete para plantuml-mode
      (with-eval-after-load 'auto-complete
        (add-to-list 'ac-modes 'plantuml-mode)
        (setq-default ac-sources '(ac-source-words-in-buffer
                                   ac-source-words-in-same-mode-buffers
                                   ac-source-dictionary)))))

  ;; Adiciona a configuração personalizada ao hook do plantuml-mode
  (add-hook 'plantuml-mode-hook 'my-plantuml-setup))

;; Chama a função de configuração
(setup-plantuml)

;; org-mode
; src block indentation / editing / syntax highlighting
(setq org-src-fontify-natively t
      org-src-window-setup 'current-window ;; edit in current window
      org-src-strip-leading-and-trailing-blank-lines t
      org-src-preserve-indentation t ;; do not put two spaces on the left
      org-src-tab-acts-natively t)

; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . y)
   (java . t)
   (plantuml . t)
   (dot . t)
   (R . t)
   (gnuplot . t)))

(add-hook 'org-mode-hook 'turn-on-smartparens-mode)
(add-hook 'org-mode-hook 'toggle-truncate-lines)
(add-hook 'org-mode-hook 'auto-complete-mode)
(add-hook 'org-mode-hook 'org-toggle-inline-images)
(setq org-image-actual-width nil)
(add-hook 'org-mode-hook 'copilot-mode)

(setq org-startup-folded t)

;; User-Defined init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(ivy-truncate-lines nil)
 '(package-selected-packages
   '(0blayout auto-complete better-defaults company-box copilot csv-mode
	      discover-my-major docker ess ess-R-data-view
	      ess-view-data evil-collection evil-org evil-smartparens
	      flycheck-pyflakes flymake-python-pyflakes general
	      gnuplot gptel helm-tramp ivy material-theme ob-elm
	      ob-napkin php-mode pipenv plantuml-mode py-autopep8
	      python-black python-mode quelpa-use-package
	      restart-emacs sly-named-readtables treemacs-projectile
	      treemacs-tab-bar websocket winum yasnippet-snippets))
 '(warning-suppress-log-types
   '(((flymake flymake-proc)) ((flymake flymake-proc))
     ((flymake flymake-proc))))
 '(warning-suppress-types '(((flymake flymake-proc)) ((flymake flymake-proc)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
