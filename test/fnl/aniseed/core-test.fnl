(local core (require :aniseed.core))

{:aniseed/module :aniseed.core-test
 :aniseed/tests
 {:first
  (fn [t]
    (t.= 1 (core.first [1 2 3]) "1 is first")
    (t.= nil (core.first nil) "first of nil is nil"))

  :last
  (fn [t]
    (t.= 3 (core.last [1 2 3]) "3 is last")
    (t.= nil (core.last nil) "last of nil is nil"))

  :second
  (fn [t]
    (t.= nil (core.second []) "nil when empty")
    (t.= nil (core.second nil) "nil when nil")
    (t.= nil (core.second [1 nil 3]) "nil when the second item is actually nil")
    (t.= 2 (core.second [1 2 3]) "two when the second item is two"))

  :string?
  (fn [t]
    (t.= true (core.string? "foo"))
    (t.= false (core.string? nil))
    (t.= false (core.string? 10)))

  :nil?
  (fn [t]
    (t.= false (core.nil? "foo"))
    (t.= true (core.nil? nil))
    (t.= false (core.nil? 10)))

  :some
  (fn [t]
    (t.= nil (core.some #(and (> $1 5) $1) [1 2 3]) "nil when nothing matches")
    (t.= 3 (core.some #(and (> $1 2) $1) [1 2 3]) "the value when something matches")
    (t.= 3 (core.some #(and $1 (> $1 2) $1) [nil 1 nil 2 nil 3 nil]) "handles nils"))

  :inc
  (fn [t]
    (t.= 2 (core.inc 1)))

  :pr-str
  (fn [t]
    (t.pr= "[1 2 3]" (core.pr-str [1 2 3])))

  :map
  (fn [t]
    (t.pr= [2 3 4] (core.map core.inc [1 2 3])))

  :filter
  (fn [t]
    (t.pr= [2 4 6] (core.filter #(= 0 (% $1 2)) [1 2 3 4 5 6]))
    (t.pr= [] (core.filter #(= 0 (% $1 2)) nil)))

  :inc
  (fn [t]
    (t.= 5 (core.inc 4)))

  :dec
  (fn [t]
    (t.= 4 (core.dec 5)))

  :identity
  (fn [t]
    (t.= :hello (core.identity :hello) "returns what you give it")
    (t.= nil (core.identity) "no arg returns nil"))

  :concat
  (fn [t]
    (local orig [1 2 3])
    (t.pr= [1 2 3 4 5 6] (core.concat orig [4 5 6]) "table has been concatenated")
    (t.pr= [4 5 6 1 2 3] (core.concat [4 5 6] orig) "order is important")
    (t.pr= [1 2 3] orig "original hasn't been modified"))

  :count
  (fn [t]
    (t.= 3 (core.count [1 2 3]) "three values")
    (t.= 0 (core.count []) "empty")
    (t.= 0 (core.count nil) "nil")
    (t.= 0 (core.count nil) "no arg")
    (t.= 3 (core.count [1 nil 3]) "nil gap")
    (t.= 4 (core.count [nil nil nil :a]) "mostly nils")
    (t.= 0 (core.count {:a 1 :b 2}) "associative doesn't work"))}}