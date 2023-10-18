(in-package :suk.util)

(defun-inline ensure-list (lst)
  (if (listp lst)
      lst
      (list lst)))

(defun-inline ensure-atom (v)
  (if (listp v)
      (car v)
      v))

(defun-inline concat-symbol (&rest syms)
  (intern (apply #'concatenate 'string
                 (mapcar (lambda (sym)
                           (symbol-name sym))
                         syms))))
