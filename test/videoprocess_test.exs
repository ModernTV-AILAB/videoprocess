defmodule VideoprocessTest do
  use ExUnit.Case

  test "save video command no extension" do
    assert Videoprocess.save_video("tady/videozvuk/video.ts", "tady/videobezzvuk") ==
             "ffmpeg -n -i tady/videozvuk/video.ts -map 0:v -c copy tady/videobezzvuk/video.ts"
  end

  test "save video command" do
    assert Videoprocess.save_video("tady/videozvuk/video.ts", "tady/videobezzvuk", ".mp4") ==
             "ffmpeg -n -i tady/videozvuk/video.ts -map 0:v -c copy tady/videobezzvuk/video.mp4"
  end

  test "save audio command" do
    assert Videoprocess.save_audio("tady/je/video.ts", "tady/mas", ".mp3") ==
             "ffmpeg -n -i tady/je/video.ts tady/mas/video.mp3"
  end

  test "split multimedia" do
    assert Videoprocess.split_multimedia("tady/je/video.ts", "tady/chcisplity", 10) ==
             "ffmpeg -i tady/je/video.ts -c copy -map 0 -f segment -segment_time 10 -reset_timestamps 1 tady/chcisplity/video%03d.ts"
  end

  test "concat multimedia command (video)" do
    assert Videoprocess.concat_multimedia("tady/je/file_list.txt", "tady/chci/concat.ts") ==
             "ffmpeg -f concat -safe 0 -i tady/je/file_list.txt -c copy tady/chci/concat.ts"
  end

  test "prepare filename" do
    assert "testovaci_filename/104040-idk"
           |> Videoprocess.prepare_filename("testovaci/out/folder", ".png") ==
             "testovaci/out/folder/104040_%04d.png"
  end

  test "save images one video" do
    assert Videoprocess.save_images("tady/je/104040-idk", "tam/mas/out", 1) ==
             "ffmpeg -i tady/je/104040-idk -vf 'fps=1' tam/mas/out/104040_%04d.png"
  end

  test "save images more video video" do
    assert Videoprocess.save_images_map(%{
             video: ["tady/je/1-idk.ts", "tady/je/2-idk.ts"],
             outfolder: "tam/mas/out"
           }) ==
             [
               "ffmpeg -i tady/je/1-idk.ts -vf 'fps=1' tam/mas/out/1_%04d.png",
               "ffmpeg -i tady/je/2-idk.ts -vf 'fps=1' tam/mas/out/2_%04d.png"
             ]
  end
end
