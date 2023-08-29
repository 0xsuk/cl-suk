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
  )
