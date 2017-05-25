(define (script-fu-save-pdf-multi)
    (file-pdf-save-multi 0 #(0) 0 0 0 0 "" "")
  
)

(script-fu-register
    "script-fu-save-pdf-multi"  ; function name
    "Mehrseitiges PDF"          ; menu label
    "to do..."                  ; description
    "Stephan Cieszynski"        ; author
    "Copyleft 2017"             ; copyright notice
    "Mai, 2017"                 ; date created
    ""                          ; image type the script works on
)

(script-fu-menu-register "script-fu-save-pdf-multi" "<Image>/File/Extra")
