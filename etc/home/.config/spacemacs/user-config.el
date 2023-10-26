;; user-config.el takes the place of a standard init.el file

(global-hl-line-mode -1)
(vc-follow-link t)

;; Latex
;; Use Skim on macOS to utilize synctex.
;; Confer https://mssun.me/blog/spacemacs-and-latex.html
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq TeX-source-correlate-method 'synctex)
;; AucTex recognizes some standard viewers, but the default view command
;; does not appear to support forward sync.
(setq TeX-view-program-list
      '(("Okular" "okular --unique %o#src:%n`pwd`/./%b")
        ("Skim" "displayline -b -g %n %o %b")
        ("Zathura"
         ("zathura %o"
          (mode-io-correlate
           " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\"")))))
(cond
 ((spacemacs/system-is-mac) (setq TeX-view-program-selection '((output-pdf "Skim"))))
 ;; For linux, use Okular or perhaps Zathura.
 ((spacemacs/system-is-linux) (setq TeX-view-program-selection '((output-pdf "Okular")))))
