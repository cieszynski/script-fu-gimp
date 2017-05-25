(define (divide drawable)
    drawable
)

(define (inc i) (+ i 1))

(define (script-fu-pdf-divide image drawable)
    (let*
        (
            (color (car (gimp-image-pick-color 
                            image
                            drawable
                            50                  ;x
                            50                  ;y
                            FALSE               ;Use the composite image, not the drawable
                            TRUE                ;Average the color of all the pixels in a specified radius
                            10.0                 ;The radius of pixels to average (average-radius >= 0)
                        )))
                        
            (width (car (gimp-image-width image))) 
            (height (car (gimp-image-height image)))  
            (layer (car (gimp-layer-new 
                            image               ; The image to which to add the layer
                            width               ;The layer width (1 <= width <= 262144)
                            height              ;The layer height (1 <= height <= 262144)
                            RGB-IMAGE
                            "The layer name"
                            100                 ;The layer opacity
                            DIVIDE-MODE         ;The layer combination mode
                        )))
        )
       
        (gimp-image-insert-layer image layer 0 -1)
        (set! drawable (car (gimp-image-get-active-layer image)))

        (gimp-context-set-foreground color)
        (gimp-drawable-fill drawable FOREGROUND-FILL)

        (set! layer (car (gimp-image-flatten image)))
        (set! drawable (car (gimp-image-get-active-layer image)))
        
        (plug-in-normalize RUN-NONINTERACTIVE image drawable)
        (gimp-displays-flush)
        ;(gimp-message )
    )
)

(script-fu-register
    "script-fu-pdf-divide"  ; function name
    "Divide"                ; menu label
    "to do..."              ; description
    "Stephan Cieszynski"    ; author
    "Copyleft 2017"         ; copyright notice
    "Mai, 2017"             ; date created
    ""                      ; image type the script works on
    SF-IMAGE      "SF-IMAGE" 0
    SF-DRAWABLE   "SF-DRAWABLE" 0
)
                    
(script-fu-menu-register "script-fu-pdf-divide" "<Image>/File/Extra")
