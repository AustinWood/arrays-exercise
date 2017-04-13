# Dynamic Array

This project assumes Ruby only has access to a C-style static array.

`dynamic_array.rb` rebuilds `Array#push` and `#pull` in ammortized constant time, while implementing `#shift` and `#unshift` in O(n).

`ring_buffer.rb` improves `Array#shift` and `#unshift` to O(1) by implementing a ring buffer.
