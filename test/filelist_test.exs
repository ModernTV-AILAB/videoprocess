defmodule FileListTest do
  use ExUnit.Case

  test "create file list from dir of files" do
    assert FileListCreator.create_file_list(
             [
               "example/video1.ts",
               "example/video2.ts",
               "another/video3.ts"
             ],
             &String.split(&1, "\n")
           ) ==
             ["file 'example/video1.ts'", "file 'example/video2.ts'", "file 'another/video3.ts'"]
  end
end
