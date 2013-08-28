(deftheme benhsu
  "i live in the matrix")



;; #020100 herc1 
;; #372800 herc2
;; #343f00  herc3


(let ((black "#000000")
      (blue "#0000AA")
      (green "#00AA00")
      (cyan "#00AAAA")
      (red "#AA0000")
      (magenta "#AA00AA")
      (brown "#AA5500")
      (white  "#AAAAAA")
      (dark_gray  "#555555")
      (bright_blue "#5555FF")
      (bright_green "#55FF55")
      (bright_cyan "#55FFFF")
      (bright_red "#FF5555")
      (bright_magenta "#FF55FF")
      (bright_yellow "#FFFF55")
      (bright_white "#FFFFFF"))
  (custom-theme-set-faces
   'benhsu
   `(mode-line ((t (:background ,green :foreground ,black))))
   `(font-lock-keyword-face ((t (:backbround ,black :foreground ,magenta))))
   `(font-lock-comment-face ((t (:backbround ,black :foreground ,dark_gray))))
   `(font-lock-string-face ((t (:backbround ,black :foreground ,brown))))
   `(cursor ((t (:background ,green))))
   `(default ((t (:background ,black :foreground ,green))))
)) 

(provide-theme 'benhsu)
