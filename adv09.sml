fun readData fname =
    let val f = TextIO.openIn fname
        val d = TextIO.inputAll f
    in TextIO.closeIn f ; d end

(* First part *)

fun findIndex (s, n) c =
    if String.sub (s, n) = c then n
    else findIndex (s, n + 1) c

val parse = valOf o Int.fromString

fun repeat s 0 = []
  | repeat s n = explode s @ repeat s (n - 1)

fun decompress s =
    let fun f n =
            if n >= String.size s then []
            else let val c = String.sub (s, n)
                 in if Char.isSpace c then f (n + 1)
                    else if c <> #"(" then c :: f (n + 1)
                    else let val x = findIndex (s, n) #"x"
                             val e = findIndex (s, n) #")"
                             val k = (parse o String.substring) (s, n + 1, x - n - 1)
                             val m = (parse o String.substring) (s, x + 1, e - x - 1)
                             val ss = String.substring (s, e + 1, k)
                         in repeat ss m @ f (e + k + 1) end
                 end
    in implode (f 0) end

fun adv09 () = let val data = readData "adv09.txt"
               in (String.size o decompress) data end

(* Second part *)

fun decompressedSize s =
    let fun f a b =
            if a = b then 0
            else let val c = String.sub (s, a)
                 in if Char.isSpace c then f (a + 1) b
                    else if c <> #"(" then 1 + f (a + 1) b
                    else let val x = findIndex (s, a) #"x"
                             val e = findIndex (s, a) #")"
                             val k = (parse o String.substring) (s, a + 1, x - a - 1)
                             val m = (parse o String.substring) (s, x + 1, e - x - 1)
                             val r = f (e + 1) (e + k + 1)
                         in m * r + f (e + k + 1) b end
                 end
    in f 0 (String.size s) end

fun adv09b () = let val data = readData "adv09.txt"
                in decompressedSize data end
