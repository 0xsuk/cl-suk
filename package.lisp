(defpackage :suk.flow
	(:use
	 :cl
	 :cl-arrows
	 :iterate
	 :suk.list)
	(:export
	 :flow))

(defpackage :suk.list
	(:use
	 :cl
	 :cl-arrows
	 :iterate)
	(:export
	 :push-end
	 :adjoin-end))
