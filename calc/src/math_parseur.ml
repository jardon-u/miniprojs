open Unix;;

type 'a term =
  | X
  | Id of 'a
  | Neg of 'a term
  | Add of ('a term)*('a term)
  | Sous of ('a term)*('a term)
  | Mult of ('a term)*('a term)
  | Div of ('a term)*('a term)
  | Pow of ('a term)*('a term)
  | Cos of 'a term
  | Sin of 'a term
  | Acos of 'a term
  | Asin of 'a term
  | Ln of 'a term
  | Exp of 'a term
  | Primit of 'a term
;;

type lexeme = Entier of int | Plus | Moins | Multiplie | Divise
              | Puissance | ParentheseGauche | ParentheseDroite ;;

let float_of_digit c = float((int_of_char c) - (int_of_char '0')) ;;

let rec mangeEntier i s accu =
  try (
    match s.[i] with
      | '0'..'9' as c -> mangeEntier (i+1) s (10.*.accu+.(float_of_digit c))
      | a -> Id(accu)
  )
  with _ -> Id(accu)
;;

let rec parseur i s pile =
  try (
    i := !i+1;
    match s.[!i] with
        '(' -> (parseur i s pile)::pile; parseur i s pile
      | '*' -> (match pile with
		  | a::l -> Mult(a, parseur i s pile))
      | '/' -> (match pile with
		  | a::l -> Div(a, parseur i s pile))
      | '-' -> (match pile with
		  | a::l -> Sous(a, parseur i s pile))
      | '+' -> (match pile with
		  | a::l -> Add(a, parseur i s pile))
      | '0'..'9' as c -> (mangeEntier !i s 0.)::pile; parseur i s pile
      | ')' -> (match pile with
		    a::[] | a::_ -> a)
  )
  with _ -> X
;;
parseur (ref -1) "((4+3)*5)" [];;


let rec MangeEntier flot accu = match flot with
  | [< '(`0`..`9` as c) >] -> MangeEntier flot (10*accu+(int_of_digit c))
  | [< >] -> Entier(accu) ;;


let rec parseur_E pile s =
  let e = parseur_F [] s
  in
    match s with
      | '+' -> parseur_E ((e,Plus) :: pile) s
      | '-' -> parseur_E ((e,Moins) :: pile) s
      | _ -> construit_E pile e
and construit_E pile e = match pile with
  | [] -> e
  | (f,op) :: queue -> match op with
      | Plus -> Add(construit_E queue f,e)
      | Moins -> Sous(construit_E queue f,e)
and parseur_F pile flot =
  let e = parseur_G flot
  in
    match flot with
      | [< 'Multiplie >] -> parseur_F ((e,Multiplie) :: pile) flot
      | [< 'Divise >] -> parseur_F ((e,Divise) :: pile) flot
      | [< >] -> construit_F pile e
and construit_F pile e = match pile with
  | [] -> e
  | (f,op) :: queue -> match op with
      | Multiplie -> Produit(construit_F queue f,e)
      | Divise -> Quotient(construit_F queue f,e)
and parseur_G flot = match flot with
  | [< parseur_H h ; parseur_G' g' >] -> match g' with
      | [< 'Élévation(_,e) >] -> Élévation(h,e)
      | [< >] -> h
      | [< >] -> raise Syntax_error
and parseur_G' flot = match flot with
  | [< 'Puissance ; parseur_G g >] -> [< 'Élévation(N(0),g) >]
  | [< >] -> [< >]
and parseur_H flot = match flot with
  | [< 'Moins ; parseur_I i >] -> Opposé(i)
  | [< parseur_I i >] -> i
  | [< >] -> raise Syntax_error
and parseur_I flot = match flot with
  | [< 'ParenthèseGauche ; (parseur_E []) e ; 'ParenthèseDroite >] -> e
  | [< 'Entier(n) >] -> N(n)
  | [< >] -> raise Syntax_error ;;
