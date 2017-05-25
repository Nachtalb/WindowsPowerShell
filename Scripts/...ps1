$depth = $args[0]
if (!$depth) {
    $depth = 1
}
1..$depth | % { $path += "../" }
cd $path
