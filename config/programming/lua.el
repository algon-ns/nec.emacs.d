;;; lua.el -*- lexical-binding: t; -*-
;; Time-stamp: <2020-06-15 00:03:14 csraghunandan>

;; Copyright (C) 2016-2020 Chakravarthy Raghunandan
;; Author: Chakravarthy Raghunandan <rnraghunandan@gmail.com>

;; Lua configuration
(use-package lua-mode
  :mode "\\.lua$"
  :interpreter "lua"
  :config
    (setq lua-indent-level 4)
    (setq lua-indent-string-contents t))

(use-package eglot-lua
  :straight (:host github
             :repo "juergenhoetzel/eglot-lua")
  :defer
  :config
  (setq eglot-lua-server-install-dir
                     (concat
                      (file-name-as-directory user-cache-directory)
                      "EmmyLua-LanguageServer/")))

(if nec/measure-time (nec/sstimer "programming/lua"))
(provide 'programming/lua)
