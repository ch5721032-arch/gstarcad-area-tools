# GstarCAD Area Tools

Report the area and perimeter of every selected closed object, print the selection total, and annotate measured areas directly in the drawing.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Area takeoffs and quantity checks are a daily task in architecture and civil work. These commands report the area and perimeter of every closed object you select, print a running selection total, and annotate the measured area right next to the drawing so quantities stay visible on the sheet.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/area-report.lsp` | ;; area-report.lsp - Report area/perimeter for a selection set
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
 |
| `scripts/area-annotate.lsp` | ;; area-annotate.lsp - Insert an area annotation text
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
