(* Math *)

(* Grand symbole *)
let rec bigOp op i fin f e succ =
  match i with
      i when i>fin -> e
    | i when i=fin -> f i
    | i -> op (f i) (bigOp op (succ(i)) fin f e succ );;

let e = 2.718281828459;;
