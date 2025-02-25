;;; -*- lexical-binding: t -*-
;; ===================================
;; Arquivo principal de configuração do Emacs
;; ===================================

;; Adiciona o diretório 'config' ao load-path
(add-to-list 'load-path "/home/gustavodetarso/.local/share/emacs/profiles/30/.emacs.d/config/")

;; Carrega os módulos de configuração
(require 'packages)          ;; Gerenciamento de pacotes
(require 'evil-config)       ;; Configuração do Evil Mode
(require 'treemacs-config)   ;; Configuração do Treemacs
(require 'python-config)     ;; Configuração do Python
(require 'org-config)        ;; Configuração do Org Mode
(require 'sql-config)        ;; Configuração do SQL
(require 'plantuml-config)   ;; Configuração do PlantUML
(require 'yasnippet-config)  ;; Configuração do Yasnippet
(require 'copilot-config)    ;; Configuração do Copilot
(require 'keybindings)       ;; Atalhos de teclado
(require 'misc-config)       ;; Outras configurações gerais
(require 'theme-config)      ;; Configuração do Tema
(require 'magit-config)      ;; Configuração do Magit

;; Mensagem de carregamento finalizado
(message "🎉 Configuração carregada com sucesso! Todos os módulos ativados automaticamente!")

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(0blayout auto-complete better-defaults company-box copilot
              discover-my-major docker ejc-sql ess-R-data-view
              ess-view-data evil-collection evil-org evil-smartparens
              flycheck-pyflakes flymake-python-pyflakes general
              gnuplot gptel helm-company helm-spotify helm-tramp
              ivy-spotify lsp-ui magit magit-section material-theme
              ob-elm ob-napkin php-mode pipenv plantuml-mode
              py-autopep8 python-black python-mode quelpa-use-package
              rainbow-delimiters restart-emacs sly-named-readtables
              spotify treemacs-projectile treemacs-tab-bar websocket
              winum with-editor yasnippet-snippets))
 '(warning-suppress-log-types '((ox-latex)))
 '(warning-suppress-types '((ox-latex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
