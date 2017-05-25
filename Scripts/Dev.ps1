$base = '~\OneDrive\Development'
switch ($args)
{
    'a' {$ext = '\Android'}
    'c' {$ext = '\C'}
    'j' {$ext = '\JS'}
    'p' {$ext = '\Python'}
    'ja' {$ext = '\Java'}
    'ph' {$ext = '\PHP'}
    default {$ext = ''}
}
cd "$base$ext"
