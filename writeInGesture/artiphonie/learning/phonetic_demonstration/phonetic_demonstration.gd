extends Control

# Phonetic page is similar to pronouncing, it display a phonetic symbole
# , its borel-maisony picture and a video of the gesture being made

func setup(phonetic: String, picturePath: String, videoPath: String) -> void:
	$background/title.text = "[" + Global.convert_phonetic(phonetic) + "]"
	$background/picture.texture = load(picturePath)
	$background/video_frame/video.stream = load(videoPath)
	$background/video_frame/video.play()
	scale_center_video()

func scale_center_video() -> void:
	var videoTexture: Texture = $background/video_frame/video.get_video_texture()
	var videoSize = Vector2(videoTexture.get_width(), videoTexture.get_height())
	$background/video_frame/video.rect_size = videoSize
	var scale := 1.0
	if max(videoSize.x, videoSize.y) == videoSize.x:
		scale = $background/video_frame/video.rect_min_size.x/videoSize.x
	else:
		scale = $background/video_frame/video.rect_min_size.y/videoSize.y
	$background/video_frame/video.rect_scale = Vector2(scale, scale)
	videoSize *= Vector2(scale, scale)
	$background/video_frame/video.rect_position = $background/video_frame.rect_min_size/2 - videoSize/2

func _on_done_pressed():
	queue_free()

func _on_play_pressed():
	$background/video_frame/video.play()
