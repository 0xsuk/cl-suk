(asdf:defsystem :suk
  :name "suk"
  :depends-on (
               :cl-arrows
               :iterate
               )
  :serial t
  :components ((:file "package")
               (:file "list")
               (:file "flow")
               (:file "system")))
