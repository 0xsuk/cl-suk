(in-package :suk.system)

(defun add-nickname (package nickname
                     &key (keep-existing-nicknames-p t))
  "give NICKNAME (string or symbol) to PACKAGE (string or output of find-package)"
  (when (or (stringp package) (symbolp package))
    (setf package (find-package package)))
  (when (symbolp nickname)
    (setf nickname (string nickname)))
  (check-type package package)
  (check-type nickname string)
  (flow
    (if keep-existing-nicknames-p
        (adjoin nickname (package-nicknames package)
                :test #'string=)
        (list nickname))
    (rename-package package (package-name package) <>)
    )
  )
