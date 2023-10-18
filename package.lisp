(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun external-symbols (package)
    (let ((symbols nil))
      (do-external-symbols (s (find-package package) symbols)
        (push s symbols)))))

(defmacro defpackage-inheriting (name parent-packages &rest args)
  `(defpackage ,name
     ,@args
     ,@(loop :for parent-package :in parent-packages
             :collect `(:use ,parent-package)
             :collect `(:export ,@(external-symbols parent-package)))))


(defpackage :suk.flow
  (:use
   :cl)
  (:export :-> :->> :-<> :-<>>))

(defpackage :suk.system
  (:use
   :cl
   :suk.flow)
  (:export
   :add-nickname)
  )

(defpackage-inheriting :suk
  (:suk.flow
   :suk.system))
