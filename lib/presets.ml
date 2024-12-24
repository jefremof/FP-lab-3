open Input
open Utils
open Runners

let linear_interpolate = function
  | [ (x0, y0); (x1, y1) ] ->
      fun x -> ((x -. x0) *. (y1 -. y0) /. (x1 -. x0)) +. y0
  | _ -> failwith "Invalid set of points"

let lagrange_interpolate points =
  let f x =
    List.fold_left
      (fun acc (xi, yi) ->
        acc
        +. yi
           *. List.fold_left
                (fun prod (xj, _) ->
                  if xj = xi then prod else prod *. (x -. xj) /. (xi -. xj))
                1. points)
      0. points
  in
  f

let linear_interpolation =
  { name = "Linear Interpolation"; body = linear_interpolate; window_size = 2 }

let lagrange_interpolation =
  {
    name = "Lagrange Interpolation";
    body = lagrange_interpolate;
    window_size = 4;
  }

module DefaultSettings : Settings = struct
  let step = 1.0
  let stream = Iter.from_fun stdin_dispenser
  let techniques = [ linear_interpolation; lagrange_interpolation ]
end

module DefaultRunner = MakeRunner (DefaultSettings)
