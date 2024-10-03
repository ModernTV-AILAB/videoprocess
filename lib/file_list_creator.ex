defmodule FileListCreator do
  @moduledoc """
  Documentation for `FileListCreator`.

  This module serves to create file list, which is needed for concatenating video files using ffmpeg
  """

  @doc """
    Use this function to generate file_list.txt file containing file format for ffmpeg
    - first arugment is a folder containing the files
    - second is the output, include name of the txt file too (e.g. file_list.txt)

    https://trac.ffmpeg.org/wiki/Concatenate

  """
  def create_file_list(folder, output) do
    folder
    |> list_ts_files()
    |> generate_file_list_content()
    |> write_to_file(output)
  end

  defp list_ts_files(folder) do
    folder
    |> Path.expand()
    |> Path.join("*.ts")
    |> Path.wildcard()
  end

  defp generate_file_list_content(files) do
    files
    |> Enum.map(&"file '#{&1}'")
    |> Enum.join("\n")
  end

  defp write_to_file(content, output) do
    File.write(output, content)
  end
end
