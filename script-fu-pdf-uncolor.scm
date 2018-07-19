
(define (script-fu-pdf-uncolor image drawable)
    (let*
        (
            (width (car (gimp-image-width image))) 
            (height (car (gimp-image-height image)))  

            (layer (car (gimp-image-get-active-layer image)))

            (layer2 (car (gimp-layer-new 
                            image               ; The image to which to add the layer
                            width               ;The layer width (1 <= width <= 262144)
                            height              ;The layer height (1 <= height <= 262144)
                            RGB-IMAGE
                            "The layer name"
                            100                 ;The layer opacity
                            0                   ;The layer combination mode
            )))
        )
        

        (gimp-layer-set-mode layer LAYER-MODE-HSV-VALUE)
        (gimp-image-insert-layer image layer2 0 1)

        (set! layer (car (gimp-image-flatten image)))
        (set! drawable (car (gimp-image-get-active-layer image)))

        (gimp-drawable-brightness-contrast drawable 0 0.04)
        (plug-in-normalize RUN-NONINTERACTIVE image drawable)
        (gimp-displays-flush)
        (gimp-message "OK")
    )
)

(script-fu-register
    "script-fu-pdf-uncolor" ; function name
    "Uncolor"               ; menu label
    "to do..."              ; description
    "Stephan Cieszynski"    ; author
    "Copyleft 2018"         ; copyright notice
    "July, 2018"            ; date created
    ""                      ; image type the script works on
    SF-IMAGE      "SF-IMAGE" 0
    SF-DRAWABLE   "SF-DRAWABLE" 0
)

(script-fu-menu-register "script-fu-pdf-uncolor" "<Image>/File/Extra")
