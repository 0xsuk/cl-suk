(in-package :suk.def)

(defmacro defun-inline (name args &body body)
  `(progn
     (declaim (inline ,name))
     (defun ,name ,args ,@body)
     ',name))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun dot-notation (instance slot)
    (suk.util:concat-symbol instance (intern ".") slot))
  (defun accessor (name slot)
    (suk.util:concat-symbol name '- slot))
  (defun map-accessors (slot-names name instance)
    (mapcar (lambda (slot)
              `(,(dot-notation instance slot)
                ,(accessor name slot)))
            slot-names))
  (defun nest-with-access (instance?s slot-names name body)
    (let ((acc body))
      (dolist (instance (suk.util:ensure-list instance?s))
        (setf acc (list `(with-accessors
                               ,(map-accessors slot-names name instance)
                             ,instance
                           ,@acc
                           ))))
      (car acc))))

(defmacro defstruct. (name &rest slots)
  "
defines struct and with-`name' macro. withing with-`name' macro, you can access instance's slot with `.'.

Example:
(defstruct. people
  name)
(setf p1 (make-people :name "bob"))
(setf p2 (make-people :name "alice"))
(with-people (p1 p2)
  (format t "p1 is ~A~%" p1.name)
  (setf p2.name "Alice")
  (format t "p2 is ~A~%" p2.name))
=>
p1 is bob
p2 is Alice
"
  (let ((slot-names (mapcar #'suk.util:ensure-atom slots)))
    `(progn
       (defmacro ,(suk.util:concat-symbol 'with- name) (instance?s &body body)
         "accessor utility. <instance-name>.<property-name> to access."
         (nest-with-access instance?s ',slot-names ',name body)
         )
       (defstruct ,name ,@slots))))
