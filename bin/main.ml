open Fp_lab_3.Runners
open Fp_lab_3.Presets
open Fp_lab_3.Input
open Fp_lab_3.Utils

let usage_msg = "append <step> <method1> [<method2>]"
let step_arg = ref 1.0
let technique_arg = ref []
let anon_fun methodname = technique_arg := methodname :: !technique_arg

let set_step s =
  try step_arg := float_of_string s
  with Failure _ ->
    Printf.eprintf "Error: Step must be a float.\n";
    exit 1

let speclist = [ ("-step", Arg.String set_step, "Discretization step (float)") ]

let execute step techniques =
  let module Runner = MakeRunner (struct
    let step = step
    let techniques = techniques
    let stream = Iter.from_fun stdin_dispenser
  end) in
  Runner.run ()

let () =
  Arg.parse speclist anon_fun usage_msg;
  let f = function
    | "Linear" -> Some linear_interpolation
    | "Lagrange" -> Some lagrange_interpolation
    | _ -> None
  in
  let techniques = Core.List.filter_map !technique_arg ~f in
  let step = !step_arg in
  Printf.printf "Methods:\n";
  List.iter (fun t -> Printf.printf "%s\n\n" t.name) techniques;
  Printf.printf "Step: %f\n\n" step;
  execute step techniques
