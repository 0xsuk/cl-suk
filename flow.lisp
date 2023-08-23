(in-package :suk.flow)

(defmacro flow (&body body)
  "Threading macro like -<>> from cl-arrows, with support for ad hoc variable binding"
  (let* ((variables '())
         (blocks '()))
    (iter
     (with block = '())
     (with variablep = nil)
     (for codes on body)
     (for code = (car codes))
     (when variablep
       (setf variablep nil)
       (next-iteration))
     (when (eq code ':as)
       (unless block
         (error "Cannot use :as in the first place of the body"))
       (push-end block blocks)
       (setf block '())
       
       (let ((variable_name (cadr codes)))
         (unless (symbolp variable_name)
           (error (format nil "Cannot use ~A as variable name" variable_name)))
         (setf variables (adjoin-end variable_name variables)))
       
       (setf variablep t)
       (next-iteration)
       )
     (push-end code block)
     (finally
      (when block (push-end block blocks)))
     )
    
    `(let (,@variables)
       ,@(iter
          (for i below (length blocks))
          (for block = (nth i blocks))
          (for variable = (nth i variables)) ; variable is nil if i is out of range
          (collect `(-<>>
                     ,@block
                     ,@(if variable ; using ,@ so that nil is not inserted when variable is nil
                           `((setf ,variable))
                         )
                     ))
          ))
    )
  )

