

(let ((el '((hehe . "ueue") (props . "props"))))
  (-let
      (((&alist 'hehe he-val 'props props-val) el))
    he-val))


(-let [(a) '(ff fff)]
  a)

(-let [(&alist 'ff hi) '((ff . fff))]
  hi)


(-let [(&plist :foo foo) '(:foo "foo-el")]
  foo)


(-let [(a1 a2 &keys :foo foo) '(first  second :foo "foo-el")]
  (list foo a1))

(-let [(&plist :foo) '(:foo "foo-el")]
  foo)

(-let [(&plist "foo") '("foo" "foo-el")]
  foo)

(plist-get
 '(:foo "foo-el")
 :foo)
