module Quantities.SortedAssociationList

%default total

%assert_total
mergeWithBy : (k -> k -> Ordering) -> (v -> v -> v) ->
              List (k, v) -> List (k, v) -> List (k, v)
mergeWithBy _ _ [] ys = ys
mergeWithBy _ _ xs [] = xs
mergeWithBy order merge ((k1, v1) :: xs) ((k2, v2) :: ys) =
  case order k1 k2 of
    LT => (k1, v1) :: mergeWithBy order merge xs ((k2, v2) :: ys)
    GT => (k2, v2) :: mergeWithBy order merge ((k1, v1) :: xs) ys
    EQ => (k1, merge v1 v2) :: mergeWithBy order merge xs ys

mergeWith : Ord k => (v -> v -> v) ->
            List (k, v) -> List (k, v) -> List (k, v)
mergeWith = mergeWithBy compare
