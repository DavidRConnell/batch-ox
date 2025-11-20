;;; batch-ox --- Export Org files outside the buffer -*- lexical-binding: t -*-

;; Copyright (C) 2025 David R. Connell

;; Author: David R. Connell <david32@dcon.addy.io>
;; Version: 0.1
;; URL: https://github.com/davidrconnell/batch-ox
;; Keywords: outlines, text
;; Package-Requires: ((org "9.4"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program ; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;; Org-exporter can only be run interactively from the buffer you are trying to
;; export. This provides a wrapper function around `org-export-to-file' that
;; can be run from a script.

;;; Code:

(require 'ox)

(defvar batch-ox-backend-alist
  '((org . org)
    (tex . latex)
    (html . html)
    (odt . odt)
    (txt . ascii))

  "Default export backends for different output file extensions.")

(defun batch-ox-export (outfile &optional infile backend)
  "Export an Org file to `OUTFILE'.

If optional `INFILE' is provided, override the default input file (the output
file with the extension swapped for `org').

The optional `BACKEND' gives control over which `org-export' export backend to
should be used. The default is dependent on the file extension of `OUTFILE' and
the `batch-ox-backend-plist' variable."
  (let* ((org-file (or infile (concat (file-name-sans-extension outfile) ".org")))
	 (ext (intern (file-name-extension outfile)))
	 (backend (or backend (alist-get ext batch-ox-backend-alist))))

    (with-temp-buffer
      (insert-file-contents org-file)
      (org-export-to-file backend outfile))))

(provide 'batch-ox)
;;; batch-ox.el ends here.
