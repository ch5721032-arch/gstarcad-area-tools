;; area-annotate.lsp - Insert an area annotation text
;; Command: AREANOTE
(defun c:AREANOTE ( / en pos a )
  (setq en (car (entsel "\nSelect a closed object: ")))
  (if en
    (progn
      (command "_.AREA" "_O" en)
      (setq a (getvar "AREA"))
      (setq pos (getpoint "\nText position: "))
      (if pos
        (command "_.TEXT" "_J" "_MC" pos 2.5 0
                 (strcat "Area: " (rtos a 2 2) " sq units"))
      )
    )
  )
  (princ)
)
