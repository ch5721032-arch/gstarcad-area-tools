;; area-report.lsp - Report area/perimeter for a selection set
;; Command: AREAREPORT
;; Usage: APPLOAD -> AREAREPORT -> select closed objects
(defun c:AREAREPORT ( / ss i en a p total )
  (setq ss (ssget '((0 . "LWPOLYLINE,POLYLINE,CIRCLE,ELLIPSE,SPLINE,REGION"))))
  (if ss
    (progn
      (setq i 0 total 0.0)
      (command "_.UNDO" "_BE")
      (repeat (sslength ss)
        (setq en (ssname ss i))
        (command "_.AREA" "_O" en)
        (setq a (getvar "AREA")
              p (getvar "PERIMETER")
              total (+ total a))
        (princ (strcat "\n" (itoa (1+ i)) ". Area = " (rtos a 2 2)
                       "  Perimeter = " (rtos p 2 2)))
        (setq i (1+ i))
      )
      (command "_.UNDO" "_E")
      (princ (strcat "\nTotal area: " (rtos total 2 2) " sq units"))
    )
  )
  (princ)
)
