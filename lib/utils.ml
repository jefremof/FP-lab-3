type point = float * float [@@deriving eq]

type technique = {
  name : string;
  body : point list -> float -> float;
  window_size : int;
}

let print_points_list ps =
  List.iter (fun (x, y) -> Printf.printf "(%f, %f) " x y) ps;
  Printf.printf "\n"

let print technique_name points () =
  Printf.printf "%s:\n" technique_name;
  print_points_list points;
  Printf.printf "\n"

let gen_series ((a, _) : point) ((b, _) : point) step =
  let rec aux current acc =
    if current > b then List.rev (current :: acc)
    else aux (current +. step) (current :: acc)
  in
  aux a []
