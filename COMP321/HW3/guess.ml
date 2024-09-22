
let guess g = 
    let rec guess' low mid high = 
        print_endline (string_of_int mid);
        match read_line () with
        | "lower" -> guess' (low) ((low + mid) / 2) (mid);
                flush stdout;
        | "higher" -> guess' (mid) ((mid + high) / 2) (high);
                flush stdout;
        | _ -> ();
    in guess' 1 g 1001;;

let () = guess 500;;
