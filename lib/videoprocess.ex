defmodule Videoprocess do
  @moduledoc """
    Documentation for `Videoprocess`.

    Wrapper module for ffmpeg providing various video and audio operations

    This module only prepares the command, for running, supply the command to `Runner`
  """

  @doc """
    ffmpeg extract and save video only

    extension matches the input's extension

  ## Parameters
    - video_path: path to input video.
    - out_dir: output directory without filename.
  """
  def save_video(video_path, out_dir) do
    save_video(video_path, out_dir, Path.extname(video_path))
  end

  @doc """
    ffmpeg extract and save video only
    extension matches the input's extension

  ## Parameters
    - video_path: path to input video.
    - out_dir: output directory without filename.
    - extension: (.mp4|.mkv|.avi|.ts|.h264)

  """
  def save_video(video_path, out_dir, extension) do
    "ffmpeg -n -i #{video_path} -map 0:v -c copy #{out_dir}/#{Path.rootname(Path.basename(video_path))}#{extension}"
  end

  @doc """
    ffmpeg extract and save audio only

  ## Parameters
    - video_path: path to input video.
    - out_dir: output directory without filename.
    - extension: (.mp3|.aac|.wav|.ogg)

  """
  def save_audio(video_path, out_dir, extension) do
    "ffmpeg -n -i #{video_path} #{out_dir}/#{Path.rootname(Path.basename(video_path))}#{extension}"
  end

  @doc """
    prepare filename accroding to hash and out folder with extension

  ## Parameters

    - filelist_path: path to file_list.txt.
    - out_path: output concatenated video/audio file (e.g. output.ts/output.mp3).

    input files are: something/1050440-something
    output is: out_folder/1050440.png

  """
  def filepath(path, out_folder, extension \\ ".png") do
    out_folder <> "/" <> Path.rootname(Path.basename(path)) <> "_%04d" <> extension
  end

  @doc """
    split input multimedia into segments of length `time` seconds

  ## Parameters
    - file_path: path to input video/audio.
    - out_dir: output directory without filename.
    - extension: (.mp3|.aac|.wav|.ogg)

  """
  def split_multimedia(file_path, out_folder, time) do
    # "ffmpeg -i #{file_path} -c copy -map 0 -f segment -segment_time #{time} -reset_timestamps 1 #{output_dir}/#{Path.rootname(Path.basename(file_path))}%03d#{Path.extname(file_path)}"
    "ffmpeg -i #{file_path} -c copy -map 0 -f segment -segment_time #{time} -reset_timestamps 1 #{filepath(file_path, out_folder, Path.extname(file_path))}"
  end

  @doc """
    ffmpeg function for concatenating video/audio samples

    create filelist first (see `FileListCreator` module)

    -y is for always overwrite

  ## Parameters

    - filelist_path: path to file_list.txt.
    - out_path: output concatenated video/audio file (e.g. output.ts/output.mp3).

  """
  def concat_multimedia(filelist_path, out_path) do
    "ffmpeg -f concat -safe 0 -i #{filelist_path} -c copy #{out_path} -y"
  end

  @doc """
    ffmpeg extract images from video by specified fps

    supply list of video files

    returns list of commands, suitable to be suplied for `Runner` parallel running

    ## Parameters
    Hash containing:
    - video (list of video files paths)
    - outfolder
    - fps

  """
  def save_images_map(%{video: video_files, outfolder: outfolder, fps: fps}) do
    Enum.map(video_files, fn video ->
      save_images(video, outfolder, fps)
    end)
  end

  def save_images_map(opts) do
    %{fps: 1}
    |> Map.merge(opts)
    |> save_images_map()
  end

  @doc """
    ffmpeg extract images from video by specified fps

    supply the whole video, you may want to use concat function first

  """
  def save_images(video_file, out_folder, fps) do
    path = video_file |> filepath(out_folder, ".png")
    "ffmpeg -i #{video_file} -vf 'fps=#{fps}' #{path}"
  end

  @doc """
    for PCM sampling

  """
  def wav_to_pcm(file_path) do
    # Read the PCM file as binary
    {:ok, binary} = File.read(file_path)

    # Assuming 16-bit PCM, extract amplitudes
    binary
    |> :binary.bin_to_list()
    # Each 16-bit sample is 2 bytes
    |> Enum.chunk_every(2)
    |> Enum.map(fn [high, low] ->
      <<sample::signed-16>> = <<high, low>>
      sample
    end)
  end
end
