
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

            (layers (gimp-image-get-layers image))
            (i (- (car layers) 1))
            (layer-array (cadr layers))
        )

        (while (>= i 0)
            (let ((layer (aref layer-array i)))
                (gimp-image-insert-layer image (car (gimp-layer-copy layer2 TRUE)) 0 (+ i 1))
                (gimp-layer-set-mode layer LAYER-MODE-HSV-VALUE)
            )
            (set! i (- i 1))
        )

        (set! i (- (car layers) 1))
       
        (while (>= i 0)
            (let ((layer (aref layer-array i)))
                (gimp-image-merge-down image layer CLIP-TO-IMAGE)
            )
            (set! i (- i 1))
        )

        (gimp-displays-flush)        
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
