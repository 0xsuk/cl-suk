(in-package :suk.list)

(defmacro push-end (item list)
	`(setf ,list (append ,list (list ,item))))

(defun adjoin-end (item list)
	"Like adjoin, but append item to the end of the list"
	(if (member item list)
			list
			(append list (list item))))
