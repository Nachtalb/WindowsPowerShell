$mkv = $args[0]
$mp3_temp = $([io.path]::GetFileNameWithoutExtension($args[0]) + '_temp.mp3')
$mp3 = $([io.path]::GetFileNameWithoutExtension($args[0]) + '.mp3')
$cover_temp = 'cover_temp.jpg'
$cover = 'cover.jpg'

# Convert Mkv To Mp3
write-host "Convert Mkv To Mp3" -foreground "Yellow"
write-host "ffmpeg -i $mkv -vn -c:a libmp3lame $mp3_temp" -foreground "magenta"
ffmpeg -i $mkv -vn -c:a libmp3lame $mp3_temp

# Get image from mkv
write-host "Get image from mkv" -foreground "Yellow"
write-host "ffmpeg -i $mkv -ss 00:00:01 -vframes 1 -q:v 2 $cover_temp" -foreground "magenta"
ffmpeg -i $mkv -ss 00:00:01 -vframes 1 -q:v 2 $cover_temp

# Get dimmensions of this extracted image
$width = convert .\original.jpeg -format "%w" info:
$height = convert .\original.jpeg -format "%w" info:

# which side lenght will the actual cover image have?
if ($height -gt $width -or $height -eq $width) {
    $side_lenght = $width
} elseif ($width -gt $height) {
    $side_lenght = $height
}
$res = $($side_lenght + "x" + $side_lenght)
# crop the extracted image
write-host "crop the extracted image" -foreground "Yellow"
write-host "convert -define jpeg:size=$res $cover_temp -gravity center -extent $res $cover" -foreground "magenta"
convert -define jpeg:size=$res $cover_temp -gravity center -extent $res  $cover
# Add the cover image to the actual mp3
write-host "Add the cover image to the actual mp3" -foreground "Yellow"
write-host "ffmpeg -i $mp3_temp -i $cover -map_metadata 0 -map 0 -map 1 $mp3" -foreground "magenta"
ffmpeg -i $mp3_temp -i $cover -map_metadata 0 -map 0 -map 1 $mp3
# Remove obsolete files
rm $mp3_temp
rm $cover_temp
rm $cover
