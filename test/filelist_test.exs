defmodule FileListTest do
  use ExUnit.Case

  test "create file list from dir of files" do
    FileListCreator.create_file_list("input/one_sample", "input/one_sample/file_list.txt") |> IO.inspect
  end

end

