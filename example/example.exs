# IO.puts("welcome to examples")

# split ocean data 10 seconds
Videoprocess.split_multimedia("example/input/input01_ocean.ts", "example/output", 10) |> Runner.run_porcelain_command

# create filelist
files = FileListCreator.list_ts_files("example/output") |>IO.inspect
FileListCreator.create_file_list(files, "example/output/filelist/filelist.txt")

# concat split data again
Videoprocess.concat_multimedia("example/output/filelist/filelist.txt", "example/output/concat/concat.ts") |> Runner.run_porcelain_command


# we can save images from one video file
Videoprocess.save_images(Enum.at(files,0), "example/output/images", 1) |> Runner.run_porcelain_command

# extract images from one sample
# we can supply list of files
Videoprocess.save_images_map(%{video: files, outfolder: "example/output/imagesmap", fps: 100}) |> Runner.run_commands_parallel


# extract audio only
Videoprocess.save_audio("example/input/input01_ocean.ts", "example/output/audio", ".wav") |> Runner.run_porcelain_command

# extract video only
Videoprocess.save_video("example/input/input01_ocean.ts", "example/output/video", ".mp4") |> Runner.run_porcelain_command
