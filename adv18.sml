(* vim: set nowrap: -*- truncate-lines: t -*- *)

val tiles = "......^.^^.....^^^^^^^^^...^.^..^^.^^^..^.^..^.^^^.^^^^..^^.^.^.....^^^^^..^..^^^..^^.^.^..^^..^^^.."

fun isTrap str n = n >= 0 andalso n < size str andalso String.sub (str, n) = #"^"

fun rule90 str =
    let fun f 0 acc = acc
          | f k acc =
            let val c = if isTrap str (k-2) = isTrap str k
                        then #"."
                        else #"^"
            in f (k-1) (c::acc) end
    in implode (f (size str) []) end

val safeCount = length o (List.filter (fn c => c = #".")) o explode

fun generateAndCount _ 0 = 0
  | generateAndCount str n =
    safeCount str + generateAndCount (rule90 str) (n-1)

val adv18 = generateAndCount tiles 40

val adv18b = generateAndCount tiles 400000
