open Utils

let point_of_strings_opt x y : point option =
  let x_f_opt = Float.of_string_opt x and y_f_opt = Float.of_string_opt y in
  match (x_f_opt, y_f_opt) with
  | Some x_f, Some y_f -> Some (x_f, y_f)
  | _ -> None

let parse_point str : point option =
  match String.split_on_char ' ' str with
  | [ x; y ] -> point_of_strings_opt x y
  | _ -> None

let rec stdin_dispenser () =
  try
    let line = read_line () |> String.trim |> parse_point in
    match line with
    | None ->
        print_string "Invalid input.\n";
        stdin_dispenser ()
    | p -> p
  with End_of_file -> None
