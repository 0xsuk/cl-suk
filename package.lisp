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


(defpackage :suk.list
  (:use
   :cl
   :cl-arrows
   :iterate)
  (:export
   :push-end
   :adjoin-end))

(defpackage :suk.flow
  (:use
   :cl
   :cl-arrows
   :iterate
   :suk.list)
  (:export
   :flow))

(defpackage :suk.system
  (:use
   :cl
   :suk.flow)
  (:export
   :add-nickname)
  )

(defpackage-inheriting :suk
  (:suk.list
   :suk.flow
   :suk.system))
