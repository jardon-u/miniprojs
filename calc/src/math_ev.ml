(* Bibliotheque de fonction sur les espaces vectoriels *)
(* - Operation sur les matrices/vecteurs/bases         *)
(* - orthogonalisation                                 *)

open Array;;
#load "math.cmo";;


(* somme avec indice entier *)
let rec somme plus i fin f =
  bigOp plus i fin f (failwith "somme : indice") (function x -> x+1)
;;

let creer_mat i j valeur =
  let result=make i [||] in
  let rec ligne k =
    if k<i then let ()=result.(k)<- make j valeur
    in ligne (k+1)
    else result
  in ligne 0;;

let opVV op u v =
  if (length u) <> (length v) then 
    failwith "opVV : vecteur length"
  else
    let w = make (length u) u.(0) in
      for i =0 to (length u)-1 do
	w.(i) <- op u.(i) v.(i)
      done;
      w
;;

let multRV l v =
  let w = make (length v) v.(0) in
    for i=0 to (length w)-1 do
      w.(i) <- v.(i) *. l
    done;
    w
;;


let orthogonalisation b ps =
  let proj v u = multRV ((ps u v)/.(ps v v)) v 
  and bon = make (length b) b.(0) in
    for k=1 to (length b)-1 do
      let f j = proj bon.(j) b.(k) in
	bon.(k) <- opVV (-.) b.(k) (somme (opVV (+.)) 0 (k-1) f);
    done;
    bon
;;

let ps1 u v =
  if (length u) <> (length v) then 
    failwith "ps : vecteur length"
  else
    let r = ref 0. in
      for i =0 to (length u)-1 do
	r := !r +. u.(i) *. v.(i)
      done;
      !r
;;
